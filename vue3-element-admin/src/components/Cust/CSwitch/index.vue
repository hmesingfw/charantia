<template>
    <div>
        <el-switch
            v-if="roles.includes(permission) || permission == 'default'"
            v-model="data[dataKey]"
            class="switch-style"
            v-bind="ConfigParmas[configtitle]"
            active-color="#4fc08d"
            @change="UpdateSwitch(data, url, dataKey, callback, {idKey:idKey})"
        />
        <div v-else>{{ ListMatchField('statusList', data[dataKey]) }}</div>
    </div>
</template>
<script>
import { mapGetters } from 'vuex';
export default {
    computed: {
        ...mapGetters([
            'roles'
        ])
    },
    props: {
        data: Object, // 数据对象
        url: String, // 请求地址
        dataKey: { type: [String, Number] }, // 修改字段
        callback: Function, // 回调方法

        permission: { type: String, default: 'default' }, // 权限

        configtitle: { type: String, default: 'switchValue' },
        idKey: { type: String, default: 'id' },
    }
}
</script>
