// import Vue from 'vue'
import SvgIcon from '@/components/SvgIcon'// svg component

// register globally 
const req = require.context('./svg', false, /\.svg$/)
const requireAll = requireContext => requireContext.keys().map(requireContext)
requireAll(req)



export default (app: any) => {
    app.component('svg-icon', SvgIcon);
}