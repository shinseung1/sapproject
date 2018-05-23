package com.screen.sap;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class TrackingScreen{

	@Autowired
	@RequestMapping(value="/tracking/selectscreen.do" , method = RequestMethod.GET)
	public ModelAndView selectScreen() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("tracking/selectScreen");	
		return mav;
	}
	@Autowired
	@RequestMapping(value="/tracking/trackm.do" , method = RequestMethod.GET)
	public ModelAndView trackm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("tracking/trackM");	
		return mav;
	}
		@Autowired
		@RequestMapping(value="/tracking/trackp.do" , method = RequestMethod.GET)
		public ModelAndView trackp() {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("tracking/trackP");	
			return mav;
		}
	
		@Autowired
		@RequestMapping(value="/produ/login.do" , method = RequestMethod.GET)
		public ModelAndView login() {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("produ/login");	
			return mav;
		}	
		@Autowired
		@RequestMapping(value="/produ/report.do" , method = RequestMethod.GET)
		public ModelAndView report() {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("produ/report");	
			return mav;
		}	

		@Autowired
		@RequestMapping(value="/desktop/select.do" , method = RequestMethod.GET)
		public ModelAndView select() {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("desktop/select");	
			return mav;
		}	

		@Autowired
		@RequestMapping(value="/desktop/select2.do" , method = RequestMethod.GET)
		public ModelAndView select2() {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("desktop/select2");	
			return mav;
		}	

		@Autowired
		@RequestMapping(value="/desktop/update.do" , method = RequestMethod.GET)
		public ModelAndView update() {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("desktop/update");	
			return mav;
		}	
}
