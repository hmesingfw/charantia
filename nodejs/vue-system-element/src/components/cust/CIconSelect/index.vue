<template>
    <el-popover placement="bottom-start" width="460" trigger="click" popper-class="c-icon-select">
        <el-tabs>
            <el-tab-pane label="Icons" style="height:270px">
                <el-scrollbar class="scrollbar">
                    <el-row>
                        <el-col :span="3" v-for="item of svgIcons" :key="item" class="custom">
                            <svg-icon :icon-class="item" class-name="svg-class" @click="handleClipboard(item)" />
                        </el-col>
                    </el-row>
                </el-scrollbar>
            </el-tab-pane>
            <el-tab-pane label="Element-UI Icons" style="height:270px">
                <el-scrollbar class="scrollbar">
                    <el-row>
                        <el-col :span="3" v-for="item of elementIcons" :key="item">
                            <i :class="'el-icon-' + item" @click="handleClipboard('el-icon-' +item)" />
                        </el-col>
                    </el-row>
                </el-scrollbar>
            </el-tab-pane>
        </el-tabs>
        <el-input v-model="iconValue" slot="reference"></el-input>
    </el-popover>
</template>
<script>  
import svgIcons from '@/views/icons/svg-icons'
import elementIcons from '@/views/icons/element-icons'
export default {
    prop: {
        value: { type: String }
    },
    data() {
        return {
            iconValue: '',
            svgIcons,
            elementIcons
        }
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
</style>