<template>
    <el-row>
        <el-col :span="10">
            <el-input :placeholder="$t('views.treeInputPlace')" v-model="filterText"></el-input>

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
                            <el-form-item :label="$t('views.titleZh')" prop="titelZh">
                                <el-input v-model="form.titelZh"></el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item :label="$t('views.titleEn')" prop="titelEn">
                                <el-input v-model="form.titelEn"></el-input>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-form-item :label="$t('views.path')" prop="path">
                        <el-input v-model="form.path"></el-input>
                    </el-form-item>
                    <el-form-item :label="$t('views.status')" prop="status">
                        <el-switch
                            v-model="form.status"
                            :active-text="$t('views.active')"
                            :inactive-text="$t('views.inactive')"
                            active-value="1"
                            inactive-value="0"
                        ></el-switch>
                    </el-form-item>

                    <el-form-item :label="$t('views.show')" prop="status">
                        <el-switch
                            v-model="form.show"
                            :active-text="$t('views.showActive')"
                            :inactive-text="$t('views.showInactive')"
                            active-value="1"
                            inactive-value="0"
                        ></el-switch>
                    </el-form-item>
                    <el-form-item :label="$t('views.sort')" prop="sort">
                        <el-input-number v-model="form.sort" :min="1"></el-input-number>
                    </el-form-item>

                    <el-form-item :label="$t('views.component')">
                        <el-input v-model="form.component"></el-input>
                    </el-form-item>
                    <el-form-item :label="$t('views.icon')">
                        <el-input v-model="form.icon"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" @click="onSubmit">{{ $t('basic.save') }}</el-button>
                        <el-button>{{ $t('basic.cancel') }}</el-button>
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
                icon: '',
                show: '1'
            },
            rules: {
                titelZh: [{ required: true, message: '请输入菜单中文名称！', trigger: 'blur' }],
                titelEn: [{ required: true, message: '请输入菜单英文名称！', trigger: 'blur' }],
                path: [{ required: true, message: '请输入路径！', trigger: 'blur' }],
                status: [{ required: true, message: '请选择', }],
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
            }).catch(err => {
                console.log(err);
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
            this.$confirm(this.$t('basic.comfirmDelete'), this.$t('basic.prompt'), {
                confirmButtonText: this.$t('basic.define'),
                cancelButtonText: this.$t('basic.cancel'),
                type: 'warning'
            }).then(() => {
                this.$http.post(`/egg/delMenus`, { id: data.id }).then(res => {
                    if (res.data == 1) {
                        this.getMeuns();
                        this.$message.success(this.$t('basic.delSuc'));
                    } else {
                        this.$message(this.$t('basic.delFail'));
                    }
                }).catch(err => {
                    this.$message(err)
                })
            }).catch(() => {
                this.$message(this.$t('basic.delCancel'));
            });

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
                            this.$message.success(this.$t('basic.saveSuc'));
                            this.getMeuns();
                        } else {
                            this.$message(this.$t('basic.saveFail'));
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

