<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js" type="text/javascript"></script>
<script src="<c:url value='/resources/kineticj/kinetic-v3.10.4.js' />"></script>
<script src="<c:url value='/resources/js/utils.js' />"></script>
<script src="<c:url value='/resources/js/physics.js' />"></script>
<script src="<c:url value='/resources/js/server-interface.js' />"></script>
<script src="<c:url value='/resources/js/swimmer.js' />"></script>
<script src="<c:url value='/resources/js/background.js' />"></script>

<link rel="stylesheet" href="<c:url value='/resources/css/gamepage.css' />" />

<script>
window.vars = {
	playerId : '${playerId}',
	tankId : '${tank.id}',
	actor : '${player.actor}',
	gameplayUrl : '<c:url value="/gameplay/" />'
}

$(function(){
	var swimmers = {};
	
	var stage = new Kinetic.Stage({
    	container: "container",
        width: 960,
        height: 480
	});
 
	//add layers bottom first, top last
	var backgroundLayer = new Kinetic.Layer();
	stage.add(backgroundLayer);
	
	var swimmersLayer = new Kinetic.Layer();
	stage.add(swimmersLayer);
	
	//Initialize the background
	var background = new SFBackground({
		scrollspeed			:	200,
		noscroll_edge_left 	: 	960 * 0.25,
		noscroll_edge_right : 	960 * 0.75,
		min_scroll			:	-2760 + 960,
		max_scroll			:	0,
		src					:	"<c:url value='/resources/images/tankbg.jpg' />"
	});
	
	//Initialize Gash
	gash = new Swimmer({
		actor_id 	: constants.actor_gash,
		background	: background
	});
	swimmers[constants.actor_gash] = gash;
	gash.serverObject = server.gash;
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
	
	gash.absolute_x = gash.sprite.attrs.x;
	gash.absolute_y = gash.sprite.attrs.y;
	
	gashImageObj.onload = function() {
		swimmersLayer.add(gash.sprite);
		gash.sprite.start();
	}
	gashImageObj.src = "<c:url value='/resources/images/gash.png' />";
	
	
	//----IMPORTANT: Once all actors have been initialized, 
	//	  indicate the actor that the background will track
	background.setMaster(swimmers[vars.actor]);
	
	//	*	*	*	*	*	*	*	*	GAME LOOP	*	*	*	*	*	*	*	*	//
	// GAME LOOP
		// INPUT > UPDATE > OUTPUT			
	stage.onFrame(function(){			
		gameInput();
		gameUpdate();
		gameOutput();
	});
	
	var gameInput = function() {		// (1) INPUT	(user input, or AI)
		$.each(swimmers, function(key, swimmer) {
			swimmer.getInput();
		});
	}
	var updates = 0;
	var gameUpdate = function() {		// (2) UPDATE	(update abstract object state, apply physics, etc)
		calculateDT();
		background.update();
		
		$.each(swimmers, function(swimmerId, swimmer) {
			swimmer.updatePosition();
			swimmer.sprite.attrs.x = swimmer.body.position.x - 40 + background.offset_x; //update swimmer sprite position according to bg offset
			swimmer.sprite.attrs.y = swimmer.body.position.y - 40;
			if(updates++ %100 ===0) debug('v.x: ' + swimmer.body.v.x);
		});	
	}
	var gameOutput = function() {		// (3) OUTPUT	(determine and draw graphics based on object states)
		$.each(swimmers, function(swimmerId, swimmer) {
			swimmer.updateAnimation();			// updating of sprite state
		});
		swimmersLayer.draw();
		backgroundLayer.getContext().drawImage(background.image, background.offset_x, background.offset_y);
	}
	
	stage.start();
	
	
	//----- SERVER SETUP -----//
	$.ajaxSetup({
    	cache: false
    });
	
	server.playerId = vars.playerId;
	server.gameplayUrl = vars.gameplayUrl;
    server.poll();
    
    
    //------ HANDLE PLAYER INITIATED EVENTS -------//
    var $container = $('#container');
	$container.click(function(event){
		var offset = $(this).offset();
		var tankEvent = {
				'playerId': vars.playerId, 
				'tankId': vars.tankId, 
				'eventType': constants.eventType_move, 
				'actor' : vars.actor, 
				'targetX' : (event.pageX - offset.left - background.offset_x), //absolute x, taking into account background
				'targetY' : (event.pageY - offset.top)
			};
		debug('Posting ' + JSON.stringify(tankEvent));
		server.post(tankEvent);
	});
});     
</script>

<style>
#container {
	background-image: 
}
</style>

<div id="container"></div>
