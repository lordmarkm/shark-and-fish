package baldwin.sharkfish.repository;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import baldwin.sharkfish.async.model.Player;

@Repository
public class PlayerRepository {
	static Logger log = LoggerFactory.getLogger(PlayerRepository.class);
	
	public Map<String, Player> players = new HashMap<String, Player>();
	
	public Player newPlayer(String facebookId) {
		log.debug("Creating player with name {}", facebookId);
		
		Player newPlayer = new Player();
		newPlayer.setId(facebookId);
		players.put(facebookId, newPlayer);
		return newPlayer;
	}

	public Player get(String facebookId) {
		log.debug("Finding player using {}", facebookId);
		Player player = players.get(facebookId);
		if(null == player) {
			log.warn("No player {} in {}", facebookId, players.keySet());
		}
		return players.get(facebookId);
	}
}
