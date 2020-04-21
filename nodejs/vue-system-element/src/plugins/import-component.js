import Vue from 'vue';

import DialogAlert from '@/components/DialogModel/dialog-alert.vue';
import GenerateForm from '@/components/Generate/GenerateForm';
import GenerateTable from '@/components/Generate/GenerateTable.js';
/* 分页组件 */
import Pagination from '@/components/Pagination';
/* 弹出层 */
import DialogModel from '@/components/DialogModel';
/* 切换开关组件 */
import ZUpdateSwitch from '@/components/ZUpdateSwitch';
Vue.component('dialog-alert', DialogAlert);
Vue.component('generate-form', GenerateForm);
Vue.component('generate-table', GenerateTable);
Vue.component('pagination', Pagination);
Vue.component('dialog-model', DialogModel);
Vue.component('z-update-switch', ZUpdateSwitch);
