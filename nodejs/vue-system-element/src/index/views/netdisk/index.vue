<template>
    <el-row class="netdisk">
        <div class="netdisk-tabs">
            <el-tabs v-model="activeName" @tab-click="handleClick">
                <el-tab-pane label="个人网盘" name="first"></el-tab-pane>
                <el-tab-pane label="公共网盘" name="second"></el-tab-pane>
                <el-tab-pane label="OA办公" name="oa"></el-tab-pane>
            </el-tabs>
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
                        :highlight-current="true"
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
            treeHeight: GetHeight(160),
            treeHeight2: GetHeight(180),

            tableData: [{
                label: '文档',
                code: 'list',
            }, {
                label: '图片',
                code: 'list',
            }, {
                label: '其它',
                code: 'list',
            },],

            componentName: '',
            id: 0,
            info: {},

            activeName: 'first',
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

        handleClick() {

        },
    },
    watch: {

    }
}
</script>

<style lang="scss">
.netdisk {
    .netdisk-tabs {
        padding: 14px;
        border-radius: 4px;
        border: 1px solid #e6ebf5;
        background-color: #fff;
        overflow: hidden;
        color: #303133;
        -webkit-transition: 0.3s;
        transition: 0.3s;

        .el-tabs__header {
            margin: 0;
        }
        .el-tabs__nav-scroll {
            padding-left: 40px;
        }
    }
}
</style>