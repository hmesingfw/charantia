<template>
    <div class="margin-28">
        <div class="margin-8 search-title el-card el-card is-always-shadow border-title">{{ title }}</div>

        <el-tabs type="border-card">
            <el-tab-pane>
                <span slot="label">
                    <i class="el-icon-date"></i>投票统计
                </span>
                <div style="text-align: center;margin-top: 10px;">
                    投票总人数：
                    <span style="margin-left:10px;">{{ voteNum }}</span>人
                </div>
                <echarts :id="id" :height="tableHeight" :titleList="titleList" :dataList="dataList" v-if="echartsflash"></echarts>
            </el-tab-pane>
            <el-tab-pane>
                <span slot="label">
                    <i class="el-icon-date"></i>投票详情
                </span>
                <!-- <el-row>
                    <el-col :span="colSpan" v-for="item in itemUser" :key="item.id">
                        <el-card class="box-card">
                            <div slot="header" class="clearfix">
                                <div v-if="item.images">
                                    <el-image style="width: 100px; height: 100px" :src="item.images" fit="cover"></el-image>
                                </div>
                                <div>{{ item.title }}</div>
                            </div>
                            <div class="member-group h-table">
                                <el-scrollbar style="height:300px;width:100%;">
                                    <div class="avatar-group" v-for="obj in item.voteResultRess" :key="obj.id">
                                        <el-avatar v-if="obj.avatar" :src="obj.avatar"></el-avatar>
                                        <el-avatar v-else src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png"></el-avatar>

                                        <div class="font-color font">{{ obj.realName }}</div>
                                    </div>
                                </el-scrollbar>
                            </div>
                        </el-card>
                    </el-col>
                </el-row>-->
                <div>
                    <div class="margin-8 search-title el-card el-card is-always-shadow">
                        <el-form :inline="true" :model="QueryParam">
                            <el-form-item :label="getWidth() ? '投票项' : ''">
                                <el-select v-model="QueryParam.itemId" clearable placeholder="请选择投票项">
                                    <el-option v-for="item in voteItem" :key="item.id" :value="item.id" :label="item.title"></el-option>
                                </el-select>
                            </el-form-item>
                            <el-form-item :label="getWidth() ? '投票人' : ''">
                                <el-input v-model="QueryParam.name" placeholder="请输入姓名"></el-input>
                            </el-form-item>

                            <el-form-item>
                                <el-tooltip class="item" effect="dark" content="查询" placement="top">
                                    <el-button @click="query(1)" type="primary" icon="el-icon-search" circle></el-button>
                                </el-tooltip>
                                <el-tooltip class="item" effect="dark" content="刷新" placement="top">
                                    <el-button @click="queryClose(QueryParam);query();" icon="el-icon-refresh" circle></el-button>
                                </el-tooltip>
                            </el-form-item>
                        </el-form>
                        <div></div>
                    </div>
                    <div class="margin-8 el-card el-card is-always-shadow">
                        <el-table :data="tableData" :height="tableHeight2" v-loading="tableLoading" style="width: 100%" :stripe="true" header-row-class-name="table-header-color">
                            <el-table-column prop="username" label="投票人" show-overflow-tooltip></el-table-column>
                            <el-table-column prop="voteTitle" label="投票项"></el-table-column>
                            <el-table-column prop="createTime" label="投票时间"></el-table-column>
                        </el-table>

                        <div class="pu-pagination">
                            <el-pagination
                                @size-change="handleSizeChange"
                                @current-change="handleCurrentChange"
                                :current-page="pagination.page"
                                :page-sizes="[10, 20, 30, 50]"
                                :page-size="pagination.size"
                                layout="total, sizes, prev, pager, next, jumper"
                                :total="totalCount"
                            ></el-pagination>
                        </div>
                    </div>
                </div>
            </el-tab-pane>
        </el-tabs>
    </div>
</template>
<script>
import { GetHeight, deleteRequestData, reqData } from '@/utils/sys';
import { mapState } from 'vuex';
import echarts from './echarts.vue';
import api from '@/config/api';

export default {
    components: {
        echarts
    },
    computed: {
        ...mapState({
        })
    },
    data() {
        return {
            tableHeight: GetHeight(284), // 列表高度    
            titleList: [],
            dataList: [],
            echartsflash: true,
            id: '',
            voteNum: '',
            title: '',
            colSpan: 12,

            itemUser: [],           // 投票详情信息

            /* 投票详情 */
            tableHeight2: GetHeight(380),
            voteItem: [],               // 投票选项
            QueryParam: {
                itemId: '', name: ''
            },             //  搜索
            tableData: [],
            tableLoading: false,
            multipleSelection: [],      // 多选选中的值

            pagination: {
                page: 1,
                size: localStorage.getItem('pageSize') || this.getWidth() ? 20 : 10,
            },
            totalCount: 0,      // 总共多少条

        };
    },
    created() {
        this.id = this.$route.query.id;
        this.voteNum = this.$route.query.voteNum;
        this.title = this.$route.query.title;
        this.init();
        this.query();
    },
    methods: {
        deleteRequestData, reqData,
        init() {
            this.$http.post(api.sys2.voteResult, { voteId: this.id }).then(res => {
                let dataList = res.data.data;
                let filter = dataList.filter(item => {
                    return item.parentId != 0;
                });
                this.dataList = filter.map(data => data.itemNum || 0);
                this.titleList = filter.map(data => data.title);
                this.voteItem = filter.map(data => ({ id: data.id, title: data.title }));
                this.echartsflash = false;
                this.$nextTick(() => {
                    this.echartsflash = true;
                });
            });

            // this.$http.post(api.sys2.voteselectVoteUser, { voteId: +this.id }).then(res => {
            //     let dataList = res.data.data;
            //     this.itemUser = dataList.filter(item => {
            //         return item.parentId != 0;
            //     });
            //     if (this.itemUser.length > 4) {
            //         this.colSpan = 6;
            //     } else {
            //         this.colSpan = 24 / this.itemUser.length;
            //     }
            // });

        },
        /* 改变每页大小 */
        handleSizeChange(val) {
            this.pagination.size = val;
            this.query();
        },
        /* 改变当前页 */
        handleCurrentChange(val) {
            this.pagination.page = val;
            this.query();
        },
        /* 查询操作 */
        query(flag) {
            if (flag == 1) this.pagination.page = 1;         // 查询时，让页面等于1
            let param = {
                voteId: this.id,
                ...this.pagination,
                ...this.QueryParam
            };
            this.tableLoading = true;
            this.$http.get(api.sys.voteResultDetail, { params: param }).then(res => {
                let data = res.data.data;
                this.tableData = data.records;

                this.pagination.size = data.size;
                this.totalCount = data.total;
                this.tableLoading = false;
            }).catch(() => {
                this.tableLoading = false;
            });
        },
    }
};
</script>


<style lang="scss" scoped>
.el-scrollbar__wrap {
    overflow-x: hidden;
}
.el-card__header {
    .clearfix {
        display: flex;
        flex-direction: column;
    }
}
.el-col {
    padding: 6px;
}
.member-group {
    display: flex;
    .avatar-group {
        width: 60px;
        height: 60px;
        float: left;
        .font {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
    }
}
</style>
