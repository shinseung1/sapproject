package dev.mvc.category;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.blog.BlogProcInter;
import dev.mvc.categrp.CategrpProcInter;
import dev.mvc.categrp.CategrpVO;

@Controller
public class CategoryCont {
  @Autowired
  @Qualifier("dev.mvc.category.CategoryProc")
  private CategoryProcInter categoryProc = null;

  @Autowired
  @Qualifier("dev.mvc.categrp.CategrpProc2")
  private CategrpProcInter categrpProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.blog.BlogProc")
  private BlogProcInter blogProc = null;

  public CategoryCont() {
    System.out.println("--> CategoryCont created.");
  }

  // http://localhost:9090/blog/category/create.jsp →
  // http://localhost:9090/blog/category/create.do
  @RequestMapping(value = "/category/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    System.out.println("--> create() GET executed");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/create"); // /webapp/category/create.jsp

    return mav;
  }

  @RequestMapping(value = "/category/create.do", method = RequestMethod.POST)
  public ModelAndView create(CategoryVO categoryVO) {
    System.out.println("--> create() POST executed");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/message"); // /webapp/category/message.jsp

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    if (categoryProc.create(categoryVO) == 1) {
      // msgs.add("카테고리를 등록했습니다.");
      mav.setViewName("redirect:/category/list.do");
    } else {
      msgs.add("카테고리 등록에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 전산 운영팀: 000-0000-0000");
      links
          .add("<button type='button' onclick=\"history.back()\">다시 시도</button>");
    }
    links
        .add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");

    mav.addObject("msgs", msgs);
    mav.addObject("links", links);

    return mav;
  }

  // http://localhost:9090/blog/category/list.do
  @RequestMapping(value = "/category/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    // System.out.println("--> list() GET executed");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/list"); // /webapp/category/list.jsp

    List<Categrp_CategoryVO> list = categoryProc.list();
    mav.addObject("list", list);

    return mav;
  }
  
  /**
   * 화면 하단에 출력되는 카테고리
   * @param request
   * @return
   */
  @RequestMapping(value = "/category/list_index.do", method = RequestMethod.GET)
  public ModelAndView list_index(HttpServletRequest request) {
    // System.out.println("--> list_index() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/list_index"); // webapp/category/list_index.jsp

    List<CategrpVO> categrp_list = categrpProc.list();

    List<Categrp_CategoryVO> category_list = categoryProc.list();

    // Categrp: name, Category: title 결합 목록
    ArrayList<String> name_title_list = new ArrayList<String>();

    StringBuffer url = new StringBuffer(); // 카테고리 제목 링크 조합

    for (int index = 0; index < categrp_list.size(); index++) {
      String name = categrp_list.get(index).getName();
      name_title_list.add("<LI class='categrp_name'>" + name + "</LI>");

      for (int j = 0; j < category_list.size(); j++) {
        Categrp_CategoryVO categrp_CategoryVO = category_list.get(j);
        String title = categrp_CategoryVO.getTitle();
        int cnt = categrp_CategoryVO.getCnt();
        if (name.equals(categrp_CategoryVO.getName()) == true && title != null) {
          url.append("<LI class='category_title'>");
          url.append("  <A href='" + request.getContextPath()
              + "/blog/list.do'>");
          url.append(title);
          url.append("  </A>");
          url.append("  <span style='font-size: 0.9em; color: #555555;'>("
              + cnt + ")</span>");
          url.append("</LI>");
          name_title_list.add(url.toString()); // 출력 목록에 하나의 category 추가

          url.delete(0, url.toString().length()); // StringBuffer 문자열 삭제

        }
      }
    }

    mav.addObject("name_title_list", name_title_list);
    mav.addObject("total_count", blogProc.total_count());

    return mav;
  }

  /**
   * <Xmp> 수정 폼 SELECT categoryno, categrpno, title, seqno, visible, ids, rdate
   * FROM category WHERE categoryno=#{categoryno} </Xmp>
   * 
   * @param categrpno
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/category/update.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String update(int categoryno) {
    System.out.println("--> update() GET executed");

    CategoryVO categoryVO = categoryProc.read(categoryno);

    JSONObject obj = new JSONObject();
    obj.put("categoryno", categoryno);
    obj.put("categrpno", categoryVO.getCategrpno());
    obj.put("title", categoryVO.getTitle());
    obj.put("seqno", categoryVO.getSeqno());
    obj.put("visible", categoryVO.getVisible());
    obj.put("ids", categoryVO.getIds());
    obj.put("rdate", categoryVO.getRdate());

    return obj.toJSONString();
  }

  @RequestMapping(value = "/category/update.do", method = RequestMethod.POST)
  public ModelAndView update(CategoryVO categoryVO) {
    System.out.println("--> update() POST executed");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/message"); // /webapp/categrp/message.jsp

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    if (categoryProc.update(categoryVO) == 1) {
      msgs.add("카테고리를 변경했습니다.");
    } else {
      msgs.add("카테고리를 변경에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 전산 운영팀: 000-0000-0000");
      links
          .add("<button type='button' onclick=\"history.back()\">다시 시도</button>");
    }
    links
        .add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");

    mav.addObject("msgs", msgs);
    mav.addObject("links", links);

    return mav;
  }

  @RequestMapping(value = "/category/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int categoryno) {
    System.out.println("--> delete() POST executed");

    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/message"); // /webapp/categrp/message.jsp

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    int count = categoryProc.delete(categoryno);
    System.out.println("categoryno: " + categoryno);
    System.out.println("count: " + count);

    if (count == 1) {
      msgs.add("카테고리를 삭제했습니다.");
    } else {
      msgs.add("카테고리 삭제에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 전산 운영팀: 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back()\">다시 시도</button>");
    }
    links.add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");

    mav.addObject("msgs", msgs);
    mav.addObject("links", links);

    return mav;
  }

  @RequestMapping(value = "/category/update_seqno_up.do", 
                             method = RequestMethod.POST)
  public ModelAndView update_seqno_up(int categoryno) {
    ModelAndView mav = new ModelAndView();

    if (categoryProc.update_seqno_up(categoryno) == 1) {
      mav.setViewName("redirect:/category/list.do");
    }

    return mav;
  }

  @RequestMapping(value = "/category/update_seqno_down.do", 
                             method = RequestMethod.POST)
  public ModelAndView update_seqno_down(int categoryno) {
    ModelAndView mav = new ModelAndView();

    if (categoryProc.update_seqno_down(categoryno) == 1) {
      mav.setViewName("redirect:/category/list.do");
    }

    return mav;
  }
 
  /**
   * 카테고리 그룹에 해당하는 카테고리 삭제
   * @param categrpno
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/category/deleteByCategrpno.do", 
                              method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
  public String deleteByCategrpno(int categrpno) {
    System.out.println("--> update() GET executed");

    int count = categoryProc.deleteByCategrpno(categrpno);

    JSONObject obj = new JSONObject();
    obj.put("count", count);

    return obj.toJSONString();
  }
  
  @RequestMapping(value="/category/list_index_left.do", method=RequestMethod.GET)
  public ModelAndView list_index_left(HttpServletRequest request){
    // System.out.println("--> list_index() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/list_index_left"); // webapp/category/list_index_left.jsp
    
    List<CategrpVO> categrp_list = categrpProc.list();
    List<Categrp_CategoryVO> category_list = categoryProc.list();
    
    // Categrp: name, Category: title 결합 목록
    ArrayList<String> name_title_list = new ArrayList<String>();   
    
    StringBuffer url = new StringBuffer(); // 카테고리 제목 링크 조합
    
    for (int index = 0; index < categrp_list.size(); index++) {
      String name = categrp_list.get(index).getName();
      name_title_list.add("<LI class='categrp_name'>"+ name + "</LI>");
      
      for (int j=0; j < category_list.size(); j++) {
        Categrp_CategoryVO categrp_CategoryVO = category_list.get(j);
        String title = categrp_CategoryVO.getTitle();
        int cnt = categrp_CategoryVO.getCnt();
        if (name.equals(categrp_CategoryVO.getName()) == true && title != null) {
          url.append("<LI class='category_title'>");
          url.append("  <A href='" + request.getContextPath()+ "/blog/list_by_categoryno.do?categoryno="+categrp_CategoryVO.getCategoryno()+"&nowPage=1'>");
          url.append(title);
          url.append("  </A>");
          url.append("  <span style='font-size: 0.9em; color: #555555;'>("+cnt+")</span>");
          url.append("</LI>");
          name_title_list.add(url.toString()); // 출력 목록에 하나의 category 추가 
          
          url.delete(0, url.toString().length()); // StringBuffer 문자열 삭제
          
        }
      }
    }
    
    mav.addObject("name_title_list", name_title_list);
    mav.addObject("total_count", blogProc.total_count());
    
    return mav;
  }
  
  
}
