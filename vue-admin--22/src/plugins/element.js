import Vue from "vue";
import Element from "element-ui";
import "element-ui/lib/theme-chalk/index.css";

import i18n from "../lang"; // Internationalization

Vue.use(Element, {
  i18n: (key, value) => i18n.t(key, value)
});
