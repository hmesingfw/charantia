
import Table from './Table/index.vue'
import QueryForm from './QueryForm/index'
import Drawer from './Drawer/index.vue'
import Dialog from './Dialog/index'
import HSort from "./Sort/index";
import Switch from "./Switch/index";
import TableEdit from "./TableEdit/index";

export default (app: any) => {
    app.component('HTable', Table);
    app.component('HQueryForm', QueryForm);
    app.component('HDrawer', Drawer);
    app.component('HDialog', Dialog);
    app.component('HSort', HSort);
    app.component('HSwitch', Switch);
    app.component('HTableEdit', TableEdit);
}
