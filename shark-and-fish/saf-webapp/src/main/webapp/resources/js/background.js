function SFBackground(params) {
	//these are constants
	var master;
	this.setMaster = function(_master) {
		master = _master;
	}
	
	var scrollspeed = params.scrollspeed;						//background scrolling speed in pixels/sec
	var noscroll_edge_left = params.noscroll_edge_left;			//bg will only start to scroll when these are exceeded
	var noscroll_edge_right = params.noscroll_edge_right;
	var min_scroll = params.min_scroll;							//edges of scrollable area
	var max_scroll = params.max_scroll;
	this.image = new Image();
	this.image.src = params.src;
	
	//these are volatile
	this.offset_x = 0;
	this.offset_y = 0;
	
	var updates = 0;
	this.update = function() {
		if(!master) {
			return;
		}
		
		if(master.sprite.attrs.x > noscroll_edge_right
				&& this.offset_x > min_scroll) {
			
			this.offset_x -= scrollspeed * dt;
			
		} else if(master.sprite.attrs.x < noscroll_edge_left
				&& this.offset_x < max_scroll) {
			
			this.offset_x += scrollspeed * dt;
			
		}
		
		//TODO handle y scrolling
	}
}