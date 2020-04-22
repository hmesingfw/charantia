<template>
    <dialog-model v-model="value" width="700" title="权限信息" @submit="handleRoleUser" :loading-button="loadingButton" @colse="colse" :isColse="false" @changeLoadingButton="loadingButton = false">
        <div class="role-list">
            <el-checkbox-group v-model="rml">
                <div v-for="item in menuList" :key="item.id">
                    <div class="role-row">
                        <el-checkbox :label="item.id">{{ item.title }}</el-checkbox>
                    </div>
                    <div v-for="child in item.children" :key="child.id">
                        <div class="role-row padding-left">
                            <el-checkbox :label="child.id">{{ child.title }}</el-checkbox>
                        </div>
                        <div class="role-row handle-group padding-left-s" v-if="child.children && child.children.length>0">
                            <el-checkbox v-for="hand in child.children" :key="hand.id" :label="hand.id">{{ hand.title }}</el-checkbox>
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
        }
    },
    watch: {
        roleMenuList(val) {
            this.changeRML(val);
        },
    },


    methods: {
        /* 解决文件单向流动时，系统提示错误 */
        changeRML(val) {
            this.rml = val;
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
        colse() {
            this.$emit('input', false);
        }
    }
}
</script>
<style lang="scss">
.role-list {
    padding: 10px;
    .role-row {
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
        padding-left: 20px;
    }
    .padding-left-s {
        padding-left: 40px;
    }
}
</style>

