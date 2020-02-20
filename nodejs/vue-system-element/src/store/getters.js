const getters = {
    language: state => state.app.language, // 语言切换

    sidebar: state => state.app.sidebar,
    size: state => state.app.size,
    device: state => state.app.device,

    visitedViews: state => state.tagsView.visitedViews,
    cachedViews: state => state.tagsView.cachedViews,

    name: state => state.user.name,
    roles: state => state.user.roles,
    permission_routes: state => state.permission.routes,


    enumList: state => state.enumList.enumList,      ///* 枚举列表 */
}

export default getters;