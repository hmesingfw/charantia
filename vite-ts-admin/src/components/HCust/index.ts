
import Table from './Table/index.vue'
import QueryForm from './QueryForm/index'
import Drawer from './Drawer/index.vue'

export default (app: any) => {
    app.component('HTable', Table);
    app.component('HQueryForm', QueryForm);
    app.component('HDrawer', Drawer);
}
