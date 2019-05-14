//页面初始化，给按钮绑定事件
window.onload = function(){
   var btns = $("#btns button");
   $(btns[0]).bind("click",init);
   $(btns[1]).bind("click",getValue);
   $(btns[2]).bind("click",setValue);
   $(btns[3]).bind("click",reSetItems);
   $(btns[4]).bind("click",reSize);
}

//初始化
function init(){
	window.stuDWidth = 120;
	$('#myClass').checkBox({data:$.extend(true, [], classData),isMulti:0, width:120,onchange:function(data){
		var cls = data.data.id;
		var stdData = [];
		for(i=0;i<studentData.length;i++){
			if(studentData[i].classId == cls){
				stdData.push(studentData[i]);
			}
		}
		$('#myStudent').checkBox({data:$.extend(true, [], stdData),isMulti:1,width:stuDWidth,warn:'请先选择班级！'});
	}});

	$('#myStudent').checkBox({data:[],isMulti:1, width:120,warn:'请先选择班级！'});
	$('#myClass').checkBox("setValue",2);
}

//取值
function getValue(){
	var data1 = $('#myClass').checkBox('getValue');
	var data2 = $('#myStudent').checkBox('getValue');
	var result1 = '未选择班级！\r\n';
	var result2 = '未选择学生！\r\n';
	if(data1.id != ''){
		result1 = "班级：" + data1.name+'            id：'+data1.id+"\r\n";
	}
	if(data2 && data2.length > 0){
		var stds = data2;
		result2 = "";
		for(var i=0;i<stds.length;i++){
			result2 += "学生：" + stds[i].name+'            id：'+stds[i].id+"\r\n";
		}
	}
	alert(result1+result2);

}

//赋值
function setValue(){
	$('#myClass').checkBox("setValue",3);
}

//重置下拉选项
function reSetItems(){
	var stdData = [];
	for(i=0;i<studentData.length;i++){
		if(studentData[i].classId == 1){
			stdData.push(studentData[i]);
		}
	}
	$('#myStudent').checkBox('reSet',$.extend(true, [], stdData));
}

//重置宽度
function reSize(){
	$("#myStudent").checkBox("setWidth",200);
	window.stuDWidth = 200;
}

//== 请在以下部分封装自定义的下拉选组件, 注意对象化封装 ===========================================


(function($){

	//jquery插件
	$.fn.checkBox= function(method, options) {
		if(typeof(method)=='object'){
			create(this, method);
		}else if(method=='getValue'){
			return getCheckValue(this);
		}else if(method=='setWidth'){
			return setWidth(this,options);
		}else if(method=='setValue'){
			return setCheckValue(this,options);
		}else if(method=='reSet'){
			return reSet(this,options);
		}
	};
	/**
	 *	初始化参数：
	 *  data: 下拉数据对象数组,默认[]
	 *  nameText: 文本对应属性名,默认name
	 *  valText: 值对应属性名,默认id
	 *  isMulti: 是否多选，默认单选
	 *  width: 下拉框宽度，默认120
	 *  warn: 下拉框初始无数时，点击下拉的提示信息
	 *  onchange: 选择触发的事件 回调参数 {data 数据数组、 obj 下拉框对象}
	 */
	function create(obj, opts){
		//配置参数初始化
		var text = opts.nameText?opts.nameText:'name';
		var value = opts.valText?opts.valText:'id';
		var isMulti = opts.isMulti?opts.isMulti:false;
		var width = opts.width?opts.width:120;
		opts.nameText=text;
		opts.valText = value;
		//添加首选项
		var topData = {};
		topData[value] = '';
		topData[text] = isMulti?'全选':'请选择';
		//下拉框html
		//数据校验
		if(!opts.data|| opts.data.length == 0){
			opts.data = [];
		}else{
			opts.data.unshift(topData);
		}
		var html = '<div class="multipleChoice" style="width:'+width+'px;"><input class="multipleValue" type="hidden"/><div class="multipleInput">'+(isMulti?'':topData[text])+'</div>'+(isMulti?'<div class="inputClear"></div>':'')+'<a class="multipleA"></a><div class="multipleXiala"><div class="resultDiv"><ul class="result formStyle">';
		//循环拼接选项
		for(var i=0;i<opts.data.length;i++){
			html += '<li '+((i==0&&!isMulti)?' checked="checked" ':'')+'>'+(isMulti?'<input type="checkbox" name="chbox">':'')+'<span val="'+opts.data[i][value]+'">'+opts.data[i][text]+'</span></li>';

		}
		html += '</ul></div></div>';
		$(obj).html(html);
		//绑定事件
		bindEvent(obj,opts);
		if(typeof window.checkBoxOpts == 'undefined'){
			window.checkBoxOpts = [];
		}
		var checkBoxId = obj.attr("checkBoxId")?obj.attr("checkBoxId"):checkBoxOpts.length;
		obj.attr("checkBoxId",checkBoxId);
		checkBoxOpts[checkBoxId] = opts;
	}

	//获取选中项
	function setWidth(obj,width){
		obj = $(obj);
		var opts = getOpts(obj);
		if(!opts){
			return;
		}
		opts.width = width;
		var checkBoxId = obj.attr('checkBoxId');
		checkBoxOpts[checkBoxId] = opts;
		obj.find(".multipleChoice").width(width);
	}

	function reSet(obj,data){
		obj = $(obj);
		var opts = getOpts(obj);
		if(!opts){
			return;
		}
		opts.data = data;
		create(obj,opts);
	}

	function getOpts(obj){
		obj = $(obj);
		var checkBoxId = obj.attr('checkBoxId');
		var opts = {};
		if(typeof checkBoxOpts != 'undefined'){
			opts = checkBoxOpts[checkBoxId];
		}
		if(!checkBoxId||!opts){
			return false;
		}
		return opts;
	}

	//设置宽度
	function getCheckValue(obj){
		obj = $(obj);
		var opts = getOpts(obj);
		if(!opts){
			return;
		}
		var isMulti = opts.isMulti?opts.isMulti:false;
		if(isMulti){
			return getMultiCheck(obj, opts);
		}else{
			return getSelected(obj,opts);
		}

	}


	//设置宽度
	function setCheckValue(obj,data){
		obj = $(obj);
		var opts = getOpts(obj);
		if(!opts){
			return;
		}
		var isMulti = opts.isMulti?opts.isMulti:false;
		if(isMulti){
			return setMultiCheck(obj, data, opts);
		}else{
			return setSelected(obj,data,opts);
		}

	}

	//初始化绑定事件
	function bindEvent(obj,opts){
		var isMulti = opts.isMulti?opts.isMulti:false;
		var warn = opts.warn?opts.warn:null;
		obj = $(obj);
		//点击事件
		obj.find(".multipleInput,.multipleA").click(function(){
			if(warn && (!opts.data || opts.data.length == 0)){
				alert(warn);
				return;
			}
			$(this).parent().find(".multipleXiala").slideDown('fast');
			$(this).parent().css({zIndex:11});
		});

		obj.find(".multipleChoice").mouseleave(function(){
			$(this).find(".multipleXiala").slideUp('fast');
			$(this).css('zIndex','inherit');
		});

		obj.find('.xw_multXialaBtn').click(function(){
			$(".multipleXiala").slideUp('fast');
		});
		//重加载样式
		obj.find('input:checkbox').jqTransCheckBox();
		//指针样式
		obj.find('ul.result li').css('cursor','pointer');


		//多选初始
		if(isMulti){
			//选择事件
			initCheckBox(obj, opts);
			obj.find(".inputClear").click(function(){
				clearMultiCheck(obj,opts);
			});
		}else{
			initSelect(obj, opts);
		}

	}

	//下拉选项与文本域的联动绑定
	function initCheckBox(obj,opts){
		var lis =obj.find('ul.result li');
		var inputs =$(obj).find('ul.result input:checkbox');
		//点击文字也触发按钮事件
		$(lis).click(function(){
			var thisInput =$(this).find('input:checkbox');
			if($(thisInput).attr("checked") == 'checked'){
				uncheck(thisInput);
			}else{
				check(thisInput);
			}
		});
		$(lis[0]).click(function(){
			var thisInput =$(this).find('input:checkbox');
			isAllCheck(thisInput, obj, opts);
		});
		$(inputs[0]).click(function(){
			isAllCheck(this, obj, opts);
		});
		inputs.splice(0,1);
		lis.splice(0,1);
		$(lis).click(function(){
			var thisInput =$(this).find('input:checkbox');
			checkItem(thisInput, obj, opts);
		});
		$(inputs).click(function(){
			checkItem(this, obj, opts);
		});
	}

	//单选点击事件
	function initSelect(obj, opts){
		var lis =obj.find('ul.result li');
		//点击文字设为选中状态
		$(lis).click(function(){
			$(lis).removeAttr('checked');
			$(lis).attr('style','cursor:pointer;');
			$(this).attr('style',"background:#209EC4;cursor:pointer;");
			$(this).attr('checked','checked');
			var span = $($(this).find("span"));
			obj.find('.multipleInput').html(span.html());
			obj.find('.multipleValue').val(span.attr("val"));
			var item = {};
			item[opts.nameText]=span.html();
			item[opts.valText]=span.attr("val");
			obj.find(".multipleChoice .multipleXiala").slideUp('fast');
			obj.find(".multipleChoice").css('zIndex','inherit');
			if(opts.onchange){
				opts.onchange.call(this,{data:item,obj: obj});
			}
		});
	}

	//获取单选选中项
	function getSelected(obj,opts){
		var lis =obj.find('ul.result li[checked=checked]');
		var span = $($(lis).find("span"));
		var item = {};
		item[opts.nameText]=span.html();
		item[opts.valText]=span.attr("val");
		return item;
	}

	//单选选中，传入选中的id值
	function setSelected(obj,data,opts){
		var lis =obj.find('ul.result li');
		$(lis).removeAttr('checked');
		$(lis).attr('style','cursor:pointer;');
		for(var i=0;i<lis.length;i++){
			var thisLis = lis[i];
			var span = $($(thisLis).find("span"));
			if(span.attr("val") == data){
				$(thisLis).attr('style',"background:#209EC4;cursor:pointer;");
				$(thisLis).attr('checked','checked');
				obj.find('.multipleInput').html(span.html());
				obj.find('.multipleValue').val(span.attr("val"));
				var item = {};
				item[opts.nameText]=span.html();
				item[opts.valText]=span.attr("val");
				if(opts.onchange){
					opts.onchange.call(this,{data:item,obj: obj});
				}
				return;
			}
		}
	}

	//下拉选择后，文本内容一起变化
	function setCheckText(obj,opts){
		var inputs =$(obj).find('ul.result input:checked');
		var msg = "";
		var value = '';
		var result = [];
		for(var i =0; i<inputs.length; i++){
			var input = inputs[i];
			var span = $($(input).parents("span")).next();
			var text = span.html();
			var val = span.attr('val');
			if(text == "全选"){
				continue;
			}
			var item = {};
			item[opts.nameText]=text;
			item[opts.valText]=val;
			result.push(item);
			if(msg != ""){
				msg += ",";
			}
			msg += text;
			if(value != ""){
				value += ",";
			}
			value += val;
		}
		obj.find('.multipleInput').html(msg);
		obj.find('.multipleValue').val(value);
		if(opts.onchange){
			opts.onchange.call(this,{data:result,obj: obj});
		}
	}

	//获取下拉框已勾选的值
	function getMultiCheck(obj,opts){
		var inputs =$(obj).find('ul.result input:checked');
		var msg = "";
		var value = '';
		var result = [];
		for(var i =0; i<inputs.length; i++){
			var input = inputs[i];
			var span = $($(input).parents("span")).next();
			var text = span.html();
			var val = span.attr('val');
			if(text == "全选"){
				continue;
			}
			var item = {};
			item[opts.nameText]=text;
			item[opts.valText]=val;
			result.push(item);
		}
		return result;
	}

	//多选全量赋值
	function setMultiCheck(obj, data, opts){
		var inputs =$(obj).find('ul.result input');
		uncheck(inputs);
		var msg = "";
		var value = '';
		var result = [];
		for(var i=0;i<inputs.lenght;i++){
			for(var j=0;i<data.lenght;j++){
				var input = inputs[i];
				var span = $($(input).parents("span")).next();
				var text = span.html();
				var val = span.attr('val');
				if(text == "全选"){
					continue;
				}
				if(val == data[j]){
					var item = {};
					item[opts.nameText]=text;
					item[opts.valText]=val;
					result.push(item);
					if(msg != ""){
						msg += ",";
					}
					msg += text;
					if(value != ""){
						value += ",";
					}
					value += val;
				}
			}
		}
		obj.find('.multipleInput').html(msg);
		obj.find('.multipleValue').val(value);
		if(opts.onchange){
			opts.onchange.call(this,{data:result,obj: obj});
		}
	}

	//清空下拉框选择
	function clearMultiCheck(obj,opts){
		var inputs =obj.find('ul.result input:checkbox');
		uncheck(inputs);
		setCheckText(obj,opts);
	}

	//选中
	function check(input){
		$(input).attr("checked", 'checked');
		$(input).prev().addClass("jqTransformChecked");
	}

	//不选
	function uncheck(input){
		$(input).removeAttr("checked");
		$(input).prev().removeClass("jqTransformChecked");
	}

	//全选判断
	function isAllCheck(input,obj,opts){
		var inputs =obj.find('ul.result input:checkbox');
		if($(input).attr("checked") == 'checked'){
				check(inputs);
		}else{
			uncheck(inputs);
		}
		setCheckText(obj,opts);
	}

	function checkItem(input, obj, opts){
		var inputs =obj.find('ul.result input:checkbox');
		if($(input).attr("checked") != 'checked'){
			uncheck(inputs[0]);
		}else if($(inputs[0]).attr("checked") != 'checked'){
			var isAll = true;
			for(var i=1;i<inputs.length;i++){
				if($(inputs[i]).attr("checked") != 'checked'){
					isAll = false;
					break;
				}
			}
			if(isAll){
				check(inputs[0]);
			}
		}
		setCheckText(obj,opts);
	}

})(jQuery);

