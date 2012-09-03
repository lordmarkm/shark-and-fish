/*
 * Things that swim
 */
function Swimmer(params) {
	var swimmer = this;
	var background = params.background;
	
	this.actorId = params.actorId;
	
	/*
	 * Animation
	 */
	this.animations = {
		swimleft: [],
		swimright: [],
		turnLtoR: [],
		turnRtoL: []
	}
	
	for(var i = 0; i < 10; i++) {
		this.animations.swimleft.push	({x:(i*80), y:0, width:80, height:80});
		this.animations.swimright.push	({x:(i*80), y:80, width:80, height:80});
		this.animations.turnLtoR.push	({x:(i*80), y:160, width:80, height:80});
		this.animations.turnRtoL.push	({x:(720-(i*80)), y:160, width:80, height:80});
	}
	
	this.updateAnimation = function () {
		if(this.targetx) {
			if(this.body.position.x > this.targetx) {
				if(this.sprite.getAnimation()==='swimright') {
					this.sprite.setAnimation('turnRtoL');
					this.sprite.afterFrame(9, function(){
						swimmer.sprite.setAnimation('swimleft');
					});
				}
			} else if(this.body.position.x < this.targetx) {
				if(this.sprite.getAnimation()==='swimleft') {
					this.sprite.setAnimation('turnLtoR');
					this.sprite.afterFrame(9, function(){
						swimmer.sprite.setAnimation('swimright');
					});
				}
			}
		}
	};
	
	this.body = new PhysicalBody({
		radius : 30,
		pos_x  : 350,
		pos_y  : 300,
		vmax_x : 300,
		vmax_y : 100,
		a_x    : 400,
		a_y    : 400,
		v_x	   : 0,
		v_y	   : 0,
		cage   : {
			min_x	: 40,
			max_x	: 2720,
			min_y	: 40,
			max_y	: 440
		}
	});
	
	this.getInput = function() {
		this.targetx = this.serverObject.targetx;
		this.targety = this.serverObject.targety;
		
		if(this.targetx) {
			if(this.body.position.x > this.targetx) 		 {		this.body.accelLeft();		}
			else if(this.body.position.x < this.targetx)  	 {		this.body.accelRight();		}
		}
		if(this.targety) {
			if(this.body.position.y < this.targety) 		 {		this.body.accelDown();		}
			else if(this.body.position.y > this.targety)  	 {		this.body.accelUp();		}
		}
	};
	
	this.updatePosition = function() {
		this.body.imposeBounds();
		this.body.move();
	}
};