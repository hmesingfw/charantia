<template>
    <el-row class="page-two" :style="{height:treeHeight}">
        <el-col :xl="3" :md="4" class="page-router">
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
        <el-col :xl="21" :md="20">
            <el-row class="page-main" :style="{height:treeHeight2}">
                <el-scrollbar class="scrollbar">
                    <edit :info="codeName"></edit>
                </el-scrollbar>
            </el-row>
        </el-col>
    </el-row>
</template>
<script>
import { GetHeight } from "@/utils/sys";
import { mapGetters } from 'vuex';
import edit from './edit'
export default {
    components: {
        edit
    },
    computed: {
        ...mapGetters({
            enumList: 'enumList',
        })
    },
    created() {
        this.init();

    },

    data() {
        return {
            treeHeight: GetHeight(90),
            treeHeight2: GetHeight(130),
            tableData: [],

            codeName: {},
        }
    },
    methods: {
        async init() {
            let dis = ['ABOUT_US', 'SINGLE_PAGE_GROUP'];

            let treeList = [];
            /* 第一级标题 */
            let res = await this.$http.get(this.$api.sys.enum);
            res.data.data.list.forEach(item => {
                if (dis.includes(item.dictCode)) {
                    treeList.push({
                        label: item.dictName,
                        code: item.dictCode,
                        children: []
                    })
                }
            });
            /* 第二级标题 */
            let enumDetail = await this.$http.get(this.$api.sys.enumDetailList);
            enumDetail.data.data.forEach(item => {
                treeList.forEach(obj => {
                    if (obj.code == item.dictCode) {
                        obj.children.push({ ...item, label: item.itemLabel });
                    }
                })
            });
            this.tableData = treeList;

            this.loadingContent(this.tableData);
        },
        /* 点击 */
        handleNodeClick(row) {
            this.codeName = row;

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
