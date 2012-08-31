package baldwin.sharkfish.async.model;

import java.util.HashSet;
import java.util.Set;

import org.apache.commons.beanutils.PropertyUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import baldwin.sharkfish.repository.PlayerRepository;

public class Tank {
	private Logger log;
	private String id;
	private volatile long lastUpdate = 0;
	private Swimmer gash = new Swimmer();
	private Set<String> players;
	private PlayerRepository playerRepository;
	
	public Tank(String id) {
		players = new HashSet<String>();
		this.id = id;
		log = LoggerFactory.getLogger("Tank#" + id);
	}
	
	public synchronized void newEvent(TankEvent tankEvent) {
		lastUpdate++;
		
		try {
			log.info("New event [{}]", PropertyUtils.describe(tankEvent));
		} catch (Exception e) {
			//Swallow exception
		}
		
		switch(tankEvent.getEventType()) {
		case TankEvent.EVENT_MOVE:
			switch(tankEvent.getActor()) {
			case TankEvent.ACTOR_GASH:
				gash.setTargetX(tankEvent.getTargetX());
				gash.setTargetY(tankEvent.getTargetY());
				break;
			}
			break;
		}
		
		for(String playerId : players) {
			Player player = playerRepository.get(playerId);
			if(player.getLastUpdate() < lastUpdate)	player.handleUpdate(this);
		}
	}
	
	public void addPlayer(Player player) {
		players.add(player.getId());
		player.setTankid(id);
		
		int population = players.size();
		
		switch(population) {
		case 1:
			player.setActor(TankEvent.ACTOR_GASH);
			break;
		case 2:
			player.setActor(TankEvent.ACTOR_GUPPY);
			break;
		}
	}
	
	public long getLastUpdate() {
		return lastUpdate;
	}
	public void setLastUpdate(long lastUpdate) {
		this.lastUpdate = lastUpdate;
	}
	public Swimmer getGash() {
		return gash;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getId() {
		return id;
	}
	public boolean isLonely() {
		return players.size() < 2;
	}

	public void setPlayerRepository(PlayerRepository playerRepository) {
		this.playerRepository = playerRepository;
	}
}
