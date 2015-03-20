$.fn.nice_show = function(){
	$(this).css({opacity: 0, marginTop: -20}).show();
	$(this).animate({opacity: 1, marginTop: 0}, 300);
};

$.fn.nice_hide = function(){
	$(this).animate({marginTop: 20, opacity: 0}, 300, function(){
		$(this).css({marginTop: 0}).hide();
	});
};

$(document).ready(function(){
	if($.browser.msie)
	{
		b = $(".message").css("backgroundImage").replace(".png", ".gif");
		$(".message").css("backgroundImage", b);
	}
	$(".message_zone").hover(function(){
		var id = $(this).attr('id').replace("message_zone_", "");
		$("#message_"+id).nice_show();
	}, function(){
		var id = $(this).attr('id').replace("message_zone_", "");
		$("#message_"+id).nice_hide();
	});
});