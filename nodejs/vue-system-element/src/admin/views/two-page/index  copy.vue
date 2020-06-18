<template>
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
                <el-scrollbar class="scrollbar"></el-scrollbar>
            </el-row>
        </el-col>
    </el-row>
</template>
<script>
import { GetHeight } from "@/utils/sys";
export default {
    components: {
    },
    created() {
        this.loadingContent(this.tableData);
    },
    data() {
        return {
            treeHeight: GetHeight(90),
            treeHeight2: GetHeight(130),
            tableData: [{
                label: '公众号配置',
                code: 'info',
            }, {
                label: '小程序配置',
                code: 'settings',
            }, {
                label: '支付配置',
                code: 'pay'
            }],

            componentName: '',
        }
    },
    methods: {
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
}
</script>
