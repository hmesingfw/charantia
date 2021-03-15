<template>
    <el-row class="c-tag">
        <span v-for="(tag, i) in value" :key="tag.id">
            <el-tag v-if="i < len" :style="{color: tag.color, borderColor: tag.color}" @click="handleTag" class="title">{{tag.title}}</el-tag>
        </span>
        <el-badge v-if="value.length > len" :value="value.length - len" class="item" type="primary">
            <el-tag @click="handleTag" class="title">...</el-tag>
        </el-badge>

        <el-tag v-if="value.length == 0" @click="handleTag" class="title">选择标签</el-tag>

        <s-tag-model :value="dialogValue" :list="tagList" :target="target" @suc="() => dialogValue = false" @callback="init" v-if="flashTag"></s-tag-model>
    </el-row>
</template>
<script>
import { mapGetters } from "vuex";
import STagModel from './STagModel'
export default {
    components: {
        STagModel
    },
    props: {
        len: { type: Number, default: 3 },
        target: { type: Object, default: () => ({ key: 'event', id: 'eventId' }) },         // 保存标签到某模块
        value: { type: Array },           // 选中的标签内容
    },
    computed: {
        ...mapGetters([])
    },
    mounted() {
    },

    data() {
        return {
            tags: [],
            dialogValue: false,
            tagList: [],

            flashTag: true,
        }
    },
    methods: {
        async init(val) {
            this.$emit('input', val || [])
        },
        async handleTag() {
            this.tagList = this.DeepCopy(this.value);
            this.dialogValue = true;

            this.flashTag = false;
            this.$nextTick(() => {
                this.flashTag = true;
            })
        },
    },

}
</script>
<style lang="scss">
.c-tag {
    .title {
        margin-right: 8px;
        cursor: pointer;
    }
}
</style>