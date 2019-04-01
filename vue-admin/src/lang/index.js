import Vue from "vue";
import VueI18n from "vue-i18n";
import elementEnLocale from "element-ui/lib/locale/lang/en"; // element-ui lang
import elementZhLocale from "element-ui/lib/locale/lang/zh-CN"; // element-ui lang 
import enLocale from "./en/en";
import zhLocale from "./zh/zh";
import enRoute from './en/route'
import zhRoute from './zh/route'

Vue.use(VueI18n);

const messages = {
  en: {
    ...enLocale,
    ...elementEnLocale,
    ...enRoute
  },
  zh: {
    ...zhLocale,
    ...elementZhLocale,
    ...zhRoute
  },
};

const i18n = new VueI18n({
  // set locale
  // options: en | zh | es
  locale: localStorage.getItem("language") || "zh",
  // set locale messages
  messages
});

export default i18n;