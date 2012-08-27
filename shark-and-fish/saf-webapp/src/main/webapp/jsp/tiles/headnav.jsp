<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="<c:url value='/resources/css/headnav.css'/>" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js" type="text/javascript"></script>

<div class="headnav">
	<div class="headnav-bluebar">
		<span class="headnav-left">
			<span class="headnav-title">Shark and Fish</span>
			<div class="headnav-game a ml10" href="<c:url value='/test/' /> ">&nbsp</div>
		</span>
		<img class="headnav-image" src="${facebookProfileImage }" />
		<span class="headnav-userinfo">${facebookProfile.name }</span>
		<div class="headnav-menubutton"></div>
	</div>
</div>

<div class="headnav-menu hide">
	<div class="headnav-menu-option a" href="<c:url value='/info/security' />">View Security info</div>
	<div class="headnav-menu-option a" href="<c:url value='/info/social' />">View Social info</div>
	<div class="headnav-menudivider">&nbsp</div>
	<div class="headnav-menu-option a" href="<c:url value='/j_spring_security_logout' />">Log out of Shark and Fish</div>
</div>

<script>
$(function() {
	var $headnav_menubutton = $('.headnav-menubutton'),
		$headnav_menu = $('.headnav-menu');

	$headnav_menubutton.click(function(event){
		var $button = $(this);
		var menuOpen = $button.hasClass('active');
		if(!menuOpen) {
			$headnav_menu.show();
			$button.addClass('active');
			event.stopPropagation();
		}
	});
	
	$('.a').click(function(){
		var link = $(this).attr('href');
		if(link)
			window.location.href = link;
	});
	
	$headnav_menu.click(function(event){
		event.stopPropagation();
	});
	
	$(document).click(function(){
		$headnav_menu.hide();
		$headnav_menubutton.removeClass('active');
	});
});
</script>