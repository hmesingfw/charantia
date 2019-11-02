<template>
    <el-transfer filterable :filter-method="filterMethod" filter-placeholder="请输入角色名称" v-model="value" :data="data" :titles="['角色列表', '已选择']" @change="changeValue"></el-transfer>
</template>
<script>
import api from "@/config/api";
export default {
    name: 'UserRole',
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
            // value: [],
            data: [],
            filterMethod(query, item) {
                // console.log(query, item);
                return item.label.indexOf(query) > -1;
            }
        };
    },
    created() {
        this.$http.post(api.sys.sysroleList, { page: 1, size: 1000, }).then(res => {
            let list = res.data.data.list;

            this.data = list.map(item => ({
                label: item.name,
                key: item.id
            }))
        });
    },
    methods: {
        changeValue(val) {
            this.$emit("input", val);
        }
    }
}
</script>
