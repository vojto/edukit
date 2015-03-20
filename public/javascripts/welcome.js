$(document).ready(function(){
	$(".bound_login").live('click', login);
	$(".bound_registration").live('click', registration);
});

var login = function(){
	$.modal({element: "#login_box"})
	return false;
}

var registration = function(){
	$.modal({element: "#registration_box"})
	return false;
}