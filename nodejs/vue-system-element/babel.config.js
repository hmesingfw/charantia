
// const plugins = ["@vue/babel-plugin-transform-vue-jsx"]
// // 生产环境移除console
// if (process.env.NODE_ENV === 'production') {
//     plugins.push("transform-remove-console")
// }

module.exports = {
    // plugins: plugins,
    // plugins: ["@vue/babel-preset-jsx"],
    presets: [
        '@vue/app',
        // "@vue/babel-preset-jsx"y
    ]
}
