import Vue from 'vue';

import DialogAlert from '@/components/DialogModel/dialog-alert.vue';
import GenerateForm from '@/components/Generate/GenerateForm';

/* 分页组件 */
import Pagination from '@/components/Pagination';
Vue.component('dialog-alert', DialogAlert);
Vue.component('generate-form', GenerateForm);
Vue.component('pagination', Pagination);