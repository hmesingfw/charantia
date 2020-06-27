<template>
    <dialog-model v-model="value" title="投票信息" width="800" @submit="handleUpdate" :loading-button="loadingButton" @colse="colse" :isColse="false" @changeLoadingButton="loadingButton = false">
        <el-row :style="{height:treeHeight}">
            <el-scrollbar class="scrollbar">
                <el-row class="vote-item-detail">
                    <el-row v-for="i in 10" :key="i">
                        <el-col class="item-title">
                            <span class="title-name">1.那位歌手能获得本次冠军</span>
                        </el-col>
                        <el-col class="item-option">
                            <el-radio></el-radio>
                            <div>
                                <el-image src="https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg" fit="contain" class="img"></el-image>
                            </div>
                            <span class="title">1).张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友张学友</span>
                        </el-col>
                        <el-col class="item-option">
                            <el-radio :value="false"></el-radio>
                            <div>
                                <el-image src="https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg" fit="contain" class="img"></el-image>
                            </div>
                            <span class="title">2).刘德华</span>
                        </el-col>
                        <el-col class="item-option">
                            <el-checkbox :value="true"></el-checkbox>

                            <div>
                                <el-image src="https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg" fit="contain" class="img"></el-image>
                            </div>
                            <span class="title">3).郭富城</span>
                        </el-col>
                        <el-col class="item-option">
                            <el-checkbox :value="false"></el-checkbox>

                            <div>
                                <el-image src="https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg" fit="contain" class="img"></el-image>
                            </div>
                            <span class="title">4).黎明</span>
                        </el-col>
                    </el-row>
                </el-row>
            </el-scrollbar>
        </el-row>
    </dialog-model>
</template>
<script>
import { GetHeight } from "@/utils/sys";

import { mapState } from 'vuex';
export default {
    components: {
    },
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        })
    },
    props: {
        value: { type: [Boolean, String] },
        form: Object,
        requestType: String,
        callback: Function,
        url: String,
    },
    data() {
        return {
            treeHeight: GetHeight(150),

            rules: {
                code: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                name: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            loadingButton: false,

            radioTure: true,
            radioFalse: false,

        }
    },
    methods: {
        /* 保存 */
        async handleUpdate() {
            this.$refs.ruleForm.validate(async valid => {
                if (valid) {
                    this.loadingButton = true;
                    let issucc = await this.ReqData(this.url, this.form, this.requestType);
                    if (issucc) {

                        this.callback();
                        this.$emit('input', false);
                    }
                    this.loadingButton = false;
                }
            });
        },
        colse() {
            this.$emit('input', false);
        }
    }
}
</script>
<style lang="scss">
.vote-item-detail {
    .item-title {
        background: #fff;
        padding-left: 20px;
        line-height: 60px;
        height: 60px;
        .title-name {
            border-left: 3px solid #3080fe;
            padding-left: 10px;
            font-size: 1.5em;
        }
    }

    .item-option {
        padding-left: 50px;
        display: flex;
        align-items: center;

        .title {
            padding-left: 20px;
        }

        .img {
            width: 120px;
            height: 80px;
        }

        .el-checkbox {
            margin-right: 30px;
        }

        .el-radio {
            margin-right: 20px;
        }
    }
}
</style>