<template>
    <div class="dialog">
        <div class="full-panel-dialog" v-show="value" @click="close"></div>
        <div class="model" :style="{ marginRight: marginWidth + 'px' }">
            <div class="el-dialog__header">
                <span class="el-dialog__title">{{ title }}</span>
                <button
                    type="button"
                    aria-label="Close"
                    class="el-dialog__headerbtn"
                    @click="close"
                >
                    <i class="el-dialog__close el-icon el-icon-close"></i>
                </button>
            </div>
            <div class="main-body">
                <slot></slot>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "model",
    props: {
        value: { type: [Boolean], default: false },
        title: { type: String, default: "提示" },
        width: { type: [Number, String], default: 500 }
    },
    data() {
        let temp = -this.width;
        return {
            marginWidth: temp
        };
    },
    methods: {
        loading() {
            var inter = setInterval(() => {
                if (this.marginWidth < 0) {
                    this.marginWidth = this.marginWidth + 5;
                } else {
                    window.clearInterval(inter);
                }
            }, 1);
        },

        close() {
            var inter = setInterval(() => {
                if (this.marginWidth > -this.width) {
                    this.marginWidth = this.marginWidth - 5;
                } else {
                    window.clearInterval(inter);
                }
            }, 5);
            this.$emit("input", false);
        }
    },
    watch: {
        value(val) {
            window.clearInterval("inter");

            if (val === false) {
                this.close();
            } else {
                this.loading();
            }
        }
    }
};
</script>



<style lang="scss" scoped>
.dialog {
    .full-panel-dialog {
        position: fixed;
        top: 0;
        right: 0;
        height: 100%;
        width: 100%;
        background-color: #fff;
        z-index: 8;

        opacity: 0;
        filter: alpha(opacity=0);
    }
    .model {
        position: fixed;
        top: 0;
        right: 0;
        height: 100%;
        width: 500px;
        margin-right: -300px;
        background-color: #fff;
        z-index: 10;

        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        .el-dialog__header {
            border-bottom: 1px solid #ebeef5;
        }

        .main-body {
            padding: 20px;
        }
    }
}
</style>
