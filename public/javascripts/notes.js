$(document).ready(function(){
	$("a.add_note").live('click', function(){
		$(this).parent().parent().find("div.notes div.new_note").toggle();
		return false;
	});
	
	$("a.note").live('click', function(e){
		if(e.altKey)
		{
			if(confirm('Určite chceš zmazať túto známku?'))
			{
				var url = $(this).attr('href').replace('/edit', '');
				$.ajax({url: url, type: 'delete', data: {_method: 'delete'}, dataType: 'script'});
			}
			
			return false;
		}
	});
});