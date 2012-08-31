/*
 * Server interfaces will implement:
 * 1. post(...) 
 * 		- Handle input from the Game Loop and relay this data to the server
 * 		- Arg data is in the form {'obj' : string id of object, 'tX' : int target x, 'tY' : int target y}
 * 
 * 2. get() - Expose a list of previous instructions received from the server to the Game Loop
 * 
 */
var server = {
	gash: {},
	
	gameplayUrl: '/saf-webapp/gameplay/',
	
	post: function(tankEvent) {
		$.post(server.gameplayUrl, tankEvent, server.handleTank);
	},
	
	start: function() {
		server.poll();
	},
	
	poll: function() {
		$.get(server.gameplayUrl, 'facebookId='+server.facebookId, function(tank) {
			server.handleTank(tank);
			server.poll(); //if you take this outside the get.success function, 
						   //it will not wait for the get to return and your browser
						   //will die
		});
	},
	
	handleTank:	function(tank) {
		console.debug('Handling tank ' + JSON.stringify(tank));
		server.gash.targetx = tank.gash.targetX;
		server.gash.targety = tank.gash.targetY;
	}
};