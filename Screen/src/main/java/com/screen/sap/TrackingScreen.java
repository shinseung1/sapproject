package com.screen.sap;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class TrackingScreen{

	@Autowired
	@RequestMapping(value="/tracking/new.do" , method = RequestMethod.GET)
	public ModelAndView track() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("tracking/new");	
		return mav;
	}
	@Autowired
	@RequestMapping(value="/tracking/track.do" , method = RequestMethod.GET)
	public ModelAndView track2() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("tracking/track");	
		return mav;

	
	}
}
