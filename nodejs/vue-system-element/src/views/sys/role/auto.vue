<template>
    <dialog-model v-model="value" width="700" title="权限信息" @submit="handleRoleUser" :loading-button="loadingButton" @colse="colse" :isColse="false" @changeLoadingButton="loadingButton = false">
        <div class="role-list">
            <div class="all-check">
                <el-checkbox @change="val => changeCheckboxAll(val)" v-model="checkboxAll">全选</el-checkbox>
            </div>
            <el-checkbox-group v-model="rml">
                <div v-for="item in menuList" :key="item.id">
                    <div class="role-row">
                        <el-checkbox :label="item.id" @change="val => changeCheckbox(val, item.children)">{{ item.title }}</el-checkbox>
                    </div>
                    <div v-for="child in item.children" :key="child.id">
                        <div class="role-row padding-left">
                            <el-checkbox :label="child.id" @change="val => changeCheckbox(val, child.children)">{{ child.title }}</el-checkbox>
                        </div>
                        <div class="role-row handle-group padding-left-s" v-if="child.children && child.children.length>0">
                            <el-checkbox v-for="hand in child.children" :key="hand.id" :label="hand.id" @change="val => changeCheckboxChild(val, child.id)">{{ hand.title }}</el-checkbox>
                        </div>
                    </div>
                </div>
            </el-checkbox-group>
        </div>
    </dialog-model>
</template>
<script>
export default {
    props: {
        value: Boolean,
        callback: Function,
        row: Object,
        roleMenuList: Array
    },
    created() {
        this.init();
        this.changeRML(this.roleMenuList);
    },
    data() {
        return {
            menuList: [],       // 菜单列表
            loadingButton: false,
            rml: [],
            checkboxAll: false,  // 全选按钮

        }
    },
    watch: {
        roleMenuList(val) {
            this.changeRML(val);
        },
    },


    methods: {
        /* 解决文件单向流动时，系统提示错误 */
        changeRML(list) {
            this.rml = list.map(item => item.menuId);
        },
        /* 查询操作 */
        init() {
            this.tableLoading = true;
            this.$http.get(this.$api.sys.menu).then(res => {
                this.menuList = res.data.rows;
            })
        },
        async handleRoleUser() {
            this.loadingButton = true;
            // let map = this.roleMenuList.map(item => ({ roleId: this.row.id, menuId: item }));
            let map = { roleId: this.row.id, menuId: this.rml }
            let data = await this.$http.post(`${this.$api.sys.roleMenu}`, map);
            this.$message.success(data.data.message);

            this.loadingButton = false;


            this.callback();
            this.$emit('input', false);
        },

        /* 选中子节点，勾选父节点 */
        changeCheckboxChild(val, pid) {
            if (val) {
                /* 添加 */
                if (!this.rml.includes(pid)) {
                    this.rml.push(pid);
                }
            }
        },
        /* 选中父节点，勾选子节点 */
        /* val 是否选中
        *  list 选中时的子数据结构 
         */
        changeCheckbox(val, list) {
            let idlist = this.forms(list);
            if (val) {
                idlist.forEach(item => {
                    /* 添加 */
                    if (!this.rml.includes(item)) {
                        this.rml.push(item);
                    }
                })
            } else {
                idlist.forEach(item => {
                    /* 去除 */
                    this.rml = this.rml.filter(function (i) {
                        return item != i
                    });
                })
            }

        },
        /* 根据ID判断，取出相应的子ID值 */
        forms(list) {
            let returnlist = [];
            this.getId(list, returnlist);
            return returnlist;
        },
        /* 获取树形菜单中的ID */
        /* objList   树形结构
        *  reIdList  返回ID列表        
        */
        getId(objList, reIdList) {
            objList.forEach(item => {
                reIdList.push(item.id);

                if (item.children && item.children.length > 0) {
                    this.getId(item.children, reIdList);
                }
            });
        },
        /* 全选 */
        changeCheckboxAll(val) {
            if (val) {
                let idlist = this.forms(this.menuList);
                this.rml = idlist;
            } else {
                this.rml = [];
            }
        },
        colse() {
            this.$emit('input', false);
        }
    }
}
</script>
<style lang="scss">
.role-list {
    padding: 10px;
    .all-check {
        border-bottom: 1px solid #ebeef5;
        height: 40px;
        display: flex;
        align-items: center;
        flex-wrap: wrap;
    }
    .role-row {
        padding-left: 30px;
        height: 40px;
        display: flex;
        align-items: center;
        flex-wrap: wrap;
        border-bottom: 1px solid #ebeef5;
        .handle-group {
            display: flex;
            align-items: center;
        }
    }

    .padding-left {
        padding-left: 60px;
    }
    .padding-left-s {
        padding-left: 90px;
    }
}
</style>

