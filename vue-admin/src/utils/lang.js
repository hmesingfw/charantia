import elementEnLocale from "element-ui/lib/locale/lang/en"; // element-ui lang
import elementZhLocale from "element-ui/lib/locale/lang/zh-CN"; // element-ui lang 
import enLocale from "@/lang/en/en";
import zhLocale from "@/lang/zh/zh";

import enBasic from '@/lang/en/basic';
import zhBasic from '@/lang/zh/basic';


/** 路由中英文播译 */
export function generateTitle(title) {

    const hasKey = this.$te('route.' + title)
    const translatedTitle = this.$t('route.' + title) // $t :this method from vue-i18n, inject in @/lang/index.js

    if (hasKey) {
        return translatedTitle
    }
    return title
}


/** 路由中英文播译  多个反斜扛*/
export function generateTitleSlash(title) {
    if (title.indexOf('/') != -1) {
        if (title.split('/').length > 2) {
            title = title.substring(title.lastIndexOf('/') + 1, title.length);
        }
    }
    const hasKey = this.$te('route.' + title)
    const translatedTitle = this.$t('route.' + title) // $t :this method from vue-i18n, inject in @/lang/index.js

    if (hasKey) {
        return translatedTitle
    }
    return title
}




/** 请求远程数据, 配置中英语言 */
export function initLang() {
    this.$http.get('/egg/getMenus?type=noTree').then(res => {

        let enR = {
                route: {}
            },
            zhR = {
                route: {}
            };
        res.data.forEach(item => {
            enR.route[item.path] = item.titelEn;
            zhR.route[item.path] = item.titelZh;
        })


        let en = {
            ...elementEnLocale,
            ...enLocale,
            ...enBasic,
            ...enR,
        };
        let zh = {
            ...elementZhLocale,
            ...zhLocale,
            ...zhBasic,
            ...zhR,
        };

        this.$i18n.setLocaleMessage('en', en);
        this.$i18n.setLocaleMessage('zh', zh);

    })

}