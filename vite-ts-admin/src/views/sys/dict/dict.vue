<template>
    <div>
        <el-alert title="消息提示的文案" type="info" :closable="false"></el-alert>
        <h-table-edit :column-data="columnData" :table-data="tableData" :selection="true" @selection-change="handleSelectionChange" />
    </div>
</template>

<script lang="tsx">
import { defineComponent } from "vue"
export default defineComponent({
    data() {
        return {
            columnData: [
                {
                    prop: "dictKey",
                    label: "字典编码",
                    type: "el-input",
                    required: true,
                },
                { prop: "dictLabel", label: "字典标题", type: "el-input" },
                { prop: "sort", label: "排序", type: "el-input-number" },
                { prop: "status", label: "状态", type: "el-switch" },
                { prop: "dictDesc", label: "备注", type: "el-input" },
            ],
            tableData: [
                { dictKey: "", dictModule: "" },
                { dictKey: "", dictModule: "" },
                { dictKey: "", dictModule: "" },
            ],
            multipleSelection: [],
        }
    },
    watch: {
        multipleSelection: {
            handler(val) {
                console.log(val)
            },
            deep: true,
            immediate: true,
        },
    },
    methods: {
        handleSelectionChange(val) {
            this.multipleSelection = val
        },
    },
})
</script>

<style>
</style>