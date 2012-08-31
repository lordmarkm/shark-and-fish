package baldwin.sharkfish.async.model;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.async.DeferredResult;

public class Player {
	static Logger log = LoggerFactory.getLogger(Player.class);
	
	private String id;
	private int actor;
	private String tankId;
	private volatile long lastUpdate;
	private DeferredResult deferredResult;
	private final Object lock = new Object();
	
	public void handleUpdate(Tank tank) {
		this.lastUpdate = tank.getLastUpdate();
		
		if(this.deferredResult == null) {
			log.warn("Deferred result is null. Event will be lost.");
			return;
		}
		
		synchronized(this.lock) {
			if(this.deferredResult != null) {
				this.deferredResult.set(tank);
				this.deferredResult = null;
			}
		}
	}
	
	public void setDeferredResult(DeferredResult deferredResult) {
		this.deferredResult = deferredResult;
	}
	
	public long getLastUpdate() {
		return lastUpdate;
	}

	public void setLastUpdate(long lastUpdate) {
		this.lastUpdate = lastUpdate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setActor(int actor) {
		this.actor = actor;
	}
	public int getActor() {
		return actor;
	}
	
	public void setTankid(String tankId) {
		this.tankId = tankId;
	}
	public String getTankId() {
		return tankId;
	}
}
