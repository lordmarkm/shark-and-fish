package baldwin.sharkfish.controller;

import static baldwin.sharkfish.controller.MavBuilder.render;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller @RequestMapping({"/test", "/test/"})
public class TestController {
	
	static Logger log = LoggerFactory.getLogger(TestController.class);
	
	@Inject private Facebook facebook;
	
	@RequestMapping("/")
	public ModelAndView helloworld() {
		log.debug("Facebook first name: {}", facebook.userOperations().getUserProfile().getFirstName());
		
		return render("gash")
				.addObject("facebookProfile", facebook.userOperations().getUserProfile())
				.mav();
	}
	
	@RequestMapping("/shark/")
	public String shark() {
		return "gash";
	}
}
