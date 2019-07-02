<template>
    <el-tabs type="border-card">
        <el-tab-pane>
            <span slot="label">
                <i class="el-icon-date"></i> 列表
            </span>

            <el-form :model="query" label-width="80px" :inline="true">
                <el-form-item label="中文名称">
                    <el-input v-model="query.labelZh"></el-input>
                </el-form-item>
                <el-form-item label="英文名称">
                    <el-input v-model="query.labelEn"></el-input>
                </el-form-item>
                <el-form-item label="枚举类型">
                    <el-select v-model="query.type" placeholder="请选择">
                        <el-option
                            v-for="item in selectOptions"
                            :key="item.id"
                            :label="item.type"
                            :value="item.type"
                        ></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" icon="el-icon-search" @click="queryHandle">查询</el-button>
                    <el-button type="primary" icon="el-icon-edit" @click="addHandle">增加</el-button>
                </el-form-item>
            </el-form>

            <el-table :data="tableData" style="width: 100%" :height="tableHeight">
                <el-table-column prop="type" label="枚举类型" width="180"></el-table-column>
                <el-table-column prop="labelZh" label="枚举名称-中文"></el-table-column>
                <el-table-column prop="labelEn" label="枚举名称-英文"></el-table-column>
                <el-table-column prop="value" label="枚举值 "></el-table-column>
                <el-table-column fixed="right" label="操作" width="100">
                    <template slot-scope="scope">
                        <el-button type="text" @click="editHandle(scope.row)">编辑</el-button>
                        <el-button type="text" @click="delHandle(scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <el-pagination
                @size-change="handleSizeChange"
                @current-change="handleCurrentChange"
                :current-page="currentPage"
                :page-sizes="[15, 32, 64]"
                :page-size="pageSize"
                :total="total"
                layout="total, sizes, prev, pager, next, jumper"
                class="pagination"
            ></el-pagination>
        </el-tab-pane>
        <el-tab-pane label="编辑"></el-tab-pane>
    </el-tabs>
</template>
<script>
import { getHeight } from "@/utils/sys";
export default {
    data () {
        return {
            query: {},
            selectOptions: [],
            tableData: [],
            tableHeight: '',

            /** 分页 */
            currentPage: 1,
            pageSize: 16,
            total: 1,
        }
    },
    created () {
        this.setHeight();
    },
    methods: {
        getHeight,
        /** 分页 */
        handleSizeChange (val) {
            this.pageSize = val;
            this.queryHandle();
        },
        handleCurrentChange (val) {
            this.currentPage = val;
            this.queryHandle();
        },


        /** 表单查询方法 */
        queryHandle () {

        },
        /** 增加表单 */
        addHandle () {

        },
        /** 编辑表单 */
        editHandle () {

        },
        /** 删除表单 */
        delHandle () {

        },

        /** 设置高度 */
        setHeight () {
            this.tableHeight = getHeight(290);
        },
    }
}
</script>


<style lang="less" scoped>
.pagination {
    text-align: center;
    padding-top: 12px;
}
</style>
