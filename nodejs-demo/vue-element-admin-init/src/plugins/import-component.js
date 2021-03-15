import Vue from 'vue';

import GenerateForm from '@/components/Generate/form';
import GenerateTable from '@/components/Generate/table.js';

import GenerateLabel from '@/components/Generate/label.vue';
import GenerateHandle from '@/components/Generate/handle.vue';
import GenerateGroup from '@/components/Generate/group.vue';
/* 分页组件 */
import Pagination from '@/components/Cust/Pagination';
/* 弹出层 */
import DialogModel from '@/components/DialogModel/index';
import DialogAlert from '@/components/DialogModel/alert';

/* 切换开关组件 */
import CSwitch from '@/components/Cust/CSwitch';
/* 数字输入框 */
import CNumber from '@/components/Cust/CNumber';
/* 文件管理 */
import CFile from '@/components/Cust/CUploadImage';
/* 图片裁剪 */
import CImageCropper from '@/components/Cust/CImageCropper';
/* icon 选择事件 */
import CIconSelect from '@/components/CIconSelect';
/* 选择标签 -- 打开标签面板 */
import STagModel from '@/components/Cust/CTag/STagModel/index';
/* 在各个模块中使用的标签 */
import CTag from '@/components/Cust/CTag';
import CTagQuery from '@/components/Cust/CTagQuery';
/* 自定义表单数据 */
import CustomPage from '@/components/Cust/CustomPage';

Vue.component('dialog-alert', DialogAlert);
Vue.component('g-form', GenerateForm);
Vue.component('g-table', GenerateTable);
Vue.component('g-label', GenerateLabel);
Vue.component('g-handle', GenerateHandle);
Vue.component('g-group', GenerateGroup);
Vue.component('pagination', Pagination);
Vue.component('dialog-model', DialogModel);

Vue.component('c-switch', CSwitch);
Vue.component('c-number', CNumber);
Vue.component('c-file', CFile);
Vue.component('c-image-cropper', CImageCropper);
Vue.component('c-icon-select', CIconSelect);
Vue.component('c-tag', CTag);
Vue.component('c-tag-query', CTagQuery);
Vue.component('custom-page', CustomPage)

Vue.component('s-tag-model', STagModel);
