<template>
    <div :ref="ref" class="h-table">
        <el-row class="h-table-handle" type="flex" justify="space-between">
            <div>
                <slot name="add">
                    <el-button @click="EditInfo()">
                        <i class="el-icon-plus" />新增
                    </el-button>
                </slot>
                <slot name="del">
                    <el-button plain @click="DeleteInfo()">
                        <i class="el-icon-delete" style="color:#F56C6C" /> &nbsp;批量删除
                    </el-button>
                </slot>

                <slot name="left-handle" />
            </div>
            <div class="right-handle">
                <slot name="right-handle" />
                <el-button icon="el-icon-refresh" @click="TableReflash(1000)">刷新</el-button>

                <el-popover placement="bottom" :width="240" trigger="click" popper-class="h-table-col-settings">
                    <el-row type="flex" justify="space-between" align="middle" class="h-table-col-settings__header">
                        <div>
                            <el-checkbox v-model="settingCheckAll" :indeterminate="isIndeterminate" @change="ChangeColSettingAll">列展示</el-checkbox>
                        </div>
                        <el-button type="text" @click="DefaultColSettings(true)">重置</el-button>
                    </el-row>
                    <el-row class="h-table-col-settings__group">
                        <draggable v-model="colSettings" draggable=".drag" animation="300" @end="ChangeSettingsCol()">
                            <div v-for="(item, i) in colSettings" :key="i" class="item" :class="{'drag':item.prop != 'selection'}">
                                <i :class="item.prop == 'selection' ? 'el-icon-menu' : 'el-icon-rank'" />
                                <el-checkbox v-model="item.status" @change="ChangeSettingsCol">{{ item.label }}</el-checkbox>
                            </div>
                        </draggable>
                    </el-row>

                    <template #reference>
                        <el-button>
                            <i class="el-icon-setting" /> 显示列
                            <i class="el-icon-caret-bottom" />
                        </el-button>
                    </template>
                </el-popover>
            </div>
        </el-row>
        <h-main v-if="tableStatus" ref="hCustTableRef" v-loading="tableLoading" :selection="selection" :data="tableData" :table-attrs="setupTableAttrs" :params="colSettings" @selections="Selection" />
        <div class="h-page">
            <el-pagination
                :current-page="pageData.page"
                :page-sizes="page.sizes"
                :page-size="page.size"
                :layout="page.layout"
                :total="pageData.total"
                @size-change="PageSizeChange"
                @current-change="PageCurrentChange"
            />
        </div>
    </div>
</template>

<script lang="tsx">
import { ref, reactive, onMounted, nextTick, defineComponent } from "vue";
import Http, {responseInterface} from "@/utils/http";
import hMain from "./main";
import { VueDraggableNext } from "vue-draggable-next";
import { ElMessage } from "element-plus";

interface ParentParams {
    readonly page: number;
    readonly size: number;
}
export default defineComponent({
    provide() {
        return this;
    },
    components: {
        hMain,
        draggable: VueDraggableNext
    },
    props: {
        // 请求地址
        url: { type: String, default: "" },
        ref: { type: String, default: "hCustRef" },
        // 数据来源
        params: Array,
        // 表格自定义扩展参数
        tableAttrs: { type: Object, default: () => {} },
        // 多选的值
        selection: { type: Array, default: () => [] },
        page: {
            type: Object,
            default: () => ({
                size: 10,
                sizes: [10, 20, 30, 50],
                layout: "total, sizes, prev, pager, next, jumper"
            })
        }
    },
    setup(props, { attrs, slots, emit }) {
        let { url } = props;
        let  params:any[] = props.params as any[]
        const tableLoading = ref(false);
        const tableStatus = ref(true); // 表格if
        const tableData = ref([]); // 列表数据
        const pageData = reactive({ total: 0, page: 1, size: 10 }); // 分页参数
        const colSettings = ref([] as any[]); // 列的设置参数
        const isIndeterminate = ref(false); // 列的设置参数,  用以表示 checkbox 的不确定状态，一般用于实现全选的效果
        const settingCheckAll = ref(true); // 列的设置参数, 多选状态
        /* 处理对象，加载初始化值 */
        const setupTableAttrs = reactive({
            stripe: true, //  带斑马纹表格
            "header-row-class-name": "h-table-header-name",
            "row-class-name": "table-row-name",
            ...props.tableAttrs
        });
        onMounted(() => {
            pageData.page = 1;
            pageData.size = props.page.size;
            query();
            InitSettingsCol();
        });
        const http = new Http(url)
        /**
         *  查询列表
         * parentParams 父组件查询传参
         */
        async function query() {
            /* 查询参数 */
            const params = {
                page: pageData.page,
                size: pageData.size
            };
            tableLoading.value = true;
            try {
                const res:any = await http.Get( params );
                if (res.code == 200) {
                    const data = res.data;
                    tableData.value = data.list;
                    pageData.total = data.total;
                } else {
                    ElMessage.info(res.message);
                }
                tableLoading.value = false;
            } catch (err) {
                console.log(err);
                tableLoading.value = false;
            }
        }

        /* 操作分页 */
        function PageSizeChange(val:number) {
            pageData.size = val;
            query();
        }
        function PageCurrentChange(val:number) {
            pageData.page = val;
            query();
        }

        /**
         *  重新刷新table
         *  time  列表刷新时间  number 毫秒
         */
        async function TableReflash(time = 0) {
            tableLoading.value = true;
            tableStatus.value = false;
            await nextTick();
            tableStatus.value = true;
            if (time > 0) {
                setTimeout(() => {
                    tableLoading.value = false;
                }, time);
            } else {
                tableLoading.value = false;
            }
        }
        /**
         *  初始化设置列设置参数
         */
        function InitSettingsCol() {
            try {
                const localSettings = localStorage.getItem(
                    "col-settings-" + props.ref
                );
                if (localSettings) {
                    const array = JSON.parse(localSettings);
                    const retArray = array.map((item:any) => {
                        const data = params.filter(
                            (p:any) => p.prop == item.prop
                        )
                        return {
                            ...data[0],
                            status: item.status
                        };
                    });
                    colSettings.value = retArray;
                    return;
                }
            } catch (error) {
                console.log(error);
            }
            DefaultColSettings(true);
        }
        /**
         *  默认列设置，赋值
         *  reset 是否重置  boolean
         */
        function DefaultColSettings(reset:boolean) {
            colSettings.value = params.map(item => {
                return {
                    ...item,
                    status: true
                };
            });
            if (reset === true) {
                ChangeSettingsCol(true);
            }
        }

        /* 设置列参数方法 */
        function ChangeSettingsCol(status:boolean) {
            isIndeterminate.value = colSettings.value.some(
                (item:any) => item.status !== status
            ); // indeterminate 属性用以表示 checkbox 的不确定状态
            settingCheckAll.value = colSettings.value.every(
                (item:any) => item.status === true
            );

            try {
                const str = JSON.stringify(colSettings.value);
                localStorage.setItem("col-settings-" + props.ref, str);
            } catch (error) {
                console.log(error);
            }

            TableReflash(500);
        }
        /* 列设置，全选操作 */
        function ChangeColSettingAll(status:boolean) {
            isIndeterminate.value = false;
            colSettings.value = params.map(item => {
                return {
                    ...item,
                    status: status
                };
            });
            TableReflash(500);
        }

        /**
         * 编辑内容
         */
        function EditInfo(info:any) {
            emit("edit", info);
        }
        /**
         * 删除内容
         */
        function DeleteInfo(list:any) {
            emit("del", list);
        }
        /**
         *  多选
         */
        function Selection(val:any) {
            emit("update:selection", val);
        }
        /* 获取分页信息 */
        emit("get-page", pageData);
        return {
            query,
            tableLoading,
            tableStatus,
            tableData,
            setupTableAttrs,
            pageData,
            PageSizeChange,
            PageCurrentChange,
            TableReflash,
            colSettings,
            ChangeSettingsCol,
            DefaultColSettings,
            isIndeterminate,
            settingCheckAll,
            ChangeColSettingAll,
            EditInfo,
            DeleteInfo,
            Selection
        };
    },
    methods: {
        // 获取table ref 对象
        getTableRef() {
            return this.$refs.hCustTableRef.getTableRef();
        }
    }
});
</script>
