<template>
    <el-row :style="{height:treeHeight}" class="page-two">
        <el-col :sm="2" :xs="4" class="page-router">
            <el-scrollbar class="scrollbar">
                <el-tree
                    ref="treeMenu"
                    :data="MODULE_TYPE"
                    :props="{children: 'children',label: 'title'}"
                    @node-click="data => handleNodeClick(data)"
                    :default-expand-all="true"
                    :expand-on-click-node="false"
                    :highlight-current="true"
                ></el-tree>
            </el-scrollbar>
        </el-col>
        <el-col :sm="22" :xs="20" class="tag-main">
            <list :data="datainfo"></list>
        </el-col>
    </el-row>
</template>

<script>
import { GetHeight } from "@/utils/sys";
import { mapState, mapGetters } from 'vuex'
import list from './list'
export default {
    components: { list },
    computed: {
        ...mapState({
            MODULE_TYPE: state => state.enumList.static.MODULE_TYPE,
        }),
        ...mapGetters({
            info: 'info',
            enumList: 'enumList'
        })
    },
    data() {
        return {
            treeHeight: GetHeight(90),
            datainfo: {},
        };
    },
    created() {
        console.log(this.MODULE_TYPE);
        this.queryTag(this.MODULE_TYPE[0]);
    },
    methods: {
        /* 到这里基本不变----------- */
        handleNodeClick(data) {
            this.queryTag(data);
        },
        queryTag(data) {
            this.datainfo = data;
        }
    }
};

</script>

<style lang="scss">
.tag-main {
    height: 100%;
    .el-scrollbar__wrap {
        overflow-x: hidden;
    }
    .scrollbar {
        height: 100%;
    }
}
</style>