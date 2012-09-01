<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js" type="text/javascript"></script>
<script src="<c:url value='/resources/kineticj/kinetic-v3.10.4.js' />"></script>
<script src="<c:url value='/resources/js/utils.js' />"></script>
<script src="<c:url value='/resources/js/physics.js' />"></script>
<script src="<c:url value='/resources/js/server-interface.js' />"></script>
<script src="<c:url value='/resources/js/gash.js' />"></script>

<link rel="stylesheet" href="<c:url value='/resources/css/gamepage.css' />" />

<script>
window.vars = {
	playerId : '${playerId}',
	tankId : '${tank.id}',
	actor : '${player.actor}',
	gameplayUrl : '<c:url value="/gameplay/" />'
}

window.onload = function() {
	var dt = 0.0;										//time between updates (delta Time)		
	var prevTime = new Date().getTime();				//time of last update

	var calculateDT = function() {
		var nowTime = new Date().getTime();
		dt = (nowTime - prevTime) * 0.001;
		prevTime = nowTime;
	};
	
	var stage = new Kinetic.Stage({
    	container: "container",
        width: 960,
        height: 480
	});
 
	var gashImageObj = new Image();
	gash.sprite = new Kinetic.Sprite({
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
		gashLayer.add(gash.sprite);
		stage.add(gashLayer);
		gash.sprite.start();
	}
	gashImageObj.src = "<c:url value='/resources/images/gash.png' />";
		
	//	*	*	*	*	*	*	*	*	GAME LOOP	*	*	*	*	*	*	*	*	//
	// GAME LOOP
		// INPUT > UPDATE > OUTPUT			
	stage.onFrame(function(){			
		gameInput();
		gameUpdate();
		gameOutput();
	});
	var gameInput = function() {		// (1) INPUT	(user input, or AI)
		gash.gAI();		
	}
	var gameUpdate = function() {		// (2) UPDATE	(update abstract object state, apply physics, etc)
		calculateDT();
		gash.update();
	}
	var gameOutput = function() {		// (3) OUTPUT	(determine and draw graphics based on object states)
		gash.gAnimate();				// updating of sprite state			
		gashLayer.draw();		
	}
	
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
				'playerId': vars.playerId, 
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
