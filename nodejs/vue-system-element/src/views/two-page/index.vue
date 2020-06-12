<template>
    <el-row class="page-two" :style="{height:treeHeight}">
        <el-col :span="4" class="page-router">
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
        <el-col :span="20">
            <el-row class="page-main" :style="{height:treeHeight2}">
                <el-scrollbar class="scrollbar">
                    <component v-bind:is="componentName"></component>
                </el-scrollbar>
            </el-row>
        </el-col>
    </el-row>
</template>
<script>
import { GetHeight } from "@/utils/sys";
import comp from './components'
export default {
    components: comp,
    created() {
        this.loadingContent(this.tableData);
    },
    data() {
        return {
            treeHeight: GetHeight(90),
            treeHeight2: GetHeight(130),

            tableData: [{
                label: '角色管理',
                code: 'SysRole',
            }, {
                label: '角色管理',
                code: 'SysUser',
            }
            ],

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
    watch: {
        tableData: {
            handler(val) {
                this.loadingContent(val);
            },
            deep: true//对象内部的属性监听，也叫深度监听
        },
    }
}
</script>

<style lang="scss">
.page-two {
    padding: 4px;
    .page-router {
        height: 100%;
        background: #fff;

        .el-scrollbar__wrap {
            overflow-x: hidden;
        }
        .scrollbar {
            height: 100%;
        }

        .el-tree {
            height: 100%;
            padding: 20px;
        }
    }
    .page-main {
        position: relative;
        width: 100%;

        .el-scrollbar__wrap {
            overflow-x: hidden;
        }
        .scrollbar {
            height: 100%;
        }
    }
}
</style>