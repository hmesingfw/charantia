
import Table from './Table/index.vue'
import QueryForm from './QueryForm/index.jsx'
import Drawer from './Drawer/index.vue'
import ImageMatting from './ImageMatting'

export default (app) => {
    app.component('HTable', Table);
    app.component('HQueryForm', QueryForm);
    app.component('HDrawer', Drawer);
    app.component('HImageMatting', ImageMatting);
}
