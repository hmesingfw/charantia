<template>
    <div>
        <el-row class="page-main" :style="{height:treeHeight2}" v-loading="tableLoading">
            <el-scrollbar class="scrollbar">
                <slot></slot>
                <div class="vote-class app-main-table" v-for="(vote, vindex) in voteItemList" :key="vote.id">
                    <el-card shadow="always">
                        <div class="vote-item-title" slot="header">
                            <div class="handles">
                                <el-input v-model="vote.fieldCname" placeholder="请输入标题" maxlength="6" show-word-limit></el-input>

                                <el-select v-model="vote.fieldType">
                                    <el-option v-for="item in enumList.CUSTOM_PAGE_TYPE" :key="item.value" :label="item.title" :value="item.value"></el-option>
                                </el-select>
                                <el-checkbox v-model="vote.isMust" :true-label="1" :false-label="0">必填</el-checkbox>
                            </div>
                            <div>
                                <el-button type="primary" icon="el-icon-plus" circle style="margin-left:20px" v-if="vindex == voteItemList.length-1" @click="handleAddVote"></el-button>
                                <el-button type="primary" icon="el-icon-top" circle class="button-handle" v-if="vindex != 0" @click="handleMoveUp(voteItemList, vindex)"></el-button>
                                <el-button type="primary" icon="el-icon-bottom" circle class="button-handle" v-if="vindex != voteItemList.length-1" @click="handleMoveBottom(voteItemList, vindex)"></el-button>
                                <el-button icon="el-icon-delete" type="danger" circle class="button-handle" @click="handleDeleteVote(voteItemList, vindex)"></el-button>
                            </div>
                        </div>
                        <el-row class="card-body" v-if="[2,3,4].includes(vote.fieldType)">
                            <el-col class="vote-item-content" v-for="(voteItem, index) in vote.fieldOption" :key="vindex + '+' + index">
                                <div class="vote-item-radio-new">
                                    <el-input v-model="voteItem.fieldCname" maxlength="32" placeholder="请输入选项标题"></el-input>
                                    <el-button type="danger" icon="el-icon-delete" circle class="button-handle" v-if="index > 1" @click="handleDeleteVote(vote.fieldOption, index)"></el-button>
                                    <el-button icon="el-icon-plus" v-if="index+1 == vote.fieldOption.length" @click="handleAddVoteItem(vote.fieldOption)" circle></el-button>
                                </div>
                            </el-col>
                        </el-row>
                    </el-card>
                </div>
                <div class="app-main-table" style="margin:0 14px;" v-if="!voteItemList || voteItemList.length == 0">
                    <div class="header-query-form" style="padding-top: 0px; justify-content: center;min-height: 100px;padding-right: 40px;">
                        <el-button type="primary" @click="handleAddVote">添加字段</el-button>
                    </div>
                </div>
            </el-scrollbar>
        </el-row>
        <div class="app-main-table" style="margin:0 14px;" v-if="voteItemList && voteItemList.length > 0">
            <div class="header-query-form" style="padding-top: 0px; justify-content: center;min-height: 60px;padding-right: 40px;">
                <el-button @click="handleUpdate" type="primary">保存</el-button>
            </div>
        </div>
    </div>
</template>
<script>
import { GetHeight } from "@/utils/sys";
import { mapGetters } from 'vuex'
export default {
    computed: {
        ...mapGetters({
            enumList: 'enumList',
        })
    },
    props: {
        target: { type: Object }
    },
    watch: {
        target: {
            handler() {
                this.init();
            },
            deep: true,
        },
    },
    data() {
        return {
            treeHeight2: GetHeight(230),
            apiUrl: this.$api.member.customForm,
            voteItemList: [{
                title: '请输入标签',
                isMust: false,
                fieldType: 1,
                fieldOption: [{}, {}]
            }],
            tableLoading: false,
            fileTemp: '',

            delDateTemp: [],        //  只用于删除全部数据时使用
        }
    },
    created() {
        this.init();
    },
    methods: {
        init() {
            this.tableLoading = true;
            this.$http.get(this.apiUrl, { params: { ...this.target } }).then(res => {
                let arr = res.data.data;
                this.delDateTemp = arr;

                let list = arr.map(item => {
                    let fieldOption = [];
                    try {
                        fieldOption = JSON.parse(item.fieldOption);
                    } catch (error) {
                        fieldOption = [];
                    }
                    return {
                        ...item,
                        fieldOption
                    }
                })
                this.voteItemList = list;
                this.tableLoading = false;
            })

        },
        /* 添加主题 */
        handleAddVote() {
            this.voteItemList.push({
                fieldCname: '',
                fieldType: 1,
                fieldOption: [{ fieldCname: '' }, { fieldCname: '' }],
            })
        },
        /* 添加主题选项 */
        handleAddVoteItem(list) {
            list.push({ fieldCname: '' });
        },


        /* 删除 */
        handleDeleteVote(arr, i) {
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
        /* 保存数据 */
        async handleUpdate() {
            this.tableLoading = true;

            if (this.voteItemList && this.voteItemList.length > 0) {

                /* 整理成后台需要的数据格式 */
                let i = this.voteItemList.length + 1;
                let arr = this.voteItemList.map(item => {
                    /* 处理options 的值 */
                    let optI = 1;
                    let options = item.fieldOption.map(item => {
                        return {
                            ...item,
                            id: optI++ + '',
                        }
                    })

                    let fieldOption = JSON.stringify(options);
                    return {
                        ...item,
                        ...this.target,
                        fieldOption,
                        sort: i--,
                        fieldName: 'field' + i,
                    }
                })
                let res = await this.$http.put(`${this.apiUrl}/${this.target.target}/${this.target.targetId}`, arr);
                this.$message.success(res.data.message);

                this.tableLoading = false;
            } else {
                let idArr = this.delDateTemp.map(item => item.id);
                let ids = idArr.join(',');
                this.$http.delete(`${this.apiUrl}/${ids}`).then(res => {
                    this.$message.success(res.data.message);
                })

                this.tableLoading = false;
            }

        },
    },
}
</script>

<style lang="scss">
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
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-right: 20px;
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
                width: 460px;
                margin-right: 20px;
            }
            @media screen and (max-width: 1400px) {
                .el-select {
                    margin-right: 20px;
                    width: 160px;
                    .el-input {
                        width: 160px;
                    }
                }
                .el-input {
                    width: 260px;
                    margin-right: 20px;
                }
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