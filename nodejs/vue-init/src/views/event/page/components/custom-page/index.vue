<template>
    <div>
        <div class="vote-class app-main-table" v-for="(vote, vindex) in voteItemList" :key="vote.id">
            <el-card shadow="always">
                <div class="vote-item-title" slot="header">
                    <div class="handles">
                        <span>标题：</span>
                        <el-input v-model="vote.title" placeholder="请输入选项标题" maxlength="32"></el-input>

                        <el-select v-model="vote.fieldType">
                            <el-option v-for="item in fieldType" :key="item.value" :label="item.title" :value="item.value"></el-option>
                        </el-select>
                        <el-checkbox v-model="vote.optionType" :true-label="0" :false-label="1">必填</el-checkbox>
                    </div>
                    <div>
                        <el-button type="primary" icon="el-icon-top" circle class="button-handle" v-if="vindex != 0" @click="handleMoveUp(voteItemList, vindex)"></el-button>
                        <el-button type="primary" icon="el-icon-bottom" circle class="button-handle" v-if="vindex != voteItemList.length-1" @click="handleMoveBottom(voteItemList, vindex)"></el-button>
                        <el-button icon="el-icon-delete" type="danger" circle class="button-handle" @click="handleDeleteVote(voteItemList, vindex)"></el-button>
                        <el-button type="primary" icon="el-icon-plus" circle style="margin-left:20px" v-if="vindex == voteItemList.length-1" @click="handleAddVote"></el-button>
                    </div>
                </div>
                <el-row class="card-body" v-if="vote.fieldType == 'select' || vote.fieldType == 'radio' || vote.fieldType == 'checkbox'">
                    <el-col class="vote-item-content" v-for="(voteItem, index) in vote.options" :key="vindex + '+' + index">
                        <div class="vote-item-radio-new">
                            <span>{{ index + 1 }}).</span>
                            <el-input v-model="voteItem.title" maxlength="32" placeholder="请输入选择标题"></el-input>
                            <el-button type="danger" icon="el-icon-delete" circle class="button-handle" v-if="index > 1" @click="handleDeleteVote(vote.options, index)"></el-button>
                            <el-button icon="el-icon-plus" v-if="index+1 == vote.options.length" @click="handleAddVoteItem(vote.options)" circle></el-button>
                        </div>
                    </el-col>
                </el-row>
            </el-card>
        </div>
        <div style="text-align: center;width:100%">
            <el-button @click="handleAddVote" type="primary">保存</el-button>
        </div>
    </div>
</template>
<script>
export default {
    data() {
        return {
            fileUpload: 'url',
            voteItemList: [{
                title: '投票',
                optionType: true,
                fieldType: 'input',
                options: [{}, {}]
            }],

            fileTemp: '',


            fieldType: [
                { title: '输入文本', value: 'input', },
                { title: '多选值', value: 'checkbox', },
                { title: '单选值', value: 'radio', },
                { title: '下拉选择值', value: 'select', },
                { title: '日期', value: 'time', },
                { title: '附件', value: 'file', },
            ],
        }
    },
    methods: {
        /* 添加主题 */
        handleAddVote() {
            this.voteItemList.push({
                fieldType: 'input',
                options: [{}, {}],
            })
        },
        /* 添加主题选项 */
        handleAddVoteItem(list) {
            list.push({ title: '' });
        },

        /* 上传时的钩子, 上传的途中将图片对象赋予filetemp */
        handleAvatarProgress(obj) {
            this.fileTemp = obj;
        },
        handleAvatarSuccessItem() { },
        beforeAvatarUpload() { },
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