// modal-box
// (c) 2009 Vojto Rinik <vojto(at)rinik.net>

$(document).ready(function(){
	$("a.modalbox").click(function(){
		$.modal({remote: $(this).attr("href")});
		return false;
	});
});

jQuery.modal = function(params)
{
	if(params.element)
	{
		construct_modal($(params.element).clone().contents());
	}
	if(params.html)
	{
		construct_modal(params.html);
	}
	if(params.remote)
	{
		$.get(params.remote, {layout: "false"}, function(response){
			construct_modal(response, function(){
				if($("input.date").length>0) { $("input.date").datepicker({duration: 0, firstDay: 1}); }
			});
		});
	}
};

var construct_modal = function(data, callback){
	if($("div.modal").length > 0)
	{
		// it already exists, we only replace the body
		$("div.modal .wrapper").hide().empty().append(data);
		if($.browser.msie)
		{
			$("div.modal .wrapper").show();
		}
		else
		{
			$("div.modal .wrapper").css({opacity:0}).show().animate({opacity:1});
		}
		return true;
	}
	
	var modal   = $("<div />").addClass("modal").hide();
	if(!$.browser.msie)
	{
		modal.css({display: "block", opacity: 0});
	}
	var body    = $("<div />").addClass("body").appendTo(modal);
	var foot    = $("<div />").addClass("foot").appendTo(modal);
	var wrapper = $("<div />").addClass("wrapper").appendTo(body);
	var close   = $("<a />").attr("href", "#modal/close").addClass("close").bind("click", destroy_modal).appendTo(modal);
	
	wrapper.append(data);
		
	$("body").append(modal);
	
	if($.browser.msie)
	{
		modal.show();
		callback();
	}
	else
	{
		modal.animate({opacity: 1}, 300, callback);
	}
};

var destroy_modal = function(){
	if($.browser.msie)
	{
		$("div.modal").remove();
	}
	else
	{
		$("div.modal").animate({opacity: 0}, 500, function(){
			$(this).remove();
		});
	}
	return false;
};
