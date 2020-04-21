
// <template>
//     <el-table :data="data" @selection-change="selectionChange" :stripe="stripe" header-row-class-name="table-header-color">
//         <el-table-column type="selection" width="42"></el-table-column>

//         <el-table-column v-for="(item, i) in params" :key="i" :prop="item.prop" :label="item.label"></el-table-column>
//     </el-table>
// </template>
export default {
    render(h) {
        return <el-table data={this.data} on-selection-change={this.selectionChange} stripe={this.stripe} header-row-class-name="table-header-color" >
            <el-table-column type="selection" width="42"></el-table-column>
            {
                this.params.map(item => {
                    return <el-table-column prop={item.prop} label={item.label} >
                        <template slot-scope="scope">
                            {item.f}
                        </template>
                    </el-table-column>
                })
            }
        </el-table>
    },
    props: {
        data: Array,                       // 数据来源
        params: Array,
        stripe: { type: Boolean, default: true },
        url: { type: String, default: '' },
        callbacl: { type: Function, default: () => { } }

    },
    methods: {
        selectionChange(val) {
            console.log(this.params);
            this.$emit('selection-change', val);
        },
    }
}
