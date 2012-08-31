package baldwin.sharkfish.async.model;

public class TankEvent {
	static final int EVENT_MOVE = 1;
	
	static final int ACTOR_GASH = 1;
	static final int ACTOR_GUPPY = 2;
	
	private String facebookId;
	private String tankId;
	private int eventType;
	private int actor;
	private int targetX;
	private int targetY;
	
	public String getFacebookId() {
		return facebookId;
	}
	public void setFacebookId(String facebookId) {
		this.facebookId = facebookId;
	}
	public String getTankId() {
		return tankId;
	}
	public void setTankId(String tankId) {
		this.tankId = tankId;
	}
	public int getEventType() {
		return eventType;
	}
	public void setEventType(int eventType) {
		this.eventType = eventType;
	}
	public int getActor() {
		return actor;
	}
	public void setActor(int actor) {
		this.actor = actor;
	}
	public int getTargetX() {
		return targetX;
	}
	public void setTargetX(int targetX) {
		this.targetX = targetX;
	}
	public int getTargetY() {
		return targetY;
	}
	public void setTargetY(int targetY) {
		this.targetY = targetY;
	}
}
