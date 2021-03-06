import Vue from 'vue';

import DialogAlert from '@/components/DialogModel/dialog-alert.vue';
import GenerateForm from '@/components/Generate/GenerateForm';
import GenerateTable from '@/components/Generate/GenerateTable.js';

import GenerateLabel from '@/components/Generate/GenerateLabel.vue';
import GenerateHandle from '@/components/Generate/GenerateHandle.vue';
import GenerateGroup from '@/components/Generate/GenerateGroup.vue';
/* 分页组件 */
import Pagination from '@/components/Pagination';
/* 弹出层 */
import DialogModel from '@/components/DialogModel';

/* 切换开关组件 */
import CSwitch from '@/components/Cust/CSwitch';
/* 数字输入框 */
import CNumber from '@/components/Cust/CNumber';
/* 文件管理 */
import CFile from '@/components/Cust/CFile';
/* 图片裁剪 */
import CImageCropper from '@/components/Cust/CImageCropper';
/* icon 选择事件 */
import CIconSelect from '@/components/Cust/CIconSelect';

Vue.component('dialog-alert', DialogAlert);
Vue.component('generate-form', GenerateForm);
Vue.component('generate-table', GenerateTable);
Vue.component('generate-label', GenerateLabel);
Vue.component('generate-handle', GenerateHandle);
Vue.component('generate-group', GenerateGroup);
Vue.component('pagination', Pagination);
Vue.component('dialog-model', DialogModel);


Vue.component('c-switch', CSwitch);
Vue.component('c-number', CNumber);
Vue.component('c-file', CFile);
Vue.component('c-image-cropper', CImageCropper);
Vue.component('c-icon-select', CIconSelect);