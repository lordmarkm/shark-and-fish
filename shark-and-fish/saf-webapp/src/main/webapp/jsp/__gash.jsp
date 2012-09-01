<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js" type="text/javascript"></script>
<script src="<c:url value='/resources/kineticj/kinetic-v3.10.4.js' />"></script>
<script src="<c:url value='/resources/js/server-interface.js' />"></script>

<link rel="stylesheet" href="<c:url value='/resources/css/gamepage.css' />" />

<script>
window.vars = {
	playerId = '${playerId}',
	tankId = '${tank.id}',
	actor = '${player.actor}',
	gameplayUrl = '<c:url value="/gameplay/" />'
}

window.onload = function() {
	var stage = new Kinetic.Stage({
    	container: "container",
        width: 960,
        height: 480
	});
 
	var gashImageObj = new Image();
	var gashSprite = new Kinetic.Sprite({
		x: 350,
		y: 40,
		image: gashImageObj,
		animation: 'swimleft',
		animations: gash.animations,
		frameRate: 15,
		listening: true
	});
	var gashLayer = new Kinetic.Layer();
					
	gashImageObj.onload = function() {
		gashLayer.add(gashSprite);
		stage.add(gashLayer);
		gashSprite.start();
	}
	gashImageObj.src = "<c:url value='/resources/images/gash.png' />";
		
	var xspeed = 1.5;
	var yspeed = 1;
	stage.onFrame(function(){
		if(server) {
			gash.targetx = server.gash.targetx;
			gash.targety = server.gash.targety;
		}
		
		if(gash.targetx) {
			if(gashSprite.getX() > gash.targetx) {
				gashSprite.setX(gash.getX() - xspeed);
				if(gashSprite.getAnimation()==='swimright') {
					gashSprite.setAnimation('turnRtoL');
					gashSprite.afterFrame(9, function(){
						gashSprite.setAnimation('swimleft');
					});
				}
			} else if(gashSprite.getX() < gash.targetx) {
				gashSprite.setX(gashSprite.getX() + xspeed);
				if(gashSprite.getAnimation()==='swimleft') {
					gashSprite.setAnimation('turnLtoR');
					gashSprite.afterFrame(9, function(){
						gashSprite.setAnimation('swimright');
					});
				}
			}
		}
			
		if(gash.targety) {
			if(gash.getY() < gash.targety) {
				gash.setY(gash.getY() + yspeed);
			} else if(gash.getY() > gash.targety) {
				gash.setY(gash.getY() - yspeed);
			}
		}
					
		gashLayer.draw();
	});
	
	stage.start();
}

$(function(){
	$.ajaxSetup({
    	cache: false
    });
	
	server.playerId = vars.playerId;
	server.gameplayUrl = vars.gameplayUrl;
    server.poll();
    
    var $container = $('#container');
	$container.click(function(event){
		var offset = $(this).offset();
		var tankEvent = {
				'facebookId': vars.playerId, 
				'tankId': vars.tankId, 
				'eventType': constants.eventType_move, 
				'actor' : vars.actor, 
				'targetX' : (event.pageX - offset.left), 
				'targetY' : (event.pageY - offset.top)
			};
		console.debug('Posting ' + JSON.stringify(tankEvent));
		server.post(tankEvent);
	});
});     
</script>

<div id="container"></div>
