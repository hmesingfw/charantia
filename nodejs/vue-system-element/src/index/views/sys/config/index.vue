<template>
    <el-row class="page-two" :style="{height:treeHeight}">
        <el-col :xl="2" :md="4" class="page-router">
            <el-scrollbar class="scrollbar">
                <el-tree
                    ref="treeMenu"
                    :data="CONFIG_TYPE"
                    :props="{children: 'children',label: 'title'}"
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
                    <official :info="codeName" v-if="flashComponent"></official>
                </el-scrollbar>
            </el-row>
        </el-col>
    </el-row>
</template>
<script>
import { mapState } from 'vuex';
import { GetHeight } from "@/utils/sys";
import official from './official'
export default {
    components: {
        official
    },
    created() {
        this.loadingContent(this.CONFIG_TYPE);
    },
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
            regType: state => state.enumList.data.regType,
            CONFIG_TYPE: state => state.enumList.data.CONFIG_TYPE,
        })
    },
    data() {
        return {
            treeHeight: GetHeight(90),
            treeHeight2: GetHeight(130),

            codeName: '',
            flashComponent: true,
        }
    },
    methods: {
        /* 点击 */
        handleNodeClick(row) {
            this.flashComponent = false;
            this.$nextTick(() => {
                this.flashComponent = true;
            })
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
