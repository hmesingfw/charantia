const getters = {
    language: state => state.app.language, // 语言切换

    sidebar: state => state.app.sidebar,
    size: state => state.app.size,
    device: state => state.app.device,

    visitedViews: state => state.tagsView.visitedViews,
    cachedViews: state => state.tagsView.cachedViews,

    name: state => state.user.name,
    roles: state => state.user.roles,

}

export default getters;
