import Vue from 'vue';
import VueI18n from 'vue-i18n';
import elementEnLocale from 'element-ui/lib/locale/lang/en'; // element-ui lang
import elementZhLocale from 'element-ui/lib/locale/lang/zh-CN'; // element-ui lang
import enLocale from './en/en';
import zhLocale from './zh/zh';
import enBasic from './en/basic';
import zhBasic from './zh/basic';

Vue.use(VueI18n);

const messages = {
    en: {
        ...elementEnLocale,
        ...enLocale,
        ...enBasic,
    },
    zh: {
        ...elementZhLocale,
        ...zhLocale,
        ...zhBasic,
    },
};

const i18n = new VueI18n({
    // set locale
    // options: en | zh | es
    locale: localStorage.getItem('language') || 'zh',
    // set locale messages
    messages,
    // Cannot translate the value of keypath
    // silentTranslationWarn: true
});

export default i18n;
