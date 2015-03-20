var dashboard = {
	bindings : ["dashboard_setComplete", "dashboard_revertComplete"],
	
	// actions
	setComplete : function(){
		$.getScript($(this).attr("href"));
		return false;
	},
	
	revertComplete: function(){
		$.getScript($(this).attr("href"));
		return false;
	}
}


$(document).ready(function(){
	evalBindings(dashboard.bindings);
});