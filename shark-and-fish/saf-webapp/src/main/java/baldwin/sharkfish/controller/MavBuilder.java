package baldwin.sharkfish.controller;

import org.springframework.social.facebook.api.Facebook;
import org.springframework.web.servlet.ModelAndView;

public class MavBuilder {
	private ModelAndView mav;
	
	public static MavBuilder render(String view) {
		return new MavBuilder(view);
	}
	
	public MavBuilder(String view) {
		mav = new ModelAndView(view);
	}
	
	public MavBuilder addObject(String name, Object object) {
		mav.addObject(name, object);
		return this;
	}
	
	public MavBuilder addFacebookInfo(Facebook facebook) {
		mav.addObject("facebookProfile", facebook.userOperations().getUserProfile());
		mav.addObject("facebookProfileImage", Facebook.GRAPH_API_URL + facebook.userOperations().getUserProfile().getId() + "/picture");
		return this;
	}
	
	public ModelAndView mav() {
		return mav;
	}
}
