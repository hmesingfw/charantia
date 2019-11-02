<template>
    <el-tree ref="permissionTreeRef" :data="tableData" show-checkbox node-key="id" :default-expand-all="true" :default-checked-keys="value" :props="defaultProps" :check-strictly="true"></el-tree>
</template>

<script>
import { ErrorLog } from "@/utils/sys";
import api from "@/config/api";
export default {
    props: {
        value: {
            type: [Array],
            default: function () {
                return []
            }
        }, // 已有权限
    },
    data() {
        return {
            tableData: [],
            defaultProps: {
                children: 'children',
                label: 'name'
            }
        };
    },
    created() {
        this.$http.post(api.sys.syspermissionList, {
            page: 1,
            size: 1000
        }).then(res => {

            let data = res.data.data;
            this.tableData = data.list;
            this.tableDataTemp = data.list;
        }).catch(err => {
            ErrorLog.error(err);
        });
    },
    methods: {
        /* 获取选中的节点 */
        getCheckedKeys() {
            return this.$refs.permissionTreeRef.getCheckedNodes(false, true);
        },
    },
};

</script>
