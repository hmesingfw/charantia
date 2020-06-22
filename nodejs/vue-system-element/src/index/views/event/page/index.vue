<template>
    <el-row>
        <div class="tenant-title">
            <span class="title">湖南普亿特科技</span>
        </div>
        <el-row class="page-two" :style="{height:treeHeight}">
            <el-col :xl="2" :md="4" class="page-router">
                <el-scrollbar class="scrollbar">
                    <el-tree
                        ref="treeMenu"
                        :data="tableData"
                        :props="{children: 'children',label: 'label'}"
                        :filter-node-method="filterNode"
                        @node-click="data => handleNodeClick(data, 'put')"
                        :default-expand-all="true"
                        :expand-on-click-node="false"
                    ></el-tree>
                </el-scrollbar>
            </el-col>
            <el-col :xl="22" :md="20">
                <el-row class="page-main" :style="{height:treeHeight2}">
                    <el-scrollbar class="scrollbar">
                        <component v-bind:is="componentName" :info="info"></component>
                    </el-scrollbar>
                </el-row>
            </el-col>
        </el-row>
    </el-row>
</template>
<script>
import { GetHeight } from "@/utils/sys";
import comp from './components/index'
export default {
    name: 'TenantInfoDetail',
    components: comp,
    created() {
        this.loadingContent(this.tableData);
        this.id = this.$route.query.id;
        this.init();
    },
    data() {
        return {
            treeHeight: GetHeight(150),
            treeHeight2: GetHeight(180),

            tableData: [{
                label: '活动信息',
                code: 'info',
            }, {
                label: '活动设置',
                code: 'setting',
            }, {
                label: '活动门票',
                code: 'item',
            }, {
                label: '活动收费',
                code: 'ticket',
            }, {
                label: '活动签到',
                code: 'sign',
            }, {
                label: '活动评论',
                code: 'comment',
            }, {
                label: '成员关注',
                code: 'follow',
            }],

            componentName: '',
            id: 0,
            info: {},
        }
    },
    methods: {
        init() {
            this.$http.get(`${this.$api.sys.tenant}/${this.id}`).then(res => {
                this.info = res.data.data;
            });
        },
        /* 点击 */
        handleNodeClick(row) {
            this.componentName = row.code;
        },
        /* 过滤 */
        filterNode(value, data) {
            if (!value) return true;
            return data.title.indexOf(value) !== -1;
        },
        /* 加载右侧面板 */
        loadingContent(tableData) {
            if (!tableData.length > 0) return;
            if (tableData[0].children && tableData[0].children.length > 0) {
                this.handleNodeClick(tableData[0].children[0]);
            } else {
                this.handleNodeClick(tableData[0]);
            }
        },
    },
    watch: {

    }
}
</script>

<style lang="scss">
.tenant-title {
    background: #fff;
    padding-left: 20px;
    line-height: 60px;
    height: 60px;
    .title {
        border-left: 3px solid #3080fe;
        padding-left: 10px;
        font-size: 1.5em;
    }
}
</style>