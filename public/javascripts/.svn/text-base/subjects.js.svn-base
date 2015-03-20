$(document).ready(function(){
	$("a.bound_settings_addSubject").click(function(){
		$(".subject_new").fadeIn();
		return false;
	});
	$("a.bound_settings_delete").click(function(){
		$.getScript($(this).attr('href'));
		return false;
	});
	$("form#new_subject").submit(function(){
		data = $(this).serialize();
		$.post($(this).attr('href'), data, function(){}, "script");
		return false;
	});
	
	$("ul.subjects div.subject").draggable({helper: 'clone'});
	$("td.subject_slot").droppable({
		accept: "div.subject",
		drop: function(ev, ui){
			drag = ui.draggable;
			slot = ui.element;
			
			if(drag.parents('ul.subjects').length>0)
			{
				// it's coming from source
				copy = drag.clone();
			}
			else
			{
				copy = drag;
			}
			drag.css({top: 0, left: 0});
			
			slot.empty();
			slot.append(copy);
			
			copy.draggable("destroy");
			setup_drag_from_table(copy);
			
			serialize();
		}
	});
		
	setup_drag_from_table($("td.subject_slot .subject"));
});

setup_drag_from_table = function(el)
{
	el.draggable({
		stop: function(ev, el){

		},
		revert : true
	});
}


var serialized_data = "";
var serialization_timetout = null;
serialize = function()
{
	serialized_data = "";
	var classes = "";
	$("td.subject_slot").each(function(){
		// extract the class from class' attr
		classes = $("div.subject", this).attr("class");
		if(classes) {
			classes = classes.split(' ');
			klass = classes[2];
		}
		else
		{
			klass = "";
		}
		serialized_data += "timetable[" + $(this).attr("id") + "]=" + klass + "&";
	});
	
	clearTimeout(serialization_timetout);
	serialization_timetout = setTimeout(serialize_post, 500);
}

serialize_post = function()
{
	$.post("/subjects/updateTimetable", serialized_data, function(){}, "script");
};


// *******************************
// *******************************

/// ### SETTINGS

// *******************************
// *******************************

$(document).ready(function(){
	$(".color_chooser").hover(function(){
		$(this).addClass("hover");
	}, function(){
		$(this).removeClass("hover");
	});
	$(".color_palette .single_color").click(function(){
		$(this).parent().siblings(".selected_color").empty().append($(this).clone());
		$(this).parent().parent().trigger("mouseout");
		color_name = $(this).attr("href").replace("#", "");
		$(this).parent().parent().siblings("input[type=hidden]").val(color_name);
	});
});