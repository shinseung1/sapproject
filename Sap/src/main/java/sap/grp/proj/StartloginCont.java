package sap.grp.proj;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class StartloginCont {

	@Autowired
	@Qualifier("sap.grp.proj.StartloginProc")
	private StartloginProc startloginProc;
	
	@RequestMapping(value = "/login/create.do" , method = RequestMethod.GET)
	public ModelAndView create() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/login/create");

		return mav;
		
	}

	@RequestMapping(value = "/login/create2.do" , method = RequestMethod.GET)
	public ModelAndView create2() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/login/create2");

		return mav;
		
	}
	
	@RequestMapping(value = "/login/NewFile.do" , method = RequestMethod.GET)
	public ModelAndView NewFile() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/login/NewFile");

		return mav;
		
	}
	@ResponseBody
	@RequestMapping(value = "/login/checkId.do" , method  = RequestMethod.GET)
	public String checkId(String id) {
		
		JSONObject obj = new JSONObject();
		
		int cnt = startloginProc.checkId(id);
		
		obj.put("cnt", cnt);
		return obj.toJSONString();
		
	}
	
	
}
