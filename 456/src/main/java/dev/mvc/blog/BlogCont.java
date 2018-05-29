package dev.mvc.blog;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import nation.web.tool.Tool;
import nation.web.tool.Upload;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.category.CategoryProcInter;
import dev.mvc.category.CategoryVO;
import dev.mvc.category.Categrp_CategoryVO;
import dev.mvc.categrp.CategrpProcInter;

@Controller
public class BlogCont {
  @Autowired
  @Qualifier("dev.mvc.categrp.CategrpProc")
  private CategrpProcInter categrpProc = null;

  @Autowired
  @Qualifier("dev.mvc.category.CategoryProc")
  private CategoryProcInter categoryProc = null;

  @Autowired
  @Qualifier("dev.mvc.blog.BlogProc")
  private BlogProcInter blogProc = null;

  public BlogCont() {
    System.out.println("--> BlogCont created.");
  }

  // http://localhost:9090/blog/blog/create.do
  @RequestMapping(value = "/blog/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    System.out.println("--> create() GET executed");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/create"); // /webapp/blog/create.jsp

    return mav;
  }
  
  @RequestMapping(value = "/blog/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, BlogVO blogVO) {
    // System.out.println("--> create() POST executed");
    System.out.println(blogVO.getContent());
    
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/message"); // /webapp/blog/message.jsp

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/blog/storage");
    MultipartFile file1MF = blogVO.getFile1MF(); // Spring이 File 객체를 저장해둠.
    String file1 = ""; // 컬럼에 저장할 파일명
    long size1 = file1MF.getSize();
    String thumb = ""; // 컬럼에 저장할 파일명

    if (size1 > 0) {
      file1 = Upload.saveFileSpring(file1MF, upDir);
      // msgs.add("[파일 전송]");
      // msgs.add("'" + file1 + "' 전송됨");

      if (Tool.isImage(file1)) {
        thumb = Tool.preview(upDir, file1, 120, 80); // Thumb 이미지 생성
        // msgs.add("'" + thumb + "' Thumb 이미지 생성됨");
      }
    }
    blogVO.setFile1(file1);
    blogVO.setSize1(size1);
    blogVO.setThumb(thumb);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------

    if (blogProc.create(blogVO) == 1) {
      categoryProc.increaseCnt(blogVO.getCategoryno()); // 글수 증가

      // msgs.add("[등록 성공]");
      // msgs.add("글을 등록했습니다.");

      mav.setViewName("redirect:/blog/list_by_categoryno.do?categoryno="
          + blogVO.getCategoryno());
    } else {
      msgs.add("[등록 실패]");
      msgs.add("글 등록에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 전산 운영팀: 000-0000-0000");
      links
          .add("<button type='button' onclick=\"history.back()\">다시 시도</button>");

      links
          .add("<button type='button' onclick=\"location.href='./list_by_categoryno.do?categoryno="
              + blogVO.getCategoryno() + "'\">목록</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }

    return mav;
  }
 
  // http://localhost:9090/blog/blog/list_all_category.do
  @RequestMapping(value = "/blog/list_all_category.do", method = RequestMethod.GET)
  public ModelAndView list_all_category() {
    // System.out.println("--> list() GET executed");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/list_all_category"); // /webapp/blog/list_all_category.jsp

    List<BlogVO> list = blogProc.list_all_category();
    mav.addObject("list", list);

    return mav;
  }

/*  @RequestMapping(value = "/blog/list_by_categoryno.do", 
                            method = RequestMethod.GET)
  public ModelAndView list_by_categoryno(int categoryno) {
    System.out.println("--> list_by_categoryno() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/list_by_categoryno"); // webapp/blog/list_by_categoryno.jsp

    List<BlogVO> list = blogProc.list_by_categoryno(categoryno);
    mav.addObject("list", list);

    CategoryVO categoryVO = categoryProc.read(categoryno);
    mav.addObject("categoryVO", categoryVO);

    return mav;
  }
*/
  // http://localhost:9090/blog/blog/read.do
  @RequestMapping(value = "/blog/read.do", method = RequestMethod.GET)
  public ModelAndView read(int blogno, int categoryno) {
    System.out.println("--> read() GET executed");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/read"); // /webapp/blog/read.jsp

    BlogVO blogVO = blogProc.read(blogno);
    mav.addObject("blogVO", blogVO);

    CategoryVO categoryVO = categoryProc.read(categoryno);
    // CategoryVO categoryVO = categoryProc.read(blogVO.getCategoryno());
    mav.addObject("categoryVO", categoryVO);

    return mav;
  }

  // http://localhost:9090/blog/blog/update.do
  @RequestMapping(value = "/blog/update.do", method = RequestMethod.GET)
  public ModelAndView update(int categoryno, int blogno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/update"); // /webapp/blog/update.jsp

    BlogVO blogVO = blogProc.read(blogno);
    mav.addObject("blogVO", blogVO);

    CategoryVO categoryVO = categoryProc.read(categoryno);
    mav.addObject("categoryVO", categoryVO);

    return mav;
  }

  // @RequestParam(value="word_find", defaultValue="1") String word
  // String word = request.getParameter("word_find");
  @RequestMapping(value = "/blog/update.do", method = RequestMethod.POST)
  public ModelAndView update(HttpServletRequest request, 
                                           BlogVO blogVO, 
                                           int nowPage,
                                           String word_find
                                           ) {
    System.out.println("--> BlogCont.java word_find: " + word_find);
    
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/message"); // /webapp/blog/message.jsp

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/blog/storage");
    MultipartFile file1MF = blogVO.getFile1MF(); // Spring이 File 객체를 저장해둠.
    String file1 = ""; // 컬럼에 저장할 파일명
    long size1 = file1MF.getSize();
    String thumb = ""; // 컬럼에 저장할 파일명

    BlogVO blogVO_old = blogProc.read(blogVO.getBlogno());
    
    if (size1 > 0) { // 파일을 전송하는 경우
      Tool.deleteFile(upDir, blogVO_old.getFile1());
      Tool.deleteFile(upDir, blogVO_old.getThumb());
      
      file1 = Upload.saveFileSpring(file1MF, upDir);
      // msgs.add("[파일 전송]");
      // msgs.add("'" + file1 + "' 전송됨");

      if (Tool.isImage(file1)) {
        thumb = Tool.preview(upDir, file1, 120, 80); // Thumb 이미지 생성
        // msgs.add("'" + thumb + "' Thumb 이미지 생성됨");
      }
    } else { // 글만 수정하는 경우
      file1 = blogVO_old.getFile1();
      size1 = blogVO_old.getSize1();
      thumb = blogVO_old.getThumb();
    }
    
    blogVO.setFile1(file1);
    blogVO.setSize1(size1);
    blogVO.setThumb(thumb);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------

    if (blogProc.update(blogVO) == 1) {
      // msgs.add("[등록 성공]");
      // msgs.add("글을 등록했습니다.");

      mav.setViewName("redirect:/blog/list_by_categoryno.do?categoryno="
          + blogVO.getCategoryno() + "&nowPage="+nowPage + "&word_find="+word_find);
    } else {
      msgs.add("[수정 실패]");
      msgs.add("글 수정에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 전산 운영팀: 000-0000-0000");
      links
          .add("<button type='button' onclick=\"history.back()\">다시 시도</button>");

      links
          .add("<button type='button' onclick=\"location.href='./list_by_categoryno.do?categoryno="
              + blogVO.getCategoryno() + "&nowPage="+nowPage + "&word_find="+word_find + "'\">목록</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }

    return mav;
  }

  // http://localhost:9090/blog/blog/delete.do
  @RequestMapping(value = "/blog/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int categoryno, int blogno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/delete"); // /webapp/blog/delete.jsp

    BlogVO blogVO = blogProc.read(blogno);
    mav.addObject("blogVO", blogVO);

    CategoryVO categoryVO = categoryProc.read(categoryno);
    mav.addObject("categoryVO", categoryVO);

    return mav;
  }
  
  @RequestMapping(value = "/blog/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(HttpServletRequest request, 
                                           int categoryno, 
                                           int blogno,
                                           int nowPage,
                                           String word_find) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/message"); // /webapp/blog/message.jsp

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    String upDir = Tool.getRealPath(request, "/blog/storage");

    BlogVO blogVO = blogProc.read(blogno); // 삭제할 파일 정보를 읽기 위한 목적
    
    Tool.deleteFile(upDir, blogVO.getFile1());  // 파일 삭제
    Tool.deleteFile(upDir, blogVO.getThumb()); // 파일 삭제
      
    if (blogProc.delete(blogno) == 1) {
      categoryProc.decreaseCnt(categoryno); // 등록된 글수의 감소
      
      // 4개의 레코드가 하나의 페이지인경우 5번째 레코드가 삭제되면 페이지수도
      // 2페이지에서 1 페이지로 줄여야합니다. 
      HashMap<String, Object> hashMap = new HashMap<String, Object>();
      hashMap.put("categoryno", categoryno); // #{categoryno}
      hashMap.put("word_find", word_find);                  // #{word}
      if (blogProc.search_count(hashMap) % Blog.RECORD_PER_PAGE == 0){ 
        nowPage = nowPage - 1;
        if (nowPage < 1){
          nowPage = 1;
        }
      }
      
      // msgs.add("[등록 성공]");
      // msgs.add("글을 등록했습니다.");

      mav.setViewName("redirect:/blog/list_by_categoryno.do?categoryno=" + categoryno + "&nowPage="+nowPage + "&word_find="+word_find);
    } else {
      msgs.add("[삭제 실패]");
      msgs.add("글 삭제에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 전산 운영팀: 000-0000-0000");
      links
          .add("<button type='button' onclick=\"history.back()\">다시 시도</button>");

      links
          .add("<button type='button' onclick=\"location.href='./list_by_categoryno.do?categoryno="
              + blogVO.getCategoryno() + "&nowPage="+nowPage + "&word_find="+word_find+"'\">목록</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }

    return mav;
  }
  
  /**
   * 검색하여 목록을 가져옵니다.
   * @param categoryno 분류할 카테고리
   * @param word 검색어
   * @return 검색된 레코드
   */
/*  @RequestMapping(value = "/blog/list_by_categoryno.do", 
                             method = RequestMethod.GET)
  public ModelAndView list_by_categoryno(int categoryno, String word) {
    ModelAndView mav = new ModelAndView();
    // mav.setViewName("/blog/list_by_categoryno"); // webapp/blog/list_by_categoryno.jsp
    
    // 검색 기능 추가
    mav.setViewName("/blog/list_by_categoryno2");   // webapp/blog/list_by_categoryno2.jsp
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("categoryno", categoryno); // #{categoryno}
    hashMap.put("word", word);                  // #{word}
    
    // 검색 목록
    List<BlogVO> list = blogProc.list_by_categoryno(hashMap);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = blogProc.search_count(hashMap);
    mav.addObject("search_count", search_count);

    CategoryVO categoryVO = categoryProc.read(categoryno);
    mav.addObject("categoryVO", categoryVO);
    
    // mav.addObject("word", word);
    
    return mav;
  }
  */
  
  /**
   * 목록 + 검색 + 페이징 지원
   * @param categoryno
   * @param word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/blog/list_by_categoryno.do", method = RequestMethod.GET)
  public ModelAndView list_by_categoryno(
      @RequestParam(value="categoryno") int categoryno,
      @RequestParam(value="word_find", defaultValue="") String word_find,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ) { 
    System.out.println("--> list_by_categoryno() GET called.");
    System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();
    // mav.setViewName("/blog/list_by_categoryno"); // webapp/blog/list_by_categoryno.jsp
    
    // 검색 기능 추가
    mav.setViewName("/blog/list_by_categoryno4");   // webapp/blog/list_by_categoryno4.jsp
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("categoryno", categoryno); // #{categoryno}
    hashMap.put("word_find", word_find);                  // #{word}
    hashMap.put("nowPage", nowPage);       
    
    // 검색 목록
    List<BlogVO> list = blogProc.list_by_categoryno(hashMap);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = blogProc.search_count(hashMap);
    mav.addObject("search_count", search_count);

    CategoryVO categoryVO = categoryProc.read(categoryno);
    mav.addObject("categoryVO", categoryVO);
    
    // mav.addObject("word", word);

    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param categoryno 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */ 
    String paging = blogProc.paging(categoryno, search_count, nowPage, word_find);
    mav.addObject("paging", paging);

    mav.addObject("nowPage", nowPage);
    
    return mav;
  }

  @RequestMapping(value="/blog/reply.do", method=RequestMethod.GET)
  public ModelAndView reply(BlogVO blogVO){
    // System.out.println("--> reply() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/reply"); // webapp/blog/reply.jsp
    
    CategoryVO categoryVO = categoryProc.read(blogVO.getCategoryno());
    mav.addObject("categoryVO", categoryVO);  // FK column
    
    mav.addObject("blogVO", blogVO);
    
    return mav;
  }
  
  @RequestMapping(value="/blog/reply.do", method=RequestMethod.POST)
  public ModelAndView reply(HttpServletRequest request, 
                                         BlogVO blogVO,
                                         int nowPage,
                                         String word_find){
    // System.out.println("--> create() POST called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/message"); // webapp/blog/message.jsp
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    int categoryno = blogVO.getCategoryno();
    // ---------------------------------------------------------------------------
    // 파일 전송
    // ---------------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/blog/storage");
    /*
    <input type="file" class="form-control input-lg" name='file1MF' id='file1MF' size='40' >
    ↓
     name='file1MF'에 해당하는 필드를 찾아서 File 객체를 자동으로 할당
    ↓
    BlogVO.java: private MultipartFile file1MF;
    ↓
     파일 객체 사용: MultipartFile file1MF = blogVO.getFile1MF();          
     */
    MultipartFile file1MF = blogVO.getFile1MF();
    String file1 = "";
    long size1 = file1MF.getSize();
    String thumb = "";
    
    if (size1 > 0) {
      file1 = Upload.saveFileSpring(file1MF, upDir);
      
      if (Tool.isImage(file1)) {
        thumb = Tool.preview(upDir, file1, 120, 80); // Thumb 이미지 생성
      } 
    }
    blogVO.setFile1(file1);
    blogVO.setSize1(size1);
    blogVO.setThumb(thumb);
    // ---------------------------------------------------------------------------
    
    // 회원 개발 후 session 으로변경
    // int mno = (Integer)session.getAttribute("mno");
    blogVO.setMno(1);
    
    String root = request.getContextPath();
    
    // --------------------------- 답변 관련 코드 시작 --------------------------
    BlogVO parentVO = blogProc.read(blogVO.getBlogno()); // 부모글 정보 추출
    
    blogVO.setGrpno(parentVO.getGrpno());     // 그룹 번호
    blogVO.setAnsnum(parentVO.getAnsnum()); // 답변 순서

    blogProc.updateAnsnum(blogVO); // 현재 등록된 답변 뒤로 +1 처리함.

    blogVO.setIndent(parentVO.getIndent() + 1); // 답변 차수 증가
    blogVO.setAnsnum(parentVO.getAnsnum() + 1); // 부모 바로 아래 등록
    // --------------------------- 답변 관련 코드 종료 --------------------------
    
    if (blogProc.reply(blogVO) == 1) {
      
      categoryProc.increaseCnt(categoryno); // 글 수 증가
      
      // msgs.add("답변을 등록했습니다.");
      mav.setViewName("redirect:/blog/list_by_categoryno.do?categoryno=" + categoryno + "&nowPage="+nowPage + "&word_find="+word_find);
    } else {
      msgs.add("답변 등록에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back()\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list_by_categoryno.do?categoryno="+categoryno+"&nowPage="+nowPage+"&word_find="+word_find+"'\">목록</button>");
      links.add("<button type='button' onclick=\"location.href='"+root+"/home.do'\">홈페이지</button>");
      
      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }
    
    return mav;
  }
 
  
}



