var bound = function (value, minv, maxv) {
	return Math.min(Math.max(minv, value), maxv);		//makes sure _value is between minv and maxv
};

var constants = {
	actor_gash : 1,
	actor_fish : 2,
	
	eventType_move : 1
}