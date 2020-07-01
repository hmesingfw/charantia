<template>
    <div>
        <div class="app-main-table">
            <el-form :inline="true" :model="QueryParam" class="header-query-form">
                <generate-form :datalist="queryComponentData" :model="QueryParam" @change="query(1)"></generate-form>
            </el-form>
        </div>
        <div class="app-main-table">
            <el-timeline class="event-comment-content">
                <el-timeline-item timestamp="2018/4/12 12:00:00 张三" placement="top">
                    <el-card class="comment-card">
                        <div class="comment-image-group">
                            <el-image class="comment-image" src="https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg" fit="contain"></el-image>
                            <el-image class="comment-image" src="https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg" fit="contain"></el-image>
                            <el-image class="comment-image" src="https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg" fit="contain"></el-image>
                            <el-image class="comment-image" src="https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg" fit="contain"></el-image>
                        </div>
                        <p>王小虎 提交于 2018/4/12 20:46</p>

                        <div class="comment-delete">
                            <i class="el-icon-delete icon"></i>
                        </div>
                    </el-card>
                </el-timeline-item>
                <el-timeline-item timestamp="2018/4/3 12:00:00 李四" placement="top">
                    <el-card>
                        <p>王小虎 提交于 2018/4/3 20:46</p>
                    </el-card>
                </el-timeline-item>
                <el-timeline-item timestamp="2018/4/2 12:00:00 五王" placement="top">
                    <el-card>
                        <p>王小虎 提交于 2018/4/2 20:46</p>
                    </el-card>
                </el-timeline-item>
            </el-timeline>
        </div>
    </div>
</template>
<script>
import { mapState } from 'vuex';
export default {
    components: {
    },
    props: {
        info: Object,
    },
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
            regType: state => state.enumList.data.regType,
            sexType: state => state.enumList.data.sexType,
        })
    },
    data() {
        return {
            apiUrl: this.$api.sys.tenantAdmin, // 请求路很              

            /* ------------ */
            QueryParam: {}, //  搜索条件 
            queryComponentData: [
                { name: 'el-input', key: 'name', label: "姓名", attr: { placeholder: '请输入用户姓名' } },
            ],
            tableData: [],
            tableParams: [
                {
                    prop: 'orderNo', label: '头像',
                },
                {
                    prop: 'uid', label: '姓名',
                },
                {
                    prop: 'content', label: '评论内容',
                },
                {
                    prop: 'createdTime', label: '评论时间', width: 160,
                },

                {
                    prop: 'status', label: "操作", width: 160,
                    formatF: row => <div>
                        <el-button type="text" on-click={() => this.HandleDelete(this.apiUrl, row, this.query)} icon="el-icon-delete">删除</el-button>
                    </div>
                },],
            tableLoading: false,
            multipleSelection: [], // 多选选中的值

            pagination: {
                ...this.ConfigParmas.pagination
            },
            totalCount: 0, // 总共多少条
            /* 表单 */
            dialogValue: false,
            requestType: '', // 请求类型 
            form: {},


            /*  */
            dialogValueAuto: false,
            autoInfo: {},
            flashRole: false,
        };
    },
    created() {
        this.query();
    },
    methods: {
        /* 查询操作 */
        query(flag) {
            if (flag == 1) this.pagination.page = 1; // 查询时，让页面等于1
            let param = {
                ...this.pagination,
                ...this.QueryParam,
                tenantId: this.info.tenantId,
            };
            this.tableLoading = true;
            this.$http.get(this.apiUrl, {
                params: param
            }).then(res => {
                this.tableData = res.data.data.list;
                this.totalCount = res.data.data.totalCount;
                this.tableLoading = false;
            }).catch(() => {
                this.tableLoading = false;
            });
        },
        /* 编辑 */
        handleEdit(row, requestType = 'post') {
            this.dialogValue = true;
            this.form = this.DeepCopy(row);
            this.requestType = requestType;
        },
        /* 编辑角色 */
        async handleOpenRole(row) {
            this.dialogValueAuto = true;
            this.autoInfo = row;
            this.flashRole = true;
            let res = await this.$http.get(`${this.$api.sys.roleUser}?uid=${row.id}`);

            this.$set(this.autoInfo, 'roleId', res.data.data.roleId);
            this.flashRole = false;
        },
    }
};
</script>
<style lang="scss">
.event-comment-content {
    margin: 20px 60px 20px 20px;

    .comment-card {
        position: relative;
        .comment-image-group {
            padding-top: 10px;
            .comment-image {
                width: 100px;
            }
        }
        .el-card__body {
            padding: 10px 20px;
        }
        .comment-delete {
            position: absolute;
            right: 0;
            top: 0;
            width: 50px;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            .icon {
                cursor: pointer;
                font-size: 20px;
                color: #f56c6c;
            }
        }
    }
}
</style>