<template>
    <dialog-model v-model="value" title="投票信息" width="500px" @submit="handleUpdate" :loading-button="loadingButton" @colse="colse" :isColse="false" @changeLoadingButton="loadingButton = false">
        <div class="feeds-message-content">
            <div :style="{height:tableHeightDetail}">
                <el-scrollbar :style="{height:tableHeightDetail}">
                    <div v-infinite-scroll="loadDetail" infinite-scroll-disabled="disabled" infinite-scroll-distance="40">
                        <div v-for="(item,i) in drawerMessageData" :key="item.id" class="infinite-list-item">
                            <el-card class="box-card">
                                <div slot="header" class="clearfix">
                                    <el-image :src="item.avatar ? baseFile + item.avatar : touxiang" class="image" fit="cover">
                                        <div slot="placeholder" class="image-slot">
                                            加载中
                                            <span class="dot">...</span>
                                        </div>
                                    </el-image>
                                    <span class="name">{{ item.realName}}</span>
                                </div>
                                <div class="message-content">
                                    <div class="content">{{item.content}}</div>
                                    <el-row>
                                        <el-col :span="8" v-for="(file, i) in getImage(item.imeags)" :key="i" style="padding:4px;">
                                            <el-image style="width:200px;height:180px;" :src="baseFile + file.url" fit="cover" :preview-src-list="getFileUrl(getImage(item.imeags))"></el-image>
                                        </el-col>
                                    </el-row>
                                    <div style="display: flex;justify-content: space-between;">
                                        <div class="font-color font-size-14">{{ item.createTime }}</div>
                                        <div class="font-size-14" style="cursor: pointer;color:#409efe" @click="handleDeleteDetail(item,i)">删除</div>
                                    </div>
                                </div>
                            </el-card>
                            <!-- <span>{{ forFindValue(userTypeList, 'id', item.userLevel, 'title', {returnStr:'会员'}) }}</span> -->
                            <div class="solid"></div>
                        </div>
                        <p v-if="loadingInfinite" style="text-align: center;">加载中...</p>
                        <p v-if="noMoreInfinite" style="text-align: center;">没有更多了</p>
                    </div>
                </el-scrollbar>
            </div>
        </div>
    </dialog-model>
</template>
<script>
import { mapState } from 'vuex';
import { GetHeight } from '@/utils/sys';

export default {
    components: {
    },
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        }),
        disabled() {
            return this.loadingInfinite || this.noMoreInfinite;
        }
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
            rules: {
                code: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                name: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            loadingButton: false,
            tableHeightDetail: GetHeight(140), // 列表高度       
            drawerMessageData: [],

            /* 滚动进度条 */
            loadingInfinite: false,
            noMoreInfinite: false,
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
        },
        query() { },
        /* 无限滚动 */
        loadDetail() {
            this.query();
        },
        /* 解析图片内容 */
        getImage(imeags) {
            if (imeags && imeags.length > 0) {
                let list = eval('(' + imeags + ')');
                /* 过滤空 null */
                return list.filter(item => {
                    return item;
                });
            } else {
                return [];
            }
        },
    }
}
</script>
<style lang="scss">
.feeds-message-content {
    .el-scrollbar__wrap {
        overflow-x: hidden;
    }
    .menn {
        position: relative;
        .delete {
            position: absolute;
            right: 10px;
            top: 10px;
            cursor: pointer;
        }
    }
    .infinite-list-item {
        padding: 10px 20px;

        .clearfix {
            display: flex;
            align-items: center;
        }

        .image {
            margin-left: 4px;
            margin-right: 4px;
            width: 60px;
            height: 40px;
            img {
                border-radius: 4px;
            }
        }

        .message-content {
            margin-bottom: 10px;
            padding-left: 10px;
        }
        .name {
            font-size: 22px;

            span {
                color: #fff;
                background: rgb(255, 92, 97);
                border-radius: 6px;
                font-size: 18px;
            }
        }
        .content {
            margin-bottom: 4px;
            font-size: 16px;
        }
    }

    .solid {
        border-bottom: 1px solid #eee;
        margin-left: 8.333%;
        width: 91%;
    }

    .font-size-14 {
        font-size: 14px;
        padding-top: 10px;
    }
}
</style>