import Vue from 'vue'
Vue.directive('size', {
    bind: function (el, binding, vnode) {
        console.log(el, binding, vnode);
        // el.innerHTML = 'size:"mini"'
    },
    inserted: function (el, binding, vnode) {
        console.log(el, binding, vnode);

    }
})