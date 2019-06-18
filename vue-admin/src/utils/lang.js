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