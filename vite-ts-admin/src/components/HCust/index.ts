
import Table from './Table/index.vue'
import QueryForm from './QueryForm/index'
import Drawer from './Drawer/index.vue'
import Dialog from './Dialog/index'

export default (app: any) => {
    app.component('HTable', Table);
    app.component('HQueryForm', QueryForm);
    app.component('HDrawer', Drawer);
    app.component('HDialog', Dialog);
}
