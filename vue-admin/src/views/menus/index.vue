<template>
    <el-row>
        <el-col :span="10">
            <el-input placeholder="输入关键字进行过滤" v-model="filterText"></el-input>

            <el-tree
                :data="data"
                node-key="id"
                ref="treeRef"
                :props="defaultProps"
                :filter-node-method="filterNode"
                default-expand-all
            >
                <span class="custom-tree-node" slot-scope="{ node, data }">
                    <span v-if="language == 'zh'" class="title">{{ data.titelZh }}</span>
                    <span v-if="language == 'en'" class="title">{{ data.titelEn }}</span>
                    <span>
                        <el-button type="text" size="mini" @click.stop="deleteForm(data)">delete</el-button>
                        <el-button type="text" size="mini" @click.stop="openForm(data)">Append</el-button>
                    </span>
                </span>
            </el-tree>
        </el-col>
        <el-col :span="14">
            <transition name="el-fade-in">
                <el-form
                    ref="ruleForm"
                    v-loading="loading"
                    :model="form"
                    :rules="rules"
                    label-width="100px"
                >
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="中文名称：" prop="titelZh">
                                <el-input v-model="form.titelZh" placeholder="中文名称，暂时没有验证"></el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="英文名称：" prop="titelEn">
                                <el-input v-model="form.titelEn" placeholder="英文名称，暂时没有验证"></el-input>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-form-item label="路径：" prop="path">
                        <el-input v-model="form.path"></el-input>
                    </el-form-item>
                    <el-form-item label="状态：" prop="status">
                        <el-switch
                            v-model="form.status"
                            active-text="启用"
                            inactive-text="禁用"
                            active-value="1"
                            inactive-value="0"
                        ></el-switch>
                    </el-form-item>
                    <el-form-item label="权重：" prop="sort">
                        <el-input-number v-model="form.sort" :min="1" label="权重"></el-input-number>
                    </el-form-item>

                    <el-form-item label="组件路径：">
                        <el-input v-model="form.component" placeholder="跳转组件"></el-input>
                    </el-form-item>
                    <el-form-item label="图标：">
                        <el-input v-model="form.icon" placeholder="跳转组件"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" @click="onSubmit">保存数据</el-button>
                        <el-button>取消</el-button>
                    </el-form-item>
                </el-form>
            </transition>
        </el-col>
    </el-row>
</template>
<script>
export default {
    name: 'menus',
    computed: {
        /** 获取语言缓存值 */
        language () {
            return this.$store.getters.language;
        }
    },
    data () {
        return {
            loading: false,
            filterText: '', // 树形结构过滤条件
            data: [],       // 树形结构数据
            defaultProps: {
                children: 'children',
            },
            form: {
                status: '1',
                sort: 1,
                icon: ''
            },
            rules: {
                titelZh: [{ required: true, message: '请输入菜单中文名称！', trigger: 'blur' }],
                titelEn: [{ required: true, message: '请输入菜单英文名称！', trigger: 'blur' }],
                path: [{ required: true, message: '请输入路径！', trigger: 'blur' }],
                status: [{ required: true, message: '请选择状态', }],
                sort: [{ required: true, message: '请输入输入权重' }],
            }
        };
    },
    created () {
        this.getMeuns();
    },
    methods: {
        getMeuns () {
            this.$http.get(`/egg/getMenus`).then(res => {
                this.data = res.data;
                console.log(res);
            }).catch(err => {

            })
        },
        /** 打开form 表单信息 */
        openForm (data) {
            this.loading = true;
            this.form = data;
            setTimeout(() => {
                this.loading = false;
            }, 100);
        },
        /** 删除表单数据 */
        deleteForm (data) {
            this.$http.post(`/egg/delMenus`, { id: data.id }).then(res => {
                console.log(res);
            }).catch(err => {
                this.$message(err)
            })
        },
        onSubmit () {
            this.$refs.ruleForm.validate((valid) => {
                if (valid) {
                    delete this.form.createdAt;
                    delete this.form.updatetime;

                    this.loading = true;
                    this.$http.post(`/egg/addMenus`, this.form).then(res => {
                        this.loading = false;
                        if (res.data == '1') {
                            this.$message({
                                'type': 'success',
                                'message': '保存成功'
                            })
                            this.getMeuns();
                        } else {
                            this.$message('操作失败');
                        }
                    }).catch(err => {
                        this.loading = false;
                        this.$message(err)
                    })
                } else {
                    return false;
                }
            });
        },
        /** 过滤参数 */
        filterNode (value, data) {
            if (!value) return true;
            if (this.language == 'zh') {
                return data.titelZh.indexOf(value) !== -1;
            } else if (this.language == 'en') {
                return data.titelEn.indexOf(value) !== -1;
            }
            return true;
        }

    },
    watch: {
        /** 过滤参数 */
        filterText (val) {
            this.$refs.treeRef.filter(val);
        }
    },
}
</script>

<style lang="less" scoped>
.custom-tree-node {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;

    .title {
        line-height: 28px;
    }
}
</style>

