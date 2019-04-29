
/**设置请求超时时间(单位：毫秒)*/
axios.defaults.timeout = 30000;

/**respone拦截器*/
axios.interceptors.response.use(function (response) {
		var code = response.status;
		response.message = AxiosUtil.codeJson[code + ''] || AxiosUtil.otherErrorMsg;
		return response;
	}, function (error) {
//	var code = error.response.status;
//	if(code == 401){
//	  setTimeout(function(){
//	      window.parent.location.href = '/web-catt-admin/app/login/login.html'
//	  }, 1000)
//	}
//	return Promise.reject(error);
});


/**respone拦截器*/
axios.interceptors.request.use(function (req) {
		//let baseUrl = 'https://easy-mock.com/mock/5c9451cdabce885b880ec785/it';
		
	//	req.url = baseUrl + req.url;
	return req;
//		var code = response.status;
//		response.message = AxiosUtil.codeJson[code + ''] || AxiosUtil.otherErrorMsg;
//		return response;
	}, function (error) {
	var code = error.response.status;
	if(code == 401){
	  setTimeout(function(){
	      window.parent.location.href = '/web-it-index/app/login/login.html'
	  }, 1000)
	}
	return Promise.reject(error);
});

/***
 * Axios相关工具类
 */
var AxiosUtil = {
	//code与对应返回消息设置
	codeJson : {
		'200': '请求成功',
		'400': '错误请求',
		'401': '未授权，请重新登录',
		'403': '拒绝访问',
		'404': '请求错误,未找到该资源',
		'405': '请求方法未允许',
		'408': '请求超时',
		'500': '服务器端出错',
		'501': '网络未实现',
		'502': '网络错误',
		'503': '服务不可用',
		'504': '网络超时',
		'505': 'http版本不支持该请求',
	},
	
	/**默认参数**/
	ajaxDefaultValue: {
		showLoading : true,
		//默认值不能改成post
		method: 'get',	
		url: '',	
		data: {},	
		success: function (data) {},	
	},
	
	//其他异常消息设置
	otherErrorMsg: '内部程序异常',
	
	/**
	 * axios封装:
	 * 	method : 请求方式,默认get
	 * 	url: 请求接口地址
	 * 	data:返回参数
	 * showLoading:是否显示等待条
	 * success: 请求成功后回调函数
	 * error:错误处理
	 */
	ajax : function(options){
		let mergeOptions = Object.assign({}, this.ajaxDefaultValue, options);
		if(mergeOptions.showLoading){
			KT.Wait.show();
		};
		return axios(mergeOptions).then(resp => {
				if(mergeOptions.showLoading){
					KT.Wait.hide();
				};
				let data = resp.data;
				let code = data.code || resp.status;
				let message = data.message || resp.message;
				if(code != 200){
					KT.alert(message);
					return;
				}
				
				mergeOptions.success && mergeOptions.success.call(this, data, resp.code, resp.message);
				
			}).catch(error => {
				if(mergeOptions.showLoading){
					KT.Wait.hide();
				};
				
				if(mergeOptions.error) {
					mergeOptions.error.call(this, error);
				}else if(error.stack && error.message){
					KT.alert(error.message);
					throw new Error(error.stack);
					
				}else if( error.response && error.response.status){
					//状态码
					let status = error.response.status 
					let errorMsg  = error.response.error || this.codeJson[status + '']  || this.otherErrorMsg;
					KT.alert(errorMsg);
					throw new Error(error);
				}
			})
	},
	
	/**
	 * 获取权限,默认获取所有
	 * config:
	 * 	data:{ RightType:权限类型,1：菜单 2：按钮 默认全部; ParentId:父节点ID，不传时返回所有权限}
	 * 	success:请求成功回调函数
	 * @param config
	 * @returns
	 */
	getRight: function(config){
		config.url = config.url || '/service-zhwg-index/index/menu';
		config.method = config.method || 'post'
		config.showLoading = config.showLoading || false;
		this.ajax(config);
	}
	
};

/**
 * Vue自定义指定-权限控制
 * permissionList: 从服务接口取权限数据, [rightNo1,rightNo2...]
 * html有v-has-permission="'{rightNo1}'" 才会执行获取权限请求
 */
Vue.directive('has-permission', {
    bind(el, binding, vnode){
    	//获取按钮权限,并转换成permissionList
    	var config = {
    			data:{"RightType": "2"},
    			success: (data) => {
    				var permissionList = [];
    				steamroller(data.data, permissionList);
    		    	if(!permissionList.includes(binding.value)) {
    		    		vnode.context.$nextTick(() => {
    		    			el.parentNode.removeChild(el);
    		    		})
    		    	}
    			}
    	}
    	
    	AxiosUtil.getRight(config);

		/**
		 * 闭包处理权限数据,将rightNo取出来单独存入数组中
		 */
		function steamroller(arr, rightNoArr){
		  return arr.forEach((item)=>{
			  item.sRightNo && rightNoArr.push(item.sRightNo);
			  Array.isArray(item.children) && steamroller(item.children, rightNoArr);
		  })
		}
    }
})