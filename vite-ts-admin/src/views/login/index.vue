<template>
    <div class="login-container">
        <div class="login-content">
            <div class="title-container">
                <h3 class="title">Login Form</h3>
            </div>
            <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="login-form" autocomplete="on" label-position="left">
                <el-form-item prop="username">
                    <el-input ref="username" v-model="loginForm.username" placeholder="请输入用户名" type="text" tabindex="1" autocomplete="on" prefix-icon="el-icon-user" />
                </el-form-item>

                <el-form-item prop="password">
                    <el-input
                        ref="password"
                        v-model="loginForm.password"
                        type="password"
                        placeholder="请输入密码"
                        name="password"
                        tabindex="2"
                        autocomplete="on"
                        prefix-icon="el-icon-lock"
                        @keyup.native="checkCapslock"
                        @blur="capsTooltip = false"
                        @keyup.enter.native="handleLogin"
                    />
                </el-form-item>
                <el-row type="flex" justify="space-between" class="other-login">
                    <el-checkbox v-model="automaticLogin">自动登录</el-checkbox>
                    <el-button type="text">忘记密码</el-button>
                </el-row>
                <el-button :loading="loading" type="primary" style="width:100%;margin-bottom:30px;" @click.native.prevent="handleLogin">登&nbsp;&nbsp;录</el-button>
            </el-form>
        </div>
    </div>
</template>

<script>
export default {
    name: 'Login',
    data() {
        const validatePassword = (rule, value, callback) => {
            if (value.length < 6) {
                callback(new Error('密码不能少于6位数字'))
            } else {
                callback()
            }
        }
        return {
            automaticLogin: true,

            loginForm: {
                username: 'admin',
                password: '123456'
            },
            loginRules: {
                username: [{ required: true, trigger: 'blur', message: '请输入正确的用户名' }],
                password: [{ required: true, trigger: 'blur', validator: validatePassword }]
            },
            capsTooltip: false,
            loading: false,
            redirect: undefined,

        }
    },
    watch: {
        $route: {
            handler: function (route) {
                const query = route.query
                if (query) {
                    this.redirect = query.redirect
                }
            },
            immediate: true
        }
    },
    mounted() {
        if (this.loginForm.username === '') {
            this.$refs.username.focus()
        } else if (this.loginForm.password === '') {
            this.$refs.password.focus()
        }

        this.$http.post('/api/user/login', { account: 'admin', password: '123456' }).then(res => {
            console.log(res);
        })
    },
    methods: {
        checkCapslock({ shiftKey, key } = {}) {
            if (key && key.length === 1) {
                if (shiftKey && (key >= 'a' && key <= 'z') || !shiftKey && (key >= 'A' && key <= 'Z')) {
                    this.capsTooltip = true
                } else {
                    this.capsTooltip = false
                }
            }
            if (key === 'CapsLock' && this.capsTooltip === true) {
                this.capsTooltip = false
            }
        },
        handleLogin() {
            console.log('1');
            this.$refs.loginForm.validate(valid => {
                if (valid) {
                    this.loading = true
                    // this.$store.dispatch('user/login', this.loginForm).then(() => {
                    this.$router.push({ path: this.redirect || '/dashboard' })
                    //     this.loading = false
                    // }).catch(() => {
                    //     this.loading = false
                    // })
                } else {
                    return false
                }
            })
        },
    }
}
</script>
 
<style lang="scss" scoped>
.login-container {
    display: flex;
    -webkit-box-orient: vertical;
    -webkit-box-direction: normal;
    flex-direction: column;
    height: 100vh;
    overflow: auto;
    background-color: #f0f2f5;
    background-image: url(https://gw.alipayobjects.com/zos/rmsportal/TVYTbAXWheQpRcWDaDMu.svg);
    background-repeat: no-repeat;
    background-position-x: center;
    background-position-y: 110px;
    background-size: 100%;
    .login-content {
        padding: 32px 0;

        .title-container {
            text-align: center;
            .title {
                font-size: 33px;
                color: rgba(0, 0, 0, 0.85);
                font-family: "Myriad Pro", "Helvetica Neue", Arial, Helvetica,
                    sans-serif;
                font-weight: 600;
                position: relative;
                top: 2px;
            }
        }

        .login-form {
            width: 368px;
            margin: 40px auto 0;
        }

        .other-login {
            line-height: 4;
        }
    }
    @media (min-width: 768px) {
        .login-content {
            padding: 112px 0 24px;
        }
    }
}
</style>