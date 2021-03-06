function Vector2() {			// any variable with x and y components
	this.x = 0;
	this.y = 0;	
	this.set = function(xtoset, ytoset) {
		this.x = xtoset;
		this.y = ytoset;
		return this;
	}
	this.reverse = function() {
		this.x -= this.x;
		this.y -= this.y;
		return this;
	};
	this.add = function(xtoadd, ytoadd) {
		this.x += xtoadd;
		this.y += ytoadd;
		return this;
	};
	this.addvector = function(otherVector) {
		this.x += otherVector.x;
		this.y += otherVector.y;
		return this;
	};
	this.addVectorDT	=	function (otherVector) {
		this.x += otherVector.x * dt;
		this.y += otherVector.y * dt;
		return this;
	}
}

function PhysicalBody(params) {
	this.position	= new Vector2().set(params.pos_x, params.pos_y);			// logical position of the physical body (and center of circle)
	this.v			= new Vector2().set(params.v_x, params.v_y);				// instantaneous velocity of physical body expressed in pixels per second
	this.vmax		= new Vector2().set(params.vmax_x,  params.vmax_y);			// maximum allowable velocity of physical body expressed in pixels per second
	this.a			= new Vector2().set(params.a_x, params.a_y);				// acceleration to apply to velocity in the next frame (pixels per second squared).
	this.friction	= new Vector2();											// friction to apply to velocity
	this.radius		= params.radius;											// circle radius in pixels. used to calculate collisions
	this.cage 		= params.cage;
	
	//updates
	this.move		= function() {
		this.position.addVectorDT(	this.v	);
	};

	//accelerations
	this.accelHorizontal	=	function(positiveOrNegative) {
		this.v.x	+=	this.a.x * dt * positiveOrNegative;
	};
	this.accelVertical	=	function(positiveOrNegative) {
		this.v.y	+=	this.a.y * dt * positiveOrNegative;
	};

	this.accelLeft	=	 function() {		this.accelHorizontal(-1);		};
	this.accelRight	=	 function() {		this.accelHorizontal(1);		};
	this.accelUp	=	 function() {		this.accelVertical(-1);			};
	this.accelDown	=	 function() {		this.accelVertical(1);			};

	var updates = 0;
	this.imposeBounds = function() {
		this.v.x = bound(this.v.x, -(this.vmax.x), this.vmax.x);
		this.v.y = bound(this.v.y, -(this.vmax.y), this.vmax.y);
		this.position.x = bound(this.position.x, this.cage.min_x, this.cage.max_x);
		this.position.y = bound(this.position.y, this.cage.min_y, this.cage.max_y);
		
		if(updates++ %100 ===0) debug('posx: ' + this.position.x + ' posy: ' + this.position.y);
	};

	//collision checker (bools)
	this.isCollidingWithCircle = function(othercircleX, othercircleY, othercircleRadius) {
		var distanceSq = (this.position.x - othercircleX) * (this.position.x - othercircleX) + (this.position.y - othercircleY) * (this.position.y - othercircleY);
		var radiusSumSq = (this.radius + othercircleRadius) * (this.radius + othercircleRadius);
		return (radiusSumSq - distanceSq) > 0;
	};
	this.isCollidingWithBody = function(otherbody) {
		return this.isCollidingWithCircle(	otherbody.position.x, 	otherbody.position.y, 	otherbody.radius	);
	};
}