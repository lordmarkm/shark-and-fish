<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js" type="text/javascript"></script>
<script src="<c:url value='/resources/kineticj/kinetic-v3.10.4.js' />"></script>

<link rel="stylesheet" href="<c:url value='/resources/css/gamepage.css' />" />

<script>
      window.onload = function() {
        var stage = new Kinetic.Stage({
          container: "container",
          width: 960,
          height: 480
        });
 
		var _swimleft = [];
		for(var i = 0; i < 10; i++) {
			_swimleft.push({x:(i*80), y:0, width:80, height:80});
		}
		var _swimright = [];
		for(var i = 0; i < 10; i++) {
			_swimright.push({x:(i*80), y:80, width:80, height:80});
		}
		var _turnLtoR = [];
		for(var i = 0; i < 10; i++) {
			_turnLtoR.push({x:(i*80), y:160, width:80, height:80});
		}
		var _turnRtoL = [];
		for(var i = 0; i < 10; i++) {
			_turnRtoL.push({x:(720-(i*80)), y:160, width:80, height:80});
		}
		
		var gashAnimations = {
			swimleft: _swimleft,
			swimright: _swimright,
			turnLtoR: _turnLtoR,
			turnRtoL: _turnRtoL
		}
		
		var gashImageObj = new Image();
		var gash = new Kinetic.Sprite({
			x: 350,
			y: 40,
			image: gashImageObj,
			animation: 'swimleft',
			animations: gashAnimations,
			frameRate: 15,
			listening: true
		});
		var gashLayer = new Kinetic.Layer();
					
		gashImageObj.onload = function() {
			gashLayer.add(gash);
			stage.add(gashLayer);
			gash.start();
		}
		gashImageObj.src = "<c:url value='/resources/images/gash.bmp' />";
		
		var xspeed = 1.5;
		var yspeed = 1;
		stage.onFrame(function(){
			if(gash.targetx) {
				if(gash.getX() > gash.targetx) {
					gash.setX(gash.getX() - xspeed);
					if(gash.getAnimation()==='swimright') {
						gash.setAnimation('turnRtoL');
						gash.afterFrame(9, function(){
							gash.setAnimation('swimleft');
						});
					}
				} else if(gash.getX() < gash.targetx) {
					gash.setX(gash.getX() + xspeed);
					if(gash.getAnimation()==='swimleft') {
						gash.setAnimation('turnLtoR');
						gash.afterFrame(9, function(){
							gash.setAnimation('swimright');
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
		
		var $container = $('#container');
		$container.click(function(event){
			var offset = $(this).offset();
			gash.targetx = event.pageX - offset.left;
			gash.targety = event.pageY - offset.top;
		});
	}
</script>

<div id="container"></div>
