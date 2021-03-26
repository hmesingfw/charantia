<template>
    <dialog-model v-model="value" title="标签" width="600" @submit="handleUpdate" :loading-button="loadingButton" @colse="colse" @changeLoadingButton="loadingButton = false">
        <el-row :style="{height:treeHeight}" v-loading="tableLoading">
            <el-scrollbar class="scrollbar">
                <el-row class="s-tag-main">
                    <el-button type="primary" @click="handleClear(child)" style="margin-left:20px">清除选择</el-button>
                </el-row>
                <el-row v-for="item in tagList" :key="item.id" class="s-tag-main">
                    <span class="info-column-title" :style="{color:item.color}">{{ item.title }}</span>
                    <el-row class="tag-group">
                        <div
                            v-for="child in item.children"
                            :key="child.id"
                            class="tag-item"
                            :style="saveTagListId.includes(child.id) ? {color:'#fff',background:child.color} : {color:child.color,borderColor:child.color}"
                        >
                            <span @click="handleEdit(child)">{{ child.title }}</span>
                        </div>
                    </el-row>
                </el-row>
            </el-scrollbar>
        </el-row>
    </dialog-model>
</template>
<script>
import { GetHeight } from "@/utils/sys";
import { mapState, mapGetters } from 'vuex';

export default {
    props: {
        value: { type: [Boolean, String] },
        list: { type: Array, default: () => [] },       // 获取数据保存的标签数据 

        dataUrl: {
            type: String,
            default() {
                return this.$api.sys.tag
            }
        },      //  数据库中标签数据 的查询地址
        target: { type: Object, default: () => ({ key: 'event', id: 'eventId' }) },         // 保存标签到某模块
    },
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        }),
        ...mapGetters({
            userInfo: 'info'
        })
    },
    // watch: {
    //     list(val) {
    //         this.initVal(val);
    //     },
    // },
    data() {
        return {
            treeHeight: GetHeight(150),

            rules: {
                name: [{ required: true, message: '请输入姓名', trigger: 'blur' },],
                mobile: [{ required: true, message: '请输入手机号', trigger: 'blur' },],
            },
            loadingButton: false,
            tableLoading: false,
            tagList: [],
            saveTagList: [],        //  选中tag  
            saveTagListId: [],        //  选中tag  
        }
    },
    mounted() {
        this.init();
        this.initVal(this.list);
    },
    methods: {
        // 初始化选中的
        initVal(val) {
            this.saveTagList = val;
            this.saveTagListId = val.map(item => item.id);
        },
        init() {
            /* 查询tab列表信息 */

            this.tableLoading = true;
            let from = {
                tagTarget: this.target.key,
                tenantId: this.userInfo.id,
            }
            this.$http.get(this.dataUrl, { params: from }).then(res => {
                let array = res.data.data || [];
                this.tagList = array;
                this.tableLoading = false;
            }).catch(() => {
                this.tableLoading = false;
            });
        },
        handleEdit(row) {
            if (this.saveTagListId.includes(row.id)) {
                this.saveTagListId = this.saveTagListId.filter(item => {
                    return item != row.id
                })

                this.saveTagList = this.saveTagList.filter(item => {
                    return item.id != row.id
                })
            } else {
                this.saveTagListId.push(row.id);

                this.saveTagList.push(row);
            }
        },
        /* 保存 */
        async handleUpdate() {
            this.$emit('callback', this.saveTagList);
            this.$emit('suc', false);
            this.$emit('input', false);
        },
        colse() {
            this.$emit('suc', false);
            this.$emit('input', false);
        },
        handleClear() {
            this.saveTagListId = [];
            this.saveTagList = [];
        },
    },
}
</script>

<style lang="scss">
.s-tag-main {
    margin-bottom: 30px;

    .info-column-title {
        font-size: 20px;
    }
    .tag-group {
        padding-top: 10px;
        padding-left: 20px;

        .tag-item {
            display: inline-flex;
            margin: 0 10px 6px;
            padding: 0 8px;
            align-items: center;
            line-height: 24px;
            border: 1px solid;
            border-radius: 4px;
            box-sizing: border-box;
            white-space: nowrap;
            font-size: 12px;
            cursor: pointer;
            span {
                padding: 0 2px;
            }
        }

        .el-tag + .el-tag {
            margin-left: 10px;
        }
        .button-new-tag {
            margin-left: 10px;
            height: 32px;
            line-height: 30px;
            padding-top: 0;
            padding-bottom: 0;
        }
        .input-new-tag {
            width: 90px;
            margin-left: 10px;
        }
    }
}
</style>