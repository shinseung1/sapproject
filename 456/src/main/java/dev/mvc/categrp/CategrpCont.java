package dev.mvc.categrp;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.category.CategoryProcInter;

@Controller
public class CategrpCont {
  @Autowired
  @Qualifier("dev.mvc.category.CategoryProc")
  private CategoryProcInter categoryProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.categrp.CategrpProc2")
  private CategrpProcInter categrpProc = null;
  
  public CategrpCont() {
    System.out.println("--> CategrpCont created.");
    
    if (categrpProc != null) {
      System.out.println("--> categrpProc �Ҵ��");
    }
  }
  
  // http://localhost:9090/blog/categrp/create.jsp ��
  // http://localhost:9090/blog/categrp/create.do
  @RequestMapping(value="/categrp/create.do", method=RequestMethod.GET)
  public ModelAndView create(){
    System.out.println("--> create() GET executed");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/categrp/create"); // /webapp/categrp/create.jsp

    if (categrpProc != null) {
      System.out.println("--> categrpProc �Ҵ�Ǿ�����.");
    }
    
    return mav;
  }

  @RequestMapping(value="/categrp/create.do", method=RequestMethod.POST)
  public ModelAndView create(CategrpVO categrpVO){
    System.out.println("--> create() POST executed");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/categrp/message"); // /webapp/categrp/message.jsp
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    if (categrpProc != null) {
      System.out.println("--> categrpProc �Ҵ�Ǿ�����.");
    }
    
    if (categrpProc.create(categrpVO) == 1) {
      // msgs.add("ī�װ� �׷��� ����߽��ϴ�.");
      mav.setViewName("redirect:/categrp/list.do");
    } else {
      msgs.add("ī�װ� �׷� ��Ͽ� �����߽��ϴ�.");
      msgs.add("�˼������� �ٽ��ѹ� �õ����ּ���. �� ���� ���: 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back()\">�ٽ� �õ�</button>");
    }
    links.add("<button type='button' onclick=\"location.href='./list.do'\">���</button>");
    
    mav.addObject("msgs", msgs);
    mav.addObject("links", links);
    
    return mav;
  }
  
  // http://localhost:9090/blog/categrp/list.do
  @RequestMapping(value = "/categrp/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    // System.out.println("--> test_code: " + test_code);
    
    // System.out.println("--> list() GET executed");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/categrp/list"); // /webapp/categrp/list.jsp

    List<CategrpVO> list = categrpProc.list();
    mav.addObject("list", list);

    return mav;
  }
  
  // http://localhost:9090/blog/categrp/update.do
  // ResponseBody: JSON ���, ������ �̵� ����.
  @ResponseBody
  @RequestMapping(value="/categrp/update.do", 
                              method=RequestMethod.GET,
                              produces="text/plain;charset=UTF-8")
  public String update(int categrpno){
    System.out.println("--> update() GET executed");

    CategrpVO categrpVO = categrpProc.read(categrpno);
    
    JSONObject obj = new JSONObject();
    obj.put("categrpno", categrpno);
    obj.put("name", categrpVO.getName());
    obj.put("seqno", categrpVO.getSeqno());
    obj.put("visible", categrpVO.getVisible());    
    obj.put("rdate", categrpVO.getRdate());       
    
    return obj.toJSONString();
  }
   
  @RequestMapping(value="/categrp/update.do", method=RequestMethod.POST)
  public ModelAndView update(CategrpVO categrpVO){
    System.out.println("--> update() POST executed");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/categrp/message"); // /webapp/categrp/message.jsp
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    if (categrpProc != null) {
      System.out.println("--> categrpProc �Ҵ�Ǿ�����.");
    }
    
    if (categrpProc.update(categrpVO) == 1) {
      msgs.add("ī�װ� �׷��� �����߽��ϴ�.");
    } else {
      msgs.add("ī�װ� �׷� ������ �����߽��ϴ�.");
      msgs.add("�˼������� �ٽ��ѹ� �õ����ּ���. �� ���� ���: 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back()\">�ٽ� �õ�</button>");
    }
    links.add("<button type='button' onclick=\"location.href='./list.do'\">���</button>");
    
    mav.addObject("msgs", msgs);
    mav.addObject("links", links);
    
    return mav;
  }

  // http://localhost:9090/blog/categrp/delete.do?categrpno=1
  // ResponseBody: JSON ���, ������ �̵� ����.
  @ResponseBody
  @RequestMapping(value="/categrp/delete.do", 
                              method=RequestMethod.GET,
                              produces="text/plain;charset=UTF-8")
  public String deleteForm(int categrpno){
    System.out.println("--> delete() GET executed");

    int count = categoryProc.countByCategrpno(categrpno);
    
    CategrpVO categrpVO = categrpProc.read(categrpno);
    
    JSONObject obj = new JSONObject();
    obj.put("count", count);
    
    obj.put("categrpno", categrpno);
    obj.put("name", categrpVO.getName());
    obj.put("seqno", categrpVO.getSeqno());
    obj.put("visible", categrpVO.getVisible());    
    obj.put("rdate", categrpVO.getRdate());       
    
    return obj.toJSONString();
  }
  
  @RequestMapping(value="/categrp/delete.do", 
                             method=RequestMethod.POST)
  public ModelAndView delete(int categrpno){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/categrp/message"); // /webapp/categrp/message.jsp
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    int deleteByCategrpno = categoryProc.deleteByCategrpno(categrpno);
    
    if (categrpProc.delete(categrpno) == 1) {
      // msgs.add("ī�װ� �׷��� �����߽��ϴ�.");
      // mav.setViewName("redirect:/categrp/list.do" + "?test_code=1");
      mav.setViewName("redirect:/categrp/list.do");
    } else {
      msgs.add("ī�װ� �׷� ������ �����߽��ϴ�.");
      msgs.add("�˼������� �ٽ��ѹ� �õ����ּ���. �� ���� ���: 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back()\">�ٽ� �õ�</button>");
    }
    links.add("<button type='button' onclick=\"location.href='./list.do'\">���</button>");
    
    mav.addObject("msgs", msgs);
    mav.addObject("links", links);
    
    return mav;
  }
 
  @RequestMapping(value = "/categrp/update_seqno_up.do", 
                             method = RequestMethod.POST)
  public ModelAndView update_seqno_up(int categrpno) {
    ModelAndView mav = new ModelAndView();

    if (categrpProc.update_seqno_up(categrpno) == 1) {
      mav.setViewName("redirect:/categrp/list.do");
    }

    return mav;
  }

  @RequestMapping(value = "/categrp/update_seqno_down.do", 
                             method = RequestMethod.POST)
  public ModelAndView update_seqno_down(int categrpno) {
    ModelAndView mav = new ModelAndView();

    if (categrpProc.update_seqno_down(categrpno) == 1) {
      mav.setViewName("redirect:/categrp/list.do");
    }

    return mav;
  }
  
}



