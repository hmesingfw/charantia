<template>
    <el-row v-loading="tableLoading">
        <div class="title-divider app-main-table">
            <h4 class="info-column-title">{{ info.title }}</h4>
            <el-divider></el-divider>
        </div>
        <div class="vote-class app-main-table" v-for="(vote, vindex) in dataList" :key="vote.id">
            <el-card shadow="always">
                <div class="vote-item-title" slot="header">
                    <el-row style="display: flex;    align-items: center;">
                        <el-col :xl="20" :md="18" class="handles">
                            <el-form :model="vote" label-width="80px" :inline="true">
                                <el-form-item label="参数名称" prop="name">
                                    <el-input v-model="vote.name" autocomplete="off"></el-input>
                                </el-form-item>
                                <el-form-item label="参数标题" prop="title">
                                    <el-input v-model="vote.title" autocomplete="off"></el-input>
                                </el-form-item>
                                <el-form-item label="参数说明" prop="remark">
                                    <el-input v-model="vote.remark" autocomplete="off"></el-input>
                                </el-form-item>

                                <el-form-item label="输入类型" prop="type">
                                    <el-select v-model="vote.type" placeholder="请选择类型">
                                        <el-option label="输入框" value="input"></el-option>
                                        <el-option label="选择框" value="select"></el-option>
                                    </el-select>
                                </el-form-item>
                            </el-form>
                        </el-col>
                        <el-col :xl="4" :md="6">
                            <el-button type="primary" icon="el-icon-top" circle class="button-handle" v-if="vindex != 0" @click="handleMoveUp(dataList, vindex)"></el-button>
                            <el-button type="primary" icon="el-icon-bottom" circle class="button-handle" v-if="vindex != dataList.length-1" @click="handleMoveBottom(dataList, vindex)"></el-button>
                            <el-button icon="el-icon-delete" type="danger" circle class="button-handle" @click="handleDel(dataList, vindex)"></el-button>
                            <el-button type="primary" icon="el-icon-plus" circle style="margin-left:20px" v-if="vindex == dataList.length-1" @click="handleEdit"></el-button>
                        </el-col>
                    </el-row>
                </div>
                <el-row class="card-body" v-if="vote.type == 'select' || vote.type == 'radio' || vote.type == 'checkbox'">
                    <el-col class="vote-item-content" v-for="(voteItem, index) in vote.options" :key="vindex + '+' + index">
                        <div class="vote-item-radio-new">
                            <span>{{ index + 1 }}).</span>
                            <el-input v-model="voteItem.title" maxlength="32" placeholder="请输入选择标题"></el-input>
                            <el-button type="danger" icon="el-icon-delete" circle class="button-handle" v-if="index > 1" @click="handleDel(vote.options, index)"></el-button>
                            <el-button icon="el-icon-plus" v-if="index+1 == vote.options.length" @click="handleaddOption(vote.options)" circle></el-button>
                        </div>
                    </el-col>
                </el-row>
            </el-card>
        </div>
        <div style="text-align: center;width:100%">
            <el-button @click="handleEdit" v-if="dataList.length == 0" type="primary">添加值</el-button>
            <el-button @click="handleUpdate" type="primary">保存</el-button>
        </div>
    </el-row>
</template>
<script>
import { mapState } from 'vuex';
export default {
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        })
    },
    props: {
        info: Object
    },
    data() {
        return {
            apiUrl: this.$api.sys.config,
            form: {},
            rules: {
                code: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                name: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            loadingButton: false,

            dataList: [],               // 整个form数据列表
            optionList: [],             // select 列表
            tempOption: [],
            tableLoading: false,
            requestType: 'put',

            fieldType: [
                { title: '输入文本', value: 'input', },
                // { title: '多选值', value: 'checkbox', },
                { title: '单选值', value: 'radio', },
                // { title: '下拉选择值', value: 'select', },
                // { title: '日期', value: 'time', },
                // { title: '附件', value: 'file', },
            ],
        }
    },
    created() {
        this.query();
    },
    methods: {
        query() {
            let param = {
                category: this.info.value
            };
            this.tableLoading = true;
            this.$http.get(this.apiUrl, {
                params: param
            }).then(res => {
                this.dataList = res.data.data || [{}];
                this.dataList = this.dataList.map(item => {
                    item.options = item.options || [];
                    return {
                        ...item,
                        options: JSON.parse(item.options)
                    }
                })
                if (!this.dataList.length > 0) this.requestType = 'post'
                this.tableLoading = false;
            }).catch(() => {
                this.tableLoading = false;
            });
        },
        /* 保存 */
        async handleUpdate() {
            if (!this.dataList.length > 0) {
                this.HandleDelete(`${this.apiUrl}/${this.info.value}`, {}, this.query);
                return false;
            } else {

                this.loadingButton = true;
                let i = 199, o = 999;
                /* 格式化数据 */
                let arr = this.dataList.map(item => {
                    item.options = item.options || [];
                    let options = item.options.map(opt => ({
                        ...opt,
                        id: o--
                    }))
                    return {
                        ...item,
                        sort: i--,
                        category: this.info.value,
                        options: JSON.stringify(options)
                    }
                })

                if (this.requestType == 'put') {
                    let issucc = await this.$http.put(`${this.apiUrl}/${this.info.value}`, arr);
                    this.$message.success(issucc.data.message);
                } else {
                    let issucc = await this.ReqData(this.apiUrl, arr, this.requestType);
                    if (issucc) this.requestType = 'put'
                }

                this.loadingButton = false;

            }
        },

        handleEdit() {
            this.dataList.push({
                type: 'input',
                options: [{}, {}]
            })
        },
        handleSave() {
            this.dataList.push(this.form);
        },

        handleDel(arr, i) {
            arr.splice(i, 1);

        },
        handleMoveUp(arr, i) {
            let obj = this.DeepCopy(arr[i]);
            arr.splice(i, 1);
            arr.splice(i - 1, 0, obj);
        },
        handleMoveBottom(arr, i) {
            let obj = this.DeepCopy(arr[i]);
            arr.splice(i, 1);
            arr.splice(i + 1, 0, obj);
        },

        /* select 选择内容 */
        handleaddOption(item) {
            this.tempOption = item;
            if (!item.options) {
                this.$set(item, 'options', [{ title: '' }]);
            } else {
                item.options.push({ title: '' })
            }
        },

    }
}
</script>

<style lang="scss">
// .config-table {
//     .el-input {
//         width: 280px;
//     }
// }
// .config-option {
//     .el-input {
//         width: 200px;
//     }
// }
</style>


<style lang="scss">
.title-divider {
    padding: 0px 20px;
}
.vote-class {
    margin-bottom: 10px;

    .el-card__header {
        padding: 16px 60px 16px 20px;
    }
    .el-card__body {
        padding: 0;
    }
    .card-body {
        padding: 10px;
    }
    .vote-item-title {
        padding-right: 20px;
        .el-form-item {
            margin-bottom: 8px;
        }
        .handles {
            padding-right: 10px;
            padding-left: 10px;
            .el-select {
                margin-right: 20px;
                width: 200px;
                .el-input {
                    width: 200px;
                }
            }
            .el-input {
                width: 300px;
                margin-right: 20px;
            }
        }

        .button-handle {
            margin-left: 20px;
        }
    }
    .vote-item-content {
        padding: 10px 74px;
        .avatar-uploader {
            display: flex;
            justify-content: center;
            height: 120px;

            .avatar-uploader-icon {
                font-size: 28px;
                color: #8c939d;
                width: 118px;
                height: 118px;
                line-height: 118px;
                text-align: center;
            }
        }

        .vote-item-index {
            margin-top: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;

            span {
                padding-right: 6px;
            }
            i {
                cursor: pointer;
                padding-left: 10px;
            }
        }
    }

    .vote-item-add {
        line-height: 260px;
        height: 260px;
        position: relative;
        .el-button {
            width: 40px;
            height: 40px;
            margin: 0 auto;
        }
    }
}
.vote-item-radio-new {
    display: flex;
    align-items: center;
    img {
        height: 60px;
        width: 70px;
    }

    .el-input {
        width: 560px;
        margin: 0 10px;
    }
    @media screen and (max-width: 1400px) {
        .el-input {
            width: 460px;
        }
    }
    .el-upload {
        margin-right: 10px;
    }

    .el-button {
        padding: 6px;
    }
}
</style>