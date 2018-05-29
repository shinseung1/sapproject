package dev.mvc.blog;
 
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
 
@Controller
public class HomeController {
  @RequestMapping(value = "/home.do", method = RequestMethod.GET)
  public ModelAndView home() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("redirect:/index.jsp"); // ���� Ȯ���� ����
    
    return mav;
  }
  
  // http://localhost:9090/member/index.do
  /**
   * ���� ������
   * @param mno
   * @return
   */
  @RequestMapping(value = "/index.do", 
                            method = RequestMethod.GET)
  public ModelAndView home1() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/index"); // /webapp/index.jsp
 
    return mav;
  } 
  
}