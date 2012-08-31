package baldwin.sharkfish.async.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.async.DeferredResult;

import baldwin.sharkfish.async.model.Player;
import baldwin.sharkfish.async.model.Tank;
import baldwin.sharkfish.async.model.TankEvent;
import baldwin.sharkfish.repository.PlayerRepository;
import baldwin.sharkfish.repository.TankRepository;

@Controller
@RequestMapping("/gameplay/")
public class GameplayController {

	static Logger log = LoggerFactory.getLogger(GameplayController.class);
	
	@Autowired
	PlayerRepository playerRepository;
	
	@Autowired
	TankRepository tankRepository;

	@RequestMapping(method=RequestMethod.GET, produces="application/json")
	public @ResponseBody Object get(@RequestParam String facebookId) {
		Player player = playerRepository.get(facebookId);
		if(null == player) {
			return "Player is null.";
		}
		
		String tankId = player.getTankId();
		Tank tank = tankRepository.get(tankId);
		if(null == tank) {
			return "Tank is null.";
		}
		
		log.debug("Found tank [{}] and player [{}]", tank, player);
		log.debug("Player last update: {}, tank last update: {}", player.getLastUpdate(), tank.getLastUpdate());
		
		if(player.getLastUpdate() >= tank.getLastUpdate()) {
			//player does not need to be updated. hold the response
			DeferredResult deferredResult = new DeferredResult(tank);
			player.setDeferredResult(deferredResult);
			return deferredResult;
		} else {
			player.setLastUpdate(tank.getLastUpdate());
			return tank;
		}
	}
	
	@RequestMapping(method=RequestMethod.POST, produces="application/json")
	public @ResponseBody Tank post(TankEvent tankEvent) {
		String facebookId = tankEvent.getFacebookId();
		String tankId = tankEvent.getTankId();
		
		log.debug("Tank event received from {}, for tank {}", facebookId, tankId);
		
		Player player = playerRepository.get(facebookId);
		Tank tank = tankRepository.get(tankId);

		log.debug("Found tank [{}] and player [{}]", tank, player);
		
		player.setLastUpdate(tank.getLastUpdate() + 1);
		tank.newEvent(tankEvent);
		return tank;
	}
}
