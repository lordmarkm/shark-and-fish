package baldwin.sharkfish.async.controller;

import static baldwin.sharkfish.controller.MavBuilder.render;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import baldwin.sharkfish.async.model.Player;
import baldwin.sharkfish.async.model.Tank;
import baldwin.sharkfish.repository.PlayerRepository;
import baldwin.sharkfish.repository.TankRepository;

@Controller
@RequestMapping("/game/")
public class GameController {
	
	@Autowired
	TankRepository tankRepository;
	
	@Autowired
	PlayerRepository playerRepository;
	
	@Inject 
	private Facebook facebook;
	
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView join() {
		Tank tank = tankRepository.getWaitingTank();
		if(null == tank) {
			tank = tankRepository.newTank();
			tank.setPlayerRepository(playerRepository);
		}
		
		String facebookId = facebook.userOperations().getUserProfile().getId();
		Player player = playerRepository.get(facebookId);
		if(null == player) {
			player = playerRepository.newPlayer(facebookId);
		}
		
		tank.addPlayer(player);
		
		return render("gash")
				.addFacebookInfo(facebook)
				.addObject("playerId", facebookId)
				.addObject("player", player)
				.addObject("tank", tank)
				.mav();
	}
}
