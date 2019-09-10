<template>
    <div class="temp">
        <el-tabs type="border-card">
            <el-tab-pane label="弹出框">
                <model v-model="modelValue" title="人员信息">
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
                            <el-button type="primary" @click="onSubmit">查询</el-button>
                        </el-form-item>
                    </el-form>
                </model>
                <el-row>
                    <el-button plain>朴素按钮</el-button>
                    <el-button type="primary" @click="toggers(true)">主要按钮</el-button>
                    <el-button type="success" @click="toggers(false)">成功按钮</el-button>
                    <el-button type="info" plain>信息按钮</el-button>
                    <el-button type="warning" plain>警告按钮</el-button>
                    <el-button type="danger" plain>危险按钮</el-button>
                </el-row>
                <el-cascader
                    size="large"
                    :options="options"
                    v-model="selectedOptions"
                    filterable
                    @change="handleChange"
                    :props="props"
                ></el-cascader>
            </el-tab-pane>
            <el-tab-pane>
                <span slot="label">
                    <i class="el-icon-date"></i>表格
                </span>
                <el-table :data="tableData" border style="width: 100%">
                    <el-table-column prop="date" label="日期" width="180"></el-table-column>
                    <el-table-column prop="name" label="姓名" width="180"></el-table-column>
                    <el-table-column prop="address" label="地址"></el-table-column>
                </el-table>
            </el-tab-pane>
            <el-tab-pane label="表单">
                <el-form label-position="right" label-width="80px" :model="formLabelAlign">
                    <el-form-item label="名称">
                        <el-input v-model="formLabelAlign.name"></el-input>
                    </el-form-item>
                    <el-form-item label="活动区域">
                        <el-input v-model="formLabelAlign.region"></el-input>
                    </el-form-item>
                    <el-form-item label="活动形式">
                        <el-input v-model="formLabelAlign.type"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" @click="onSubmit">立即创建</el-button>
                        <el-button>取消</el-button>
                    </el-form-item>
                </el-form>
            </el-tab-pane>
            <el-tab-pane label="树形结构">
                <el-tree
                    :data="data"
                    show-checkbox
                    node-key="id"
                    :default-expanded-keys="[2, 3]"
                    :default-checked-keys="[5]"
                    :props="defaultProps"
                ></el-tree>
            </el-tab-pane>
        </el-tabs>
    </div>
</template>

<script>
import { regionDataPlus } from 'element-china-area-data'
console.log(regionDataPlus);
import model from "./model";
export default {
    components: {
        model
    },
    data () {
        return {
            options: regionDataPlus,
            selectedOptions: [],
            props: { value: 'label' },

            modelValue: false,
            tableData: [
                {
                    date: "2016-05-02",
                    name: "王小虎",
                    address: "上海市普陀区金沙江路 1518 弄"
                },
            ],
            formLabelAlign: {
                name: "",
                region: "",
                type: ""
            },
            formInline: {
                user: "",
                region: ""
            },
            data: [
                {
                    id: 1,
                    label: "一级 1",
                    children: [
                        {
                            id: 4,
                            label: "二级 1-1",
                            children: [
                                {
                                    id: 9,
                                    label: "三级 1-1-1"
                                },
                                {
                                    id: 10,
                                    label: "三级 1-1-2"
                                }
                            ]
                        }
                    ]
                },
                {
                    id: 2,
                    label: "一级 2",
                    children: [
                        {
                            id: 5,
                            label: "二级 2-1"
                        },
                        {
                            id: 6,
                            label: "二级 2-2"
                        }
                    ]
                },
                {
                    id: 3,
                    label: "一级 3",
                    children: [
                        {
                            id: 7,
                            label: "二级 3-1"
                        },
                        {
                            id: 8,
                            label: "二级 3-2"
                        }
                    ]
                }
            ],
            defaultProps: {
                children: "children",
                label: "label"
            }
        };
    },
    methods: {
        toggers (val) {
            this.modelValue = val;
        },
        onSubmit () {
            console.log("submit!");
        },
        handleChange (value) {
            console.log(value)
        }
    }
};
</script>

<style lang="scss" scoped>
.temp {
    padding: 20px;
}
</style>
