package baldwin.sharkfish.async.model;

public class TankEvent {
	static final int EVENT_MOVE = 1;
	
	static final int ACTOR_GASH = 1;
	static final int ACTOR_GUPPY = 2;
	
	private String playerId;
	private String tankId;
	private int eventType;
	private int actor;
	private float targetX;
	private float targetY;
	
	public String getPlayerId() {
		return playerId;
	}
	public void setPlayerId(String playerId) {
		this.playerId = playerId;
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
	public float getTargetX() {
		return targetX;
	}
	public void setTargetX(float targetX) {
		this.targetX = targetX;
	}
	public float getTargetY() {
		return targetY;
	}
	public void setTargetY(float targetY) {
		this.targetY = targetY;
	}
}
