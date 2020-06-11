<template>
    <el-row class="page-two" :style="{height:treeHeight}" :gutter="4">
        <el-col :span="4" class="page-router">
            <el-tree
                ref="treeMenu"
                :data="tableData"
                :props="{children: 'children',label: 'label'}"
                :filter-node-method="filterNode"
                @node-click="data => handleNodeClick(data, 'put')"
                :default-expand-all="true"
                :expand-on-click-node="false"
            ></el-tree>
        </el-col>
        <el-col :span="20">
            <el-row class="page-main" :style="{height:treeHeight2}">
                <el-scrollbar class="scrollbar">
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                    <div>1</div>
                </el-scrollbar>
            </el-row>
        </el-col>
    </el-row>
</template>
<script>
import { GetHeight } from "@/utils/sys";
export default {
    data() {
        return {
            treeHeight: GetHeight(90),
            treeHeight2: GetHeight(130),

            tableData: [{
                label: '一级 1',
                children: [{
                    label: '二级 1-1',
                }]
            }, {
                label: '一级 2',
            }, {
                label: '一级 2',
            }, {
                label: '一级 2',
            }, {
                label: '一级 2',
            }, {
                label: '一级 2',
            },],
        }
    },
    methods: {
        handleNodeClick(row = { sort: 1, status: '0', parentId: '0', show: '0' }, requestType = 'post') {
            this.formLoading = true;
            this.form = this.DeepCopy(row);
            this.requestType = requestType;
            this.formLoading = false;
        },
        filterNode(value, data) {
            if (!value) return true;
            return data.title.indexOf(value) !== -1;
        }
    }
}
</script>

<style lang="scss">
.page-two {
    padding: 20px;
    .page-router {
        height: 100%;
        .el-tree {
            height: 100%;
            padding: 20px;
        }
    }
    .page-main {
        position: relative;
        width: 100%;
        background: #fff;

        .el-scrollbar__wrap {
            overflow-x: hidden;
        }
        .scrollbar {
            height: 100%;
        }
    }
}
</style>