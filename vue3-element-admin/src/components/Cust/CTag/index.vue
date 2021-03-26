<template>
    <el-row class="c-tag">
        <span v-for="(tag, i) in tags" :key="tag.id">
            <el-tag v-if="i < len" :style="{color: tag.tagColor, borderColor: tag.tagColor}" @click="handleTag" class="title">{{tag.tagTitle}}</el-tag>
        </span>
        <el-badge v-if="tags.length > len" :value="tags.length - len" class="item" type="primary">
            <el-tag @click="handleTag" class="title">...</el-tag>
        </el-badge>

        <el-tag v-if="tags.length == 0" @click="handleTag" class="title">添加标签</el-tag>

        <s-tag-model :value="dialogValue" :form="form" :list="tagList" :url="url" :target="target" @suc="() => dialogValue = false" @callback="init"></s-tag-model>
    </el-row>
</template>
<script>
import { mapGetters } from "vuex";
export default {
    props: {
        url: String,        // 获取标签数据 请求的地址
        form: Object,
        len: { type: Number, default: 5 },
        target: { type: Object, default: () => ({ key: 'event', id: 'eventId' }) },         // 保存标签到某模块

    },
    computed: {
        ...mapGetters([])
    },
    mounted() {
        this.init();
    },
    watch: {
        url() {
            this.init();
        },
    },
    data() {
        return {
            tags: [],
            dialogValue: false,
            tagList: [],
        }
    },
    methods: {
        async init() {
            if (!this.url) return;
            let res = await this.$http.get(this.url);
            this.tags = res.data.data || [];
        },
        async handleTag() {
            this.dialogValue = true;
            this.tagList = this.tags.map(item => item.tagId);
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