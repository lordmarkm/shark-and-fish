package baldwin.sharkfish.controller;

import static baldwin.sharkfish.controller.MavBuilder.render;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.social.connect.ConnectionRepository;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller @RequestMapping("/info/")
public class InfoController {
	
	static Logger log = LoggerFactory.getLogger(InfoController.class);
	
	@Inject 
	private Facebook facebook;
	
	@Inject 
	private ConnectionRepository connectionRepository;
	
	@RequestMapping("/security")
	public ModelAndView securityInfo() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		return render("securityinfo")
				.addFacebookInfo(facebook)
				.addObject("authorities", auth.getAuthorities())
				.mav();
	}
	
	@RequestMapping("/social")
	public ModelAndView socialInfo() {
		return render("socialinfo")
				.addFacebookInfo(facebook)
				.addObject("providers", connectionRepository.findAllConnections())
				.mav();
	}
}
