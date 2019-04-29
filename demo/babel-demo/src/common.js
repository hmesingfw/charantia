/**
 * 公共js,依赖Vue、axios
 */
var baseURL = "./";
var access_token = localStorage.getItem('access_token');
var refresh_token = localStorage.getItem('refresh_token');
var openRestUrl = "openRest/oauth2/";

/*
if (access_token == 'null' || access_token == null) {
    if (parent.location.href.indexOf("login.html") == -1) {
        parent.location.href = baseURL + 'login.html';
    }
}
*/

//请求Base路径
axios.defaults.baseURL = 'http://localhost:9000/';
//请求超时时间
axios.defaults.timeout = 30000;
//request拦截器
axios.interceptors.request.use(
	config => {
		// 判断是否存在token，存在则放到请求头里面，过滤掉openRest接口
	    if(access_token && config.url.indexOf(openRestUrl) === -1) {
	        config.headers.Authorization = "Bearer " + access_token;
	    }
	    return config;
	}, 
	error => {
		// 对请求错误做些什么
		return Promise.reject(error);
	}
);
//respone拦截器
axios.interceptors.response.use(
	response => {
		let code = response.data.code;//状态码
		switch (code) {
			case 200: 
				console.log('请求成功')
				break;
	        case 400:
	        	console.log('错误请求')
	            break;
	        case 401:
	        	response.data.message = '未授权，请重新登录';
	        	break;
	        case 8:
	        	response.data.message = '帐号/密码不正确';
	            break;
	        case 403:
	        	console.log('拒绝访问')
	            break;
	        case 404:
	        	console.log('请求错误,未找到该资源')
	            break;
	        case 405:
	        	console.log('请求方法未允许')
	            break;
	        case 408:
	        	console.log('请求超时')
	            break;
	        case 500:
	        	console.log('服务器端出错')
	            break;
	        case 501:
	        	console.log('网络未实现')
	            break;
	        case 502:
	        	console.log('网络错误')
	            break;
	        case 503:
	        	console.log('服务不可用')
	            break;
	        case 504:
	        	console.log('网络超时')
	            break;
	        case 505:
	        	console.log('http版本不支持该请求')
	            break;
	        default:
	            break;
	    }
		return response;
	},
	error => {
		let code = error.response.data.code;
		/*
		switch (code) {
			case 401:
				if (top.location.href.indexOf("login.html") == -1) {
			        top.location.href = baseURL + 'login.html';
			    }
				break;
			default: 
				break;
		}
		*/
		return Promise.reject(error);
	}
);

/**
 * axios工具封装
 */
const AxiosUtil = function(options) {
	//默认配置
	options = Object.assign({
		method: 'get',	//创建请求时使用的方法,默认是get
		url: '',	//请求的服务器 URL
		data: {},	//请求参数
		success: function (data) {},	//成功回调
		error: function (error) {}	//错误回调
	}, options);
	
	return axios(options)
		.then(resp => {
			if(options.success) {
				options.success.call(this, resp);
			}
		})
		.catch(error => {
			if(options.error) {
				options.error.call(this, error);
			}
		})
}

//注册到Vue上
Vue.prototype.$axios = AxiosUtil;

/**
 * Vue自定义指定-权限控制
 * permissionData: 从服务接口取权限数据, {permission: []}
 */
Vue.directive('has-permission', {
    bind(el, binding, vnode){
    	let permissionList = permissionData.permission;
    	if(permissionList && permissionList.length && !permissionList.includes(binding.value)) {
    		vnode.context.$nextTick(() => {
    			el.parentNode.removeChild(el);
    		})
    	}
    }
})