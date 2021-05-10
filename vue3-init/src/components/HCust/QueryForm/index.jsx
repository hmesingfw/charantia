import { ref, reactive } from 'vue'
export default {
    name: 'QueryForm',
    render() {
        return (
            <el-form class='h-query-form' ref={this.ref} model={this.model} {...this.setupFormAttrs} onKeyDown={e => this.onKeyDownchange(e)} onSubmit={event => event.preventDefault()} >
                <el-row type='flex' justify='space-between' >

                    {
                        this.params.map((item, index) => {
                            /* 渲染组件 */
                            let compoentContent = '';
                            if (item.formatF) {
                                /* 自定义组件，优先级 */
                                compoentContent = item.formatF;
                            } else {
                                switch (item.type) {
                                    case 'input':
                                        compoentContent = <el-input vModel={this.model[item.prop]} placeholder='请输入' {...item.attrs} />
                                        break;
                                    case 'select':
                                        // eslint-disable-next-line no-case-declarations
                                        const optList = item.option;
                                        compoentContent = <el-select vModel={this.model[item.prop]} placeholder='请选择' {...item.attrs} onChange={() => this.query()} style='width:100%'>
                                            {
                                                optList.map(opt => {
                                                    return <el-option label={opt.label} value={opt.value} {...opt.attrs}></el-option>
                                                })
                                            }
                                        </el-select>
                                        break;
                                    case 'time':
                                        compoentContent =
                                            <el-date-picker
                                                vModel={this.timeValue}
                                                type='daterange'
                                                format='YYYY-MM-DD'
                                                range-separator='-'
                                                start-placeholder='请选择开始时间'
                                                end-placeholder='请选择结束时间'
                                                onChange={() => this.query()}
                                            />
                                        break
                                    default:
                                        return '';
                                }
                            }

                            return <el-collapse-transition>
                                <el-col lg={8} sm={12} xs={24} v-show={index < 2 ? true : this.arrowStatus == 'up'} >
                                    <el-form-item label={item.label} prop={item.prop} >
                                        {compoentContent}
                                    </el-form-item>
                                </el-col>
                            </el-collapse-transition>
                        })
                    }
                    <el-col lg={8} sm={12} xs={24}>
                        <el-row type='flex' justify='end' class='h-handles'>
                            <el-button icon='el-icon-search' type='primary' onClick={() => this.query()}>查询</el-button>
                            <el-button icon='el-icon-refresh' onClick={() => this.resetModel()}>重置</el-button>
                            {
                                /* 当查询条件大于2种以上时显示-展示按钮 */
                                this.params && this.params.length > 2 &&
                                <>
                                    <el-button v-show={this.arrowStatus == 'down'} type='text' onClick={() => this.changeArrowStatus('up')}>展示 <i class='el-icon-arrow-down el-icon--right' ></i></el-button>
                                    <el-button v-show={this.arrowStatus == 'up'} type='text' onClick={() => this.changeArrowStatus('down')}>收起 <i class='el-icon-arrow-up el-icon--right' ></i></el-button>
                                </>
                            }
                        </el-row>
                    </el-col>
                </el-row>
            </el-form>
        )
    },
    props: {
        model: {
            type: Object,
            default: () => { }
        }, // 数据对象
        formAttrs: {
            type: Object,
            default: () => { }
        }, // 表单扩展对象
        ref: { type: String, default: 'hCustRef' },
        params: { type: Array, }
    },
    setup(props) {
        const timeValue = ref([]); // 时间vmodel
        const pickerOptions = reactive({}); // 时间option
        const arrowStatus = ref('down'); // 箭头状态    true  收起   false 展示

        /* 处理对象，加载初始化值 */
        const setupFormAttrs = {
            'label-width': '100px', // 默认label宽度
            ...props.formAttrs,
        }
        /* 处理回车事件 */
        function onKeyDownchange(e) {
            /* 回车事件 */
            if (e.keyCode == 13) {
                query();
            }
        }

        function query() {
            console.log(props.model);
        }
        /* 重置查询条件 */
        function resetModel() {
            const form = props.model;
            for (const key in form) {
                if (form[key] instanceof Array) {
                    form[key] = [];
                } else {
                    form[key] = '';
                }
            }
        }

        /* 切换箭头状态 */
        function changeArrowStatus(status) {
            arrowStatus.value = status;
        }
        return {
            timeValue,
            pickerOptions,
            arrowStatus,
            setupFormAttrs,
            onKeyDownchange,
            changeArrowStatus,
            resetModel,
            query,
        }
    },

}
