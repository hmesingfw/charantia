<template>
    <div>
        <div class="query-title search-title el-card el-card is-always-shadow">
            <el-form :inline="true" :model="QueryParam" v-if="flashQuery" size="mini">
                <el-form-item :label="getWidth() ? '投票时间' : ''">
                    <time-pickers @start="val => QueryParam.startTime = val" @end="val => QueryParam.endTime = val" @methods="() => this.query(1)" format="yyyy-MM-dd" type="daterange"></time-pickers>
                </el-form-item>
                <div v-if="!getWidth()" style="margin:4px 0"></div>

                <el-form-item :label="getWidth() ? '状态' : ''" prop="status">
                    <el-radio-group v-model="QueryParam.status" @change="() => this.query(1)" class="radio-group">
                        <el-radio-button label>全部</el-radio-button>
                        <el-radio-button :label="0">启用</el-radio-button>
                        <el-radio-button :label="1">禁用</el-radio-button>
                    </el-radio-group>
                </el-form-item>
                <el-form-item :label="getWidth() ? '标题' : ''">
                    <el-input v-model="QueryParam.title" placeholder="请输入投票标题"></el-input>
                </el-form-item>
                <el-form-item>
                    <el-tooltip class="item" effect="dark" content="查询" placement="top">
                        <el-button @click="query(1)" type="primary" icon="el-icon-search" circle></el-button>
                    </el-tooltip>
                    <el-tooltip class="item" effect="dark" content="刷新" placement="top">
                        <el-button @click="queryClose(QueryParam);queryinit();" icon="el-icon-refresh" circle></el-button>
                    </el-tooltip>
                </el-form-item>
            </el-form>
            <div>
                <el-tooltip class="item" effect="dark" content="新增" placement="top">
                    <el-button @click="handleEdit()" circle type="primary" icon="el-icon-plus" v-permission="'vote:info:edit'"></el-button>
                </el-tooltip>
                <el-tooltip class="item" effect="dark" content="批量删除" placement="top">
                    <el-button @click="handleDelete({})" icon="el-icon-delete" circle type="danger" v-show="multipleSelection.length>0" v-permission="'vote:info:delete'"></el-button>
                </el-tooltip>
            </div>
        </div>
        <div class="margin-28 el-card el-card is-always-shadow">
            <el-table
                :data="tableData"
                :height="tableHeight"
                @selection-change="handleSelectionChange"
                v-loading="tableLoading"
                style="width: 100%"
                :stripe="true"
                header-row-class-name="table-header-color"
            >
                <el-table-column type="selection" width="42"></el-table-column>
                <el-table-column prop="title" label="标题" show-overflow-tooltip></el-table-column>
                <el-table-column prop="description" label="描述" width="260" show-overflow-tooltip></el-table-column>
                <!-- <el-table-column prop="keywords" label="关键字" width="160" show-overflow-tooltip></el-table-column> -->
                <el-table-column prop="startTime" label="开始时间" width="160"></el-table-column>
                <el-table-column prop="endTime" label="结束时间" width="160"></el-table-column>
                <el-table-column label="公开" width="60" align="center">
                    <template slot-scope="scope">
                        <span v-if="scope.row.ispublic== '0'">是</span>
                        <span v-else>否</span>
                    </template>
                </el-table-column>
                <el-table-column label="状态" width="60" align="center">
                    <template slot-scope="scope">
                        <!-- 0 是 1 否 -->
                        <i v-if="scope.row.status== 0" class="table-activity-success" @click="SwitchStatus({url:apiUrlupdateStatus, form:scope.row,obj:{status:1}, isAlert:false}, ()=>{ query(); })"></i>
                        <i v-else class="table-activity-danger" @click="SwitchStatus({url:apiUrlupdateStatus, form:scope.row, obj:{status:0}, isAlert:false}, ()=>{ query(); })"></i>
                    </template>
                </el-table-column>
                <el-table-column label="推荐" width="60" align="center">
                    <template slot-scope="scope">
                        <!-- 0 是 1 否 -->
                        <i
                            v-if="scope.row.isRecommend== 0"
                            class="table-activity-success"
                            @click="SwitchStatus({url:apiUrlupdateStatus, form:scope.row, obj:{isRecommend:1}, isAlert:false}, ()=>{ query(); })"
                        ></i>
                        <i v-else class="table-activity-danger" @click="SwitchStatus({url:apiUrlupdateStatus, form:scope.row, obj:{isRecommend:0}, isAlert:false}, ()=>{ query(); })"></i>
                    </template>
                </el-table-column>

                <el-table-column label="操作" width="160" fixed="right">
                    <template slot-scope="scope">
                        <!-- <el-button size="mini" type="text" @click="handleEditItem(scope.row, 'put')">投票选项</el-button> -->
                        <el-button size="mini" type="text" @click="handleStatis(scope.row, 'put')" v-permission="'vote:info:statis'">统计</el-button>
                        <el-button size="mini" type="text" @click="handleEdit(scope.row, 'put')" v-permission="'vote:info:edit'">编辑</el-button>
                        <el-button size="mini" type="text" @click="handleDelete(scope.row)" v-permission="'vote:info:delete'">删除</el-button>
                    </template>
                </el-table-column>
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

            <dialog-model
                v-model="dialogValue"
                title="投票信息"
                :type="requestType"
                :isSubmit="isVoteSubmit"
                @submit="handleUpdate"
                :loading-button="loadingButton"
                @changeLoadingButton="loadingButton = false"
            >
                <el-form label-position="right" label-width="80px" :rules="rules" :model="form" ref="ruleForm">
                    <el-row>
                        <el-col :span="14" style="padding-right:10px">
                            <el-card class="box-card">
                                <!-- <div slot="header" class="clearfix">
                                    <span>基础信息</span>
                                </div>-->

                                <el-form-item label="标题" prop="title">
                                    <el-input v-model="form.title" maxlength="32"></el-input>
                                </el-form-item>
                                <el-form-item label="分类" prop="category">
                                    <el-select v-model="form.category" placeholder="请选择">
                                        <el-option v-for="item in voteSortList" :key="item.id" :label="item.voteCategoryName" :value="item.id"></el-option>
                                    </el-select>
                                </el-form-item>

                                <el-form-item label="关键字" prop="keywords" v-show="false">
                                    <el-input v-model="form.keywords" maxlength="32"></el-input>
                                </el-form-item>
                                <el-form-item label="描述" prop="description">
                                    <el-input type="textarea" :row="4" v-model="form.description" maxlength="512"></el-input>
                                </el-form-item>
                                <el-form-item label="起止时间" prop="datatime">
                                    <el-date-picker v-model="form.datatime" type="datetimerange" value-format="yyyy-MM-dd HH:mm:ss" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期"></el-date-picker>
                                </el-form-item>

                                <el-form-item label="封面">
                                    <el-upload
                                        class="avatar-uploader"
                                        :class="{'is-border':!form.thumb}"
                                        :action="fileUpload"
                                        :show-file-list="false"
                                        :on-success="handleAvatarSuccess"
                                        :before-upload="beforeAvatarUpload"
                                        accept=".jpg, .jpeg, .png"
                                        :on-change="filechange"
                                        :auto-upload="false"
                                    >
                                        <img v-if="form.thumb" :src="baseFile + form.thumb" style="height:180px;" />
                                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                                        <div class="el-upload__tip" slot="tip">只能上传jpg/png文件，且不超过2MB，推荐分辨率 1920x1080</div>
                                    </el-upload>
                                    <image-cropper v-model="form.thumb" :dialogValue="dialogValueImg" :file="cropperFile" @close="dialogValueImg = false"></image-cropper>
                                </el-form-item>
                                <!-- <el-form-item label="内容"></el-form-item> -->
                                <el-form-item label="详情" prop="content">
                                    <vue-ueditor-wrap v-model="form.content" :config="myConfig"></vue-ueditor-wrap>
                                </el-form-item>
                            </el-card>
                        </el-col>
                        <el-col :span="10" style="padding-left:10px">
                            <el-card class="box-card">
                                <div slot="header" class="clearfix">
                                    <span>选项</span>
                                </div>
                                <div v-for="vote in voteItemList" :key="vote.id">
                                    <el-form-item label="标题" prop="title" v-show="false">
                                        <el-input v-model="vote.title" maxlength="32"></el-input>
                                    </el-form-item>
                                    <el-form-item label="选择类型" prop="isMore">
                                        <el-radio-group v-model="vote.isMore">
                                            <el-radio :label="0">单选</el-radio>
                                            <el-radio :label="1">多选</el-radio>
                                        </el-radio-group>
                                    </el-form-item>

                                    <el-form-item
                                        class="form-item"
                                        v-for="(voteItem, index) in vote.voteItemReqs"
                                        :key="voteItem.id"
                                        :label-width="getWidth() ? '80px':'50px'"
                                        :label="getWidth() ? '选项' + (index+1) : (index+1)+'、'"
                                    >
                                        <div class="vote-item-radio-new">
                                            <img v-if="voteItem.images" :src="baseFile + voteItem.images" fit="contain" />
                                            <el-input v-model="voteItem.title" width="200" maxlength="32"></el-input>
                                            <el-upload
                                                accept=".jpg, .jpeg, .png, .gif"
                                                :action="fileUpload"
                                                :show-file-list="false"
                                                :on-success="handleAvatarSuccessItem"
                                                :before-upload="beforeAvatarUpload"
                                            >
                                                <el-button @click="handleAvatarProgress(voteItem)" icon="el-icon-picture" circle></el-button>
                                            </el-upload>
                                            <el-button icon="el-icon-minus" v-if="index!=0" @click="handleDeleteVote(index, vote.voteItemReqs)" circle></el-button>
                                            <el-button icon="el-icon-plus" v-if="index+1 == vote.voteItemReqs.length" @click="handleAddVoteItem(vote.voteItemReqs)" circle></el-button>
                                        </div>
                                    </el-form-item>
                                </div>
                            </el-card>
                            <el-card class="box-card margin-top-20-card">
                                <div slot="header" class="clearfix">
                                    <span>设置</span>
                                </div>
                                <el-form-item label="推荐" prop="isRecommend">
                                    <el-radio-group v-model="form.isRecommend">
                                        <el-radio :label="0">是</el-radio>
                                        <el-radio :label="1">否</el-radio>
                                    </el-radio-group>
                                </el-form-item>
                                <el-form-item label="状态" prop="status">
                                    <el-radio-group v-model="form.status">
                                        <el-radio :label="0">启用</el-radio>
                                        <el-radio :label="1">禁用</el-radio>
                                    </el-radio-group>
                                </el-form-item>

                                <el-form-item label="公开" prop="ispublic" v-show="false">
                                    <el-radio-group v-model="form.ispublic">
                                        <el-radio label="0">是</el-radio>
                                        <el-radio label="1">否</el-radio>
                                    </el-radio-group>
                                </el-form-item>

                                <!-- <el-form-item label="人员" prop="uids" v-if="flashTag">
                                    <el-tag :key="tag.uid" v-for="(tag, index) in form.uids" closable :disable-transitions="false" @close="handleClose(form.uids,index)">{{tag.realName}}</el-tag>
                                    <el-button type="primary" icon="el-icon-plus" size="mini" @click="handleEditMember()" circle></el-button>
                                </el-form-item>-->
                            </el-card>
                            <el-card class="box-card margin-top-20-card" v-if="flashTag">
                                <div slot="header" class="clearfix">
                                    <span style="margin-right:10px;font-size: 16px;color: #606266;">公开</span>
                                    <el-switch v-model="form.ispublic" class="switchStyle" active-text="是" inactive-text="否" active-value="0" inactive-value="1"></el-switch>

                                    <div style="float: right;padding: 3px 0">
                                        <span v-show="form.ispublic == '1'">
                                            <el-button v-if="form.uids && form.uids.length > 0" style="padding-rigth:20px;" type="text" @click="handleEditNotice()">发送邀请通知</el-button>
                                            <span v-else style="padding-rigth:20px;font-size: 12px;">发送邀请通知</span>
                                        </span>

                                        <el-button v-show="form.ispublic == '1'" type="text" @click="handleEditMember()">添加</el-button>
                                    </div>
                                    <!-- <el-button v-show="form.ispublic == '1'" style="float: right; padding: 3px 0" type="text" @click="handleEditMember()">添加</el-button> -->
                                </div>
                                <el-tag :key="tag.uid" v-for="(tag, index) in form.uids" closable :disable-transitions="false" @close="handleClose(form.uids,index)">{{tag.realName}}</el-tag>
                            </el-card>
                        </el-col>
                        <!-- <el-col :span="14" style="padding-top:10px">
                            <el-card class="box-card">
                                <div slot="header" class="clearfix">
                                    <span>详细内容</span>
                                </div>
                                <el-form-item label-width="0px" prop="content">
                                    <vue-ueditor-wrap v-model="form.content" :config="myConfig"></vue-ueditor-wrap>
                                </el-form-item>
                            </el-card>
                        </el-col>-->
                    </el-row>
                </el-form>
            </dialog-model>

            <!-- <dialog-model v-model="dialogValueItem" title="投票选项" :type="requestType" @submit="handleUpdateVoteItem" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
                <div class="vote-class" v-for="(vote, vindex) in voteItemList" :key="vote.id">
                    <el-card shadow="always">
                        <div class="vote-item-title">
                            <div class="handles">
                                <span>{{vindex+1}}.</span>

                                <el-input v-model="vote.title" placeholder="请输入选项标题" maxlength="32"></el-input>
                                <el-checkbox v-model="vote.isMust" :true-label="0" :false-label="1">是否必填</el-checkbox>
                                <el-checkbox v-model="vote.isMore" :true-label="0" :false-label="1">是否多选</el-checkbox>
                            </div>
                            <div>
                                <el-button icon="el-icon-delete" type="danger" circle @click="handleDeleteVote(vindex, voteItemList)"></el-button>
                            </div>
                        </div>
                        <el-row>
                            <el-col :span="4" class="vote-item-content" v-for="(voteItem, index) in vote.voteItemReqs" :key="voteItem.id">
                                <el-card shadow="always">
                                    <div slot="header" class="clearfix">
                                        <span>{{index+1}}.</span>
                                        <i class="el-icon-delete" style="float: right;" @click="handleDeleteVote(index, vote.voteItemReqs)"></i>
                                    </div>

                                    <el-upload
                                        class="avatar-uploader"
                                        accept=".jpg, .jpeg, .png, .gif"
                                        :action="fileUpload"
                                        :show-file-list="false"
                                        :on-success="handleAvatarSuccessItem"
                                        :before-upload="beforeAvatarUpload"
                                    >
                                        <img v-if="voteItem.images" :src="voteItem.images" class="avatar" @click="handleAvatarProgress(voteItem)" />
                                        <i v-else class="el-icon-plus avatar-uploader-icon" @click="handleAvatarProgress(voteItem)"></i>
                                    </el-upload>

                                    <div class="vote-item-index">
                                        <el-input v-model="voteItem.title" placeholder="请输入选项值" maxlength="32"></el-input>
                                    </div>
                                </el-card>
                            </el-col>
                            <el-col :span="4" class="vote-item-content vote-item-add">
                                <el-button type="primary" icon="el-icon-plus" circle @click="handleAddVoteItem(vote.voteItemReqs)"></el-button>
                            </el-col>
                        </el-row>
                    </el-card>
                </div>
                <div style="text-align: center;width:100%">
                    <el-button @click="handleAddVote" type="primary">添加</el-button>
                </div>
            </dialog-model>-->
        </div>
        <select-member v-model="dialogValueMember" :list="form.uids" v-if="flashMemberSelect" @newlist="data => this.$set(this.form, 'uids', data)"></select-member>

        <!-- <dialog-alert v-model="dialogValueMember" title="选择会员" :width="getWidth() ? '70%' : '90%'" type="post" @submit="requestTypeMember" class="guanlianghuuiyuan">
            <select-member v-model="form.uids" v-if="flashMemberSelect"></select-member>
        </dialog-alert>-->
    </div>
</template>
<script>
import { GetHeight, deleteRequestData, DeepCopy, ErrorLog, reqData, ueConfig } from '@/utils/sys';
import api from '@/config/api';
import { mapState } from 'vuex';
import VueUeditorWrap from 'vue-ueditor-wrap'; // ES6 Module
import SelectMember from '@/components/SelectMember/index';


export default {
    components: {
        VueUeditorWrap, SelectMember
    },
    computed: {
        ...mapState({
        })
    },
    data() {
        var checkTime = (rule, value, callback) => {
            if (value && value.length > 0) {
                if (!value[0]) {
                    callback(new Error('请选择时间'));
                }
            } else {
                callback(new Error('请选择时间'));
            }

            callback();
        };
        return {
            apiUrl: api.sys2.vote,          // 请求路很
            apiUrlupdateStatus: api.sys2.voteupdateStatus,          // 请求路很
            baseFile: api.baseFile,
            flashQuery: true,
            rules: {
                title: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                category: [{ required: true, message: '请选择内容', trigger: 'blur' },],
                startTime: [{ required: true, message: '请选择时间', trigger: 'blur' },],
                endTime: [{ required: true, message: '请选择时间', trigger: 'blur' },],
                datatime: [{ required: true, message: '请选择时间', trigger: 'blur' }, { validator: checkTime, trigger: 'blur' }],
            },
            fileUpload: api.sys2.fileUpload,

            /* voteitem */
            dialogValueItem: false,
            voteTemp: {},
            voteItemList: [],
            fileTemp: {},           //上传图片临时保存对象 

            dialogValueMember: false,      // 会员弹框           
            flashMemberSelect: true,        //  刷新页面
            flashTag: true,

            isVoteSubmit: true,                 // 投票信息是否能保存

            dialogValueImg: false,
            cropperFile: null,          // 上传的图片
            /* 基本不变------------ */
            tableHeight: GetHeight(260), // 列表高度       
            tableHeightTab: GetHeight(180), // 列表高度       
            QueryParam: {
                status: ''
            },             //  搜索
            tableData: [],
            tableLoading: false,
            multipleSelection: [],      // 多选选中的值

            pagination: {
                page: 1,
                size: localStorage.getItem('pageSize') || this.getWidth() ? 20 : 10,
            },
            totalCount: 0,      // 总共多少条
            myConfig: ueConfig,             // ue配置信息

            /* 表单 */
            dialogValue: false,
            requestType: '',
            loadingButton: false,
            form: {},

            voteSortList: [],
        };
    },
    created() {
        this.query();
        this.init();
    },
    methods: {
        deleteRequestData, reqData,
        init() {
            this.$http.post(api.sys2.voteSortList, { page: 1, size: 10000, }).then(res => {
                this.voteSortList = res.data.data.records;
            });
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
                flag: 'hd',
                ...this.pagination,
                ...this.QueryParam
            };
            this.tableLoading = true;
            this.$http.post(api.sys2.voteList, param).then(res => {
                let data = res.data.data;
                this.tableData = data.records;

                this.pagination.size = data.size;
                this.totalCount = data.total;
                this.tableLoading = false;
            }).catch(err => {
                ErrorLog(err);
                this.tableLoading = false;
            });
        },
        /* 判断是否大于当前时间 */
        async startTime(row) {
            let time = new Date(row.startTime).getTime();
            let nowTime = new Date().getTime();
            if (time < nowTime) {
                this.isVoteSubmit = false;
                return await this.$confirm('投票时间已开始，是否继续查看', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'info'
                }).then(async () => {
                    return true;
                }).catch(async () => {
                    return false;
                });
            }
        },

        /* 判断是否大于当前时间 */
        async endTime(row) {
            let time = new Date(row.endTime).getTime();
            let nowTime = new Date().getTime();
            if (time < nowTime) {
                this.isVoteSubmit = false;
                return await this.$confirm('投票时间已结束，是否继续查看', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'info'
                }).then(async () => {
                    return true;
                }).catch(async () => {
                    return false;
                });
            } else {
                return 1;
            }
        },
        /* 编辑 */
        async handleEdit(row = { status: 0, ispublic: '0', startTime: '', endTime: '', isRecommend: 1 }, requestType = 'post') {
            this.isVoteSubmit = true;
            let tempStart = true;           //  活动已结束确实不需要使用开始时间
            if (row.endTime) {
                let end = await this.endTime(row);
                if (end === false || end === true) {
                    tempStart = false;
                    if (end === false) {
                        return false;
                    }
                }
            }
            if (row.startTime && tempStart) {
                if (await this.startTime(row) === false) {
                    return false;
                }
            }
            this.dialogValue = true;
            this.form = DeepCopy(row);
            this.requestType = requestType;
            this.$set(this.form, 'datatime', [this.form.startTime, this.form.endTime]);
            /* 未公开时的人员 */
            this.form.uids = [];
            if (requestType == 'put') {
                this.$http.get(api.sys2.voteMember, { params: { voteId: row.id, page: 1, size: 1000 } }).then(res => {

                    this.$set(this.form, 'uids', res.data.data.map(item => ({ uid: item.uid, realName: item.realName })));
                    this.flashTag = false;
                    this.$nextTick(() => {
                        this.flashTag = true;
                    });
                });
            }

            /* 投票选项 */
            if (requestType == 'post') {
                this.voteItemList = [];
                this.handleAddVote();
            } else {
                this.$http.get(api.sys2.voteItemList, { params: { voteId: row.id } }).then(res => {
                    this.voteItemList = res.data.data;
                });
            }
            // this.voteTemp = row;
            // this.$http.get(api.sys2.voteItemList, { params: { voteId: row.id } }).then(res => {
            //     this.voteItemList = res.data.data;
            //     if (this.voteItemList.length <= 0) {
            //         this.handleAddVote();
            //     }
            // });
        },
        /* 保存 */
        async handleUpdate() {
            this.$refs.ruleForm.validate(async valid => {
                if (valid) {
                    if (this.voteItemList.length > 0) {
                        if (this.voteItemList[0].voteItemReqs && this.voteItemList[0].voteItemReqs.length > 0) {
                            for (let i = 0; i < this.voteItemList[0].voteItemReqs.length; i++) {
                                let obj = this.voteItemList[0].voteItemReqs[i];
                                if (!obj.title) {
                                    this.$message.info('选项不能为空，请输入选项');
                                    return false;
                                }
                            }
                        }
                    }

                    this.loadingButton = true;
                    this.form.startTime = this.form.datatime[0];
                    this.form.endTime = this.form.datatime[1];

                    this.$set(this.form, 'uids', this.form.uids.map(item => item.uid));/* 只保存id */
                    let issucc = await this.reqData(this.apiUrl, this.form, this.requestType, { isAlert: false, isResult: true });
                    if (issucc.data.code == 200) {
                        this.$message.success('保存成功');
                        this.loadingButton = false;
                        this.dialogValue = false;
                        this.query();

                        /* 主题选项 新增保存修改 */
                        if (this.requestType == 'post') {
                            let voteid = issucc.data.data;
                            this.voteItemList.forEach(obj => {
                                this.$set(obj, 'voteId', voteid);
                                this.$set(obj, 'title', this.form.title);
                                obj.voteItemReqs.forEach(item => {
                                    this.$set(item, 'voteId', voteid);
                                });
                            });
                            await this.reqData(api.sys2.voteItem, this.voteItemList, 'post', { isAlert: false });
                        } else {
                            await this.reqData(api.sys2.voteItem, this.voteItemList, 'post', { isAlert: false });
                        }
                    } else {
                        this.loadingButton = false;
                    }
                }
            });
        },
        /* 多选获取值 */
        handleSelectionChange(val) {
            this.multipleSelection = val;
        },
        async handleDelete(row) {
            let ids = [];
            if (row.id) {
                ids.push(row.id);
            } else {
                ids = this.multipleSelection.map(item => item.id);
            }
            let message = await this.deleteRequestData(this.apiUrl, ids, { isAlert: false });
            if (message) {
                this.$message.success('删除成功');
                this.query();
            }
        },
        /* 到这里基本不变----------- */
        handleAvatarSuccess(res, file) {
            this.$set(this.form, 'thumb', file.response.data);
        },
        beforeAvatarUpload(file) {
            const isLt2M = file.size / 1024 / 1024 < 2;

            if (!isLt2M) {
                this.$message.error('上传图片大小不能超过 2MB!');
            }
            return isLt2M;
        },
        /* 上传文件改变钩子 */
        filechange(file) {

            let url = URL.createObjectURL(file.raw);
            this.cropperFile = file.raw;
            this.$set(this.form, 'thumb', url);

            this.dialogValueImg = true;
        },




        /* voteItem  */
        /* 蛮有用，先留下来 */
        /* 查询 */
        handleEditItem(row) {
            this.dialogValueItem = true;
            this.voteTemp = row;
            let param = {
                voteId: row.id
            };

            this.$http.get(api.sys2.voteItemList, { params: param }).then(res => {
                this.voteItemList = res.data.data;

                if (this.voteItemList.length <= 0) {
                    this.handleAddVote();
                }
            });
        },
        /* 上传时的钩子, 上传的途中将图片对象赋予filetemp */
        handleAvatarProgress(obj) {
            this.fileTemp = obj;
        },
        temp(obj) {
            console.log(obj);
        },
        /* 上传成功后的钩子 */
        handleAvatarSuccessItem(response, file) {
            this.$set(this.fileTemp, 'images', file.response.data);
        },
        /* 添加主题 */
        handleAddVote() {
            let voteid = this.voteTemp.id;
            let item = {
                parentId: 0,
                voteId: voteid,
                isMore: 0,
                isMust: 0,
                images: '',
                title: '',
                voteItemReqs: [
                    { images: '', title: '', voteId: voteid, },
                    { images: '', title: '', voteId: voteid, },
                ]
            };
            this.voteItemList.push(item);
        },
        /* 添加主题选项 */
        handleAddVoteItem(list) {
            list.push({ images: '', title: '', voteId: this.voteTemp.id });
        },
        /* 去除选项或题目 */
        handleDeleteVote(index, list) {
            list.splice(index, 1);
        },
        async handleUpdateVoteItem() {
            this.loadingButton = true;
            let issucc = await this.reqData(api.sys2.voteItem, this.voteItemList, 'post', { isAlert: false });
            if (issucc) {
                this.$message.success('保存成功');
                this.loadingButton = false;
                this.dialogValueItem = false;
            } else {
                this.loadingButton = false;
            }
        },


        /* 统计 */
        handleStatis(row) {
            this.$router.push({ path: '/voteStatis/info', query: { id: row.id, voteNum: row.voteNum, title: row.title } });
        },


        /* 会员选择框 */
        requestTypeMember() {
            if (this.form.uids && this.form.uids.length > 0) {
                this.dialogValueMember = false;
            } else {
                this.$confirm('当前没有选择人员，是否继续操作', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'error'
                }).then(() => {
                    this.dialogValueMember = false;
                });
            }
        },
        /* 不公开时，选择会员 */
        handleEditMember() {
            this.dialogValueMember = true;
            this.flashMemberSelect = false;
            this.$nextTick(() => {
                this.flashMemberSelect = true;
            });
        },
        /* 去除 */
        handleClose(arr, index) {
            arr.splice(index, 1);
        },
        /* 发送邀请通知 */
        handleEditNotice() {
            if (this.requestType == 'post') {
                this.$message.info('请先保存投票信息，再发送邀请通知');
                return false;
            }


            this.$confirm('请确认给当前选择的会员，发送投票邀请通知', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'info'
            }).then(() => {

                let ids = this.form.uids.map(item => item.uid);
                let json = {
                    id: this.form.id, uids: ids
                };
                this.$http.post(`${api.sys.voteInvite}`, json).then(res => {
                    if (res.data.code == 200) {
                        this.$message.success(res.data.message);
                    }
                });
            });
        },


        queryinit() {
            this.flashQuery = false;
            this.$nextTick(() => {
                this.flashQuery = true;
                this.query();
            });
        },
    }
};
</script>

<style lang="scss">
.vote-class {
    margin-bottom: 10px;

    .el-card__header {
        padding-top: 10px;
        padding-left: 20px;
        padding-right: 20px;
        padding-bottom: 6px;
    }
    .el-card__body {
        padding: 10px;
    }
    .vote-item-title {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-right: 20px;
        margin-bottom: 20px;
        .handles {
            padding-right: 10px;
            padding-left: 10px;
            width: 60%;

            .el-input {
                width: 50%;
                margin-right: 20px;
            }
        }
    }
    .vote-item-content {
        display: flex;
        justify-content: center;
        flex-direction: column;
        padding: 0 10px 20px;

        .avatar-uploader {
            display: flex;
            justify-content: center;
            height: 120px;

            .avatar-uploader-icon {
                font-size: 28px;
                color: #8c939d;
                width: 118px;
                height: 118px;
                line-height: 118px;
                text-align: center;
            }
        }

        .vote-item-index {
            margin-top: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;

            span {
                padding-right: 6px;
            }
            i {
                cursor: pointer;
                padding-left: 10px;
            }
        }
    }

    .vote-item-add {
        padding-left: 30px;
        padding-top: 80px;

        .el-button {
            width: 40px;
            height: 40px;
        }
    }
}
.form-item {
    display: flex;
    align-items: center;

    .el-form-item__content {
        margin-left: 0px !important;
    }
    .vote-item-radio-new {
        display: flex;
        align-items: center;
        img {
            height: 60px;
            width: 70px;
        }

        .el-input {
            width: 270px;
            margin: 0 10px;
        }
        @media screen and (max-width: 1400px) {
            .el-input {
                width: 160px;
            }
        }
        .el-upload {
            margin-right: 10px;
        }

        .el-button {
            padding: 6px;
        }
    }
}
</style>
