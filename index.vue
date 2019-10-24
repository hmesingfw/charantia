<template>
    <div class="c-padding-10">
        <el-tabs v-model="activeName" @tab-click="handleTabsClick" type="border-card">
            <el-tab-pane name="first">
                <span slot="label">
                    <i class="el-icon-date"></i> 我的列表
                </span>
                <el-form :inline="true" :model="formInline" class="demo-form-inline">
                    <el-form-item label="审批人">
                        <el-input v-model="formInline.user" placeholder="审批人"></el-input>
                    </el-form-item>
                    <el-form-item label="活动区域">
                        <el-select v-model="formInline.region" placeholder="活动区域">
                            <el-option label="区域一" value="shanghai"></el-option>
                            <el-option label="区域二" value="beijing"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" @click="onQuerySubmit">查询</el-button>
                    </el-form-item>
                </el-form>

                <el-table :data="tableData" border style="width: 100%">
                    <el-table-column fixed prop="date" label="日期" width="150"></el-table-column>
                    <el-table-column prop="name" label="姓名" width="120"></el-table-column>
                    <el-table-column prop="province" label="省份" width="120"></el-table-column>
                    <el-table-column prop="city" label="市区" width="120"></el-table-column>
                    <el-table-column prop="address" label="地址" width="300"></el-table-column>
                    <el-table-column prop="zip" label="邮编"></el-table-column>
                    <el-table-column fixed="right" label="操作" width="100">
                        <template slot-scope="scope">
                            <el-button @click="handleRowClick(scope.row)" type="text">查看</el-button>
                            <el-button type="text">编辑</el-button>
                        </template>
                    </el-table-column>
                </el-table>

                <div class="c-pagination">
                    <el-pagination
                        @size-change="handleSizeChange"
                        @current-change="handleCurrentChange"
                        :current-page="pagination.page"
                        :page-sizes="[10, 20, 30, 50]"
                        :page-size="pagination.size"
                        layout="total, sizes, prev, pager, next, jumper"
                        :total="pagination.totalCount"
                    ></el-pagination>
                </div>
            </el-tab-pane>
            <el-tab-pane name="form">
                <span slot="label">
                    <i class="el-icon-date"></i> 我的表单
                </span>

                <el-form ref="form" :model="form" label-width="80px">
                    <el-form-item label="活动名称">
                        <el-input v-model="form.name"></el-input>
                    </el-form-item>
                    <el-form-item label="活动区域">
                        <el-select v-model="form.region" placeholder="请选择活动区域">
                            <el-option label="区域一" value="shanghai"></el-option>
                            <el-option label="区域二" value="beijing"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="活动时间">
                        <el-col :span="11">
                            <el-date-picker type="date" placeholder="选择日期" v-model="form.date1" style="width: 100%;"></el-date-picker>
                        </el-col>
                        <el-col class="line" :span="2">-</el-col>
                        <el-col :span="11">
                            <el-time-picker placeholder="选择时间" v-model="form.date2" style="width: 100%;"></el-time-picker>
                        </el-col>
                    </el-form-item>
                    <el-form-item label="即时配送">
                        <el-switch v-model="form.delivery"></el-switch>
                    </el-form-item>
                    <el-form-item label="特殊资源">
                        <el-radio-group v-model="form.resource">
                            <el-radio label="线上品牌商赞助"></el-radio>
                            <el-radio label="线下场地免费"></el-radio>
                        </el-radio-group>
                    </el-form-item>
                    <el-form-item label="活动形式">
                        <el-input type="textarea" v-model="form.desc"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" @click="onSubmit">立即创建</el-button>
                        <el-button>取消</el-button>
                    </el-form-item>
                </el-form>
            </el-tab-pane>
        </el-tabs>
    </div>
</template>

<script>
export default {
    components: {
    },
    data() {
        return {
            activeName: 'first',
            formInline: {},
            tableData: [],
            pagination: {
                page: 1,
                pagination: 16,
                totalCount: 0
            },

            form: {},
        };
    },
    methods: {
        /* tabs栏状态切换 */
        handleTabsClick(tab) {
            if (tab.name == 'form') {
                this.form = {}
            }
        },
        /* 查询 */
        onQuerySubmit() { },
        /* 表单点击某项 */
        handleRowClick(row) { },


        /* 分页操作 */
        handleSizeChange() { },
        handleCurrentChange() { },


        /* 表单保存编辑 */
        onSubmit() { },
    },

};
</script>

<style lang="scss" scoped>
.c-padding-10 {
    padding: 10px;
}

.c-pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    padding-top: 6px;
}
</style>
