// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
	if($("input.date").length>0) { $("input.date").datepicker({duration: 0, firstDay: 1}); }
	$("input.erasable").focus(function(){$(this).val('')});
	$("a.ajaxified").live('click', a_ajaxified);
	$("form.ajaxified").live('submit', form_ajaxified);
});

var evalBindings = function(bindings)
{
	for(i=0; i<bindings.length; i++)
	{
		eval("$(\".bound_"+bindings[i]+"\").click("+bindings[i].replace('_', '.')+"); ");
	}
}

var a_ajaxified = function(){
	options = {};
	options.type = "get";
	if($(this).hasClass("post"))
	{
		options.type = "post";
	}
	options.dataType = "script";
	options.url = $(this).attr("href");
	options.success = function(){
		$("input.date").datepicker({duration: 0, firstDay: 1});
	}
	$.ajax(options);
	
	return false;
}

var form_ajaxified = function(){
	options = {};
	options.data = $(this).serialize();
	options.type = $(this).attr("method") || "post";
	options.url  = $(this).attr("action");
	options.dataType = "script";
	options.success = function(){
		$("input.date").datepicker({duration: 0, firstDay: 1});
	}
	
	$.ajax(options);
		
	return false;
}