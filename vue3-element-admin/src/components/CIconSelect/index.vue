<template>
    <el-popover v-if="flashInput" placement="bottom-start" width="460" trigger="click" popper-class="c-icon-select">
        <el-tabs>
            <el-tab-pane label="系统图标" style="height:270px">
                <el-scrollbar class="scrollbar">
                    <el-row>
                        <el-col v-for="item of svgIcons" :key="item" :span="3" class="custom">
                            <svg-icon :icon-class="item" class-name="svg-class" @click="handleClipboard(item)" />
                        </el-col>
                    </el-row>
                </el-scrollbar>
            </el-tab-pane>
            <el-tab-pane label="自定义图标" style="height:270px">
                <el-scrollbar class="scrollbar">
                    <el-row>
                        <el-col v-for="item of elementIcons" :key="item" :span="3">
                            <i :class="'el-icon-' + item" @click="handleClipboard('el-icon-' +item)" />
                        </el-col>
                    </el-row>
                </el-scrollbar>
            </el-tab-pane>
        </el-tabs>

        <el-input v-if="isCustIcon == 'null'" slot="reference" />

        <div v-if="isCustIcon == 'el'" slot="reference" class="cursor-icon-select">
            <i :class="iconValue" style="font-size: 24px;" />
        </div>

        <div v-if="isCustIcon == 'cust'" slot="reference" class="cursor-icon-select">
            <svg-icon :icon-class="iconValue" style="font-size: 22px;" />
        </div>
    </el-popover>
</template>
<script>
import svgIcons from '@/views/icons/svg-icons'
import elementIcons from '@/views/icons/element-icons'
export default {
    props: {
        value: { type: String }
    },
    data() {
        return {
            iconValue: '',
            svgIcons,
            elementIcons,
            flashInput: true,
        }
    },
    computed: {
        isCustIcon() {
            if (!this.value) return 'null'
            if (this.value.indexOf('el-') == -1) {
                return 'cust';
            }
            return 'el'
        },
    },
    created() {
        this.setVal(this.value);
    },
    methods: {
        handleClipboard(iconName) {
            this.iconValue = iconName;
            this.$emit('input', iconName)
        },
        setVal(val) {
            this.iconValue = val;
            this.flash();
        },
        flash() {
            this.flashInput = false;
            this.$nextTick(() => {
                this.flashInput = true;
            })
        },

    },

    watch: {
        value(val) {
            this.setVal(val);
        }
    }
}
</script>

<style lang="scss">
.c-icon-select {
    i {
        font-size: 36px;
        cursor: pointer;
    }
    .custom {
        margin-bottom: 6px;
    }

    .svg-class {
        font-size: 28px;
        cursor: pointer;
    }

    .el-scrollbar__wrap {
        overflow-x: hidden;
    }
    .scrollbar {
        height: 100%;
    }
}
.cursor-icon-select {
    cursor: pointer;
}
</style>
