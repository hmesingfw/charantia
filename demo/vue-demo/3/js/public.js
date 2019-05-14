$(function(){

	
	//列表选中事件
	$(".attachTable tr,.departmentTable tr").click(function(){
		$(".attachTable tr,.departmentTable tr").removeClass("trSelect");
		$(this).addClass("trSelect");
	});
	$(".attachTable tr,.departmentTable tr").hover(function(){
		$(".attachTable tr,.departmentTable tr").removeClass("trhover");
		$(this).addClass("trhover");
		$(this).find('h3').toggle();
		$(this).find('.chaozuoFu').toggle();
		$(this).find('.detailTd').toggle();
	});
	
	
	
	//下拉多选	
	$(".multipleInput,.multipleA").click(function(){
		$(this).parent().find(".multipleXiala").slideDown('fast');
		$(this).parent().css({zIndex:11});
	});
	
	$(".multipleChoice").mouseleave(function(){
		$(this).find(".multipleXiala").slideUp('fast');
		$(this).css('zIndex','inherit');
	});
	
	$('.xw_multXialaBtn').click(function(){
		$(".multipleXiala").slideUp('fast');
	});
	

	
});

 
 
 
