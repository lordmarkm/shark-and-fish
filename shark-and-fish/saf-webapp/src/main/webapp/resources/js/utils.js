var dt = 0.0;										//time between updates (delta Time)		
var prevTime = new Date().getTime();				//time of last update

var calculateDT = function() {
	var nowTime = new Date().getTime();
	dt = (nowTime - prevTime) * 0.001;
	prevTime = nowTime;
};

var bound = function (value, minv, maxv) {
	return Math.min(Math.max(minv, value), maxv);		//makes sure _value is between minv and maxv
};

var constants = {
		actor_gash : 1,
		actor_fish : 2,

		eventType_move : 1
}

var debug = function(msg) {
	console.debug(msg);
}