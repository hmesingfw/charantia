//页面初始化，给按钮绑定事件
window.onload = function(){
   var btns = $("#btns button");
   $(btns[0]).bind("click",init);
   $(btns[1]).bind("click",setValue);
   $(btns[2]).bind("click",getValue);
   $(btns[3]).bind("click",reSetItems);
   $(btns[4]).bind("click",reSize);
}

//初始化
function init(){
   alert("test init");
}

//取值
function getValue(){
}

//赋值
function setValue(){
}

//重置下拉选项
function reSetItems(){
}

//重置宽度
function reSize(){
}

//== 请在以下部分封装自定义的下拉选组件, 注意对象化封装 ===========================================