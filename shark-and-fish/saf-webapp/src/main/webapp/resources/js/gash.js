/*
 * Singleton Gash instance
 */
var gash = new function() {
	/*
	 * Animation
	 */
	this.sprite = {};
	
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
		if(gash.targetx) {
			if(gash.sprite.attrs.x > gash.targetx) {
				if(gash.sprite.getAnimation()==='swimright') {
					gash.sprite.setAnimation('turnRtoL');
					gash.sprite.afterFrame(9, function(){
						gash.sprite.setAnimation('swimleft');
					});
				}
			} else if(gash.sprite.attrs.x < gash.targetx) {
				if(gash.sprite.getAnimation()==='swimleft') {
					gash.sprite.setAnimation('turnLtoR');
					gash.sprite.afterFrame(9, function(){
						gash.sprite.setAnimation('swimright');
					});
				}
			}
		}
	};
	
	this.body = new PhysicalBody({
		radius : 30,
		pos_x  : 350,
		pos_y  : 100,
		vmax_x : 600,
		vmax_y : 200,
		a_x    : 400,
		a_y    : 400
	});
	
	this.gAI = function() {
		if(gash.targetx) {
			if(gash.sprite.attrs.x > gash.targetx) 		 {		gash.accelLeft();		}
			else if(gash.sprite.attrs.x < gash.targetx)  {		gash.accelRight();		}
		}
		if(gash.targety) {
			if(gash.sprite.attrs.y < gash.targety) 		 {		gash.accelDown();		}
			else if(gash.sprite.attrs.y > gash.targety)  {		gash.accelUp();			}
		}
	};
	
	this.update = function() {
		gash.body.limitV();
		gash.body.move();
		
		gash.sprite.attrs.x = gash.body.position.x - 40.0;
		gash.sprite.attrs.y = gash.body.position.y - 40.0;
	}
};