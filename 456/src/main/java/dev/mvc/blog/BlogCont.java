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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/blog/storage");
    MultipartFile file1MF = blogVO.getFile1MF(); // Spring�� File ��ü�� �����ص�.
    String file1 = ""; // �÷��� ������ ���ϸ�
    long size1 = file1MF.getSize();
    String thumb = ""; // �÷��� ������ ���ϸ�

    if (size1 > 0) {
      file1 = Upload.saveFileSpring(file1MF, upDir);
      // msgs.add("[���� ����]");
      // msgs.add("'" + file1 + "' ���۵�");

      if (Tool.isImage(file1)) {
        thumb = Tool.preview(upDir, file1, 120, 80); // Thumb �̹��� ����
        // msgs.add("'" + thumb + "' Thumb �̹��� ������");
      }
    }
    blogVO.setFile1(file1);
    blogVO.setSize1(size1);
    blogVO.setThumb(thumb);
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------

    if (blogProc.create(blogVO) == 1) {
      categoryProc.increaseCnt(blogVO.getCategoryno()); // �ۼ� ����

      // msgs.add("[��� ����]");
      // msgs.add("���� ����߽��ϴ�.");

      mav.setViewName("redirect:/blog/list_by_categoryno.do?categoryno="
          + blogVO.getCategoryno());
    } else {
      msgs.add("[��� ����]");
      msgs.add("�� ��Ͽ� �����߽��ϴ�.");
      msgs.add("�˼������� �ٽ��ѹ� �õ����ּ���. �� ���� ���: 000-0000-0000");
      links
          .add("<button type='button' onclick=\"history.back()\">�ٽ� �õ�</button>");

      links
          .add("<button type='button' onclick=\"location.href='./list_by_categoryno.do?categoryno="
              + blogVO.getCategoryno() + "'\">���</button>");

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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/blog/storage");
    MultipartFile file1MF = blogVO.getFile1MF(); // Spring�� File ��ü�� �����ص�.
    String file1 = ""; // �÷��� ������ ���ϸ�
    long size1 = file1MF.getSize();
    String thumb = ""; // �÷��� ������ ���ϸ�

    BlogVO blogVO_old = blogProc.read(blogVO.getBlogno());
    
    if (size1 > 0) { // ������ �����ϴ� ���
      Tool.deleteFile(upDir, blogVO_old.getFile1());
      Tool.deleteFile(upDir, blogVO_old.getThumb());
      
      file1 = Upload.saveFileSpring(file1MF, upDir);
      // msgs.add("[���� ����]");
      // msgs.add("'" + file1 + "' ���۵�");

      if (Tool.isImage(file1)) {
        thumb = Tool.preview(upDir, file1, 120, 80); // Thumb �̹��� ����
        // msgs.add("'" + thumb + "' Thumb �̹��� ������");
      }
    } else { // �۸� �����ϴ� ���
      file1 = blogVO_old.getFile1();
      size1 = blogVO_old.getSize1();
      thumb = blogVO_old.getThumb();
    }
    
    blogVO.setFile1(file1);
    blogVO.setSize1(size1);
    blogVO.setThumb(thumb);
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------

    if (blogProc.update(blogVO) == 1) {
      // msgs.add("[��� ����]");
      // msgs.add("���� ����߽��ϴ�.");

      mav.setViewName("redirect:/blog/list_by_categoryno.do?categoryno="
          + blogVO.getCategoryno() + "&nowPage="+nowPage + "&word_find="+word_find);
    } else {
      msgs.add("[���� ����]");
      msgs.add("�� ������ �����߽��ϴ�.");
      msgs.add("�˼������� �ٽ��ѹ� �õ����ּ���. �� ���� ���: 000-0000-0000");
      links
          .add("<button type='button' onclick=\"history.back()\">�ٽ� �õ�</button>");

      links
          .add("<button type='button' onclick=\"location.href='./list_by_categoryno.do?categoryno="
              + blogVO.getCategoryno() + "&nowPage="+nowPage + "&word_find="+word_find + "'\">���</button>");

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

    BlogVO blogVO = blogProc.read(blogno); // ������ ���� ������ �б� ���� ����
    
    Tool.deleteFile(upDir, blogVO.getFile1());  // ���� ����
    Tool.deleteFile(upDir, blogVO.getThumb()); // ���� ����
      
    if (blogProc.delete(blogno) == 1) {
      categoryProc.decreaseCnt(categoryno); // ��ϵ� �ۼ��� ����
      
      // 4���� ���ڵ尡 �ϳ��� �������ΰ�� 5��° ���ڵ尡 �����Ǹ� ����������
      // 2���������� 1 �������� �ٿ����մϴ�. 
      HashMap<String, Object> hashMap = new HashMap<String, Object>();
      hashMap.put("categoryno", categoryno); // #{categoryno}
      hashMap.put("word_find", word_find);                  // #{word}
      if (blogProc.search_count(hashMap) % Blog.RECORD_PER_PAGE == 0){ 
        nowPage = nowPage - 1;
        if (nowPage < 1){
          nowPage = 1;
        }
      }
      
      // msgs.add("[��� ����]");
      // msgs.add("���� ����߽��ϴ�.");

      mav.setViewName("redirect:/blog/list_by_categoryno.do?categoryno=" + categoryno + "&nowPage="+nowPage + "&word_find="+word_find);
    } else {
      msgs.add("[���� ����]");
      msgs.add("�� ������ �����߽��ϴ�.");
      msgs.add("�˼������� �ٽ��ѹ� �õ����ּ���. �� ���� ���: 000-0000-0000");
      links
          .add("<button type='button' onclick=\"history.back()\">�ٽ� �õ�</button>");

      links
          .add("<button type='button' onclick=\"location.href='./list_by_categoryno.do?categoryno="
              + blogVO.getCategoryno() + "&nowPage="+nowPage + "&word_find="+word_find+"'\">���</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }

    return mav;
  }
  
  /**
   * �˻��Ͽ� ����� �����ɴϴ�.
   * @param categoryno �з��� ī�װ�
   * @param word �˻���
   * @return �˻��� ���ڵ�
   */
/*  @RequestMapping(value = "/blog/list_by_categoryno.do", 
                             method = RequestMethod.GET)
  public ModelAndView list_by_categoryno(int categoryno, String word) {
    ModelAndView mav = new ModelAndView();
    // mav.setViewName("/blog/list_by_categoryno"); // webapp/blog/list_by_categoryno.jsp
    
    // �˻� ��� �߰�
    mav.setViewName("/blog/list_by_categoryno2");   // webapp/blog/list_by_categoryno2.jsp
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("categoryno", categoryno); // #{categoryno}
    hashMap.put("word", word);                  // #{word}
    
    // �˻� ���
    List<BlogVO> list = blogProc.list_by_categoryno(hashMap);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = blogProc.search_count(hashMap);
    mav.addObject("search_count", search_count);

    CategoryVO categoryVO = categoryProc.read(categoryno);
    mav.addObject("categoryVO", categoryVO);
    
    // mav.addObject("word", word);
    
    return mav;
  }
  */
  
  /**
   * ��� + �˻� + ����¡ ����
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
    
    // �˻� ��� �߰�
    mav.setViewName("/blog/list_by_categoryno4");   // webapp/blog/list_by_categoryno4.jsp
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("categoryno", categoryno); // #{categoryno}
    hashMap.put("word_find", word_find);                  // #{word}
    hashMap.put("nowPage", nowPage);       
    
    // �˻� ���
    List<BlogVO> list = blogProc.list_by_categoryno(hashMap);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = blogProc.search_count(hashMap);
    mav.addObject("search_count", search_count);

    CategoryVO categoryVO = categoryProc.read(categoryno);
    mav.addObject("categoryVO", categoryVO);
    
    // mav.addObject("word", word);

    /*
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
     * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
     *
     * @param categoryno ī�װ���ȣ 
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param word �˻���
     * @return ����¡ ���� ���ڿ�
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
    // ���� ����
    // ---------------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/blog/storage");
    /*
    <input type="file" class="form-control input-lg" name='file1MF' id='file1MF' size='40' >
    ��
     name='file1MF'�� �ش��ϴ� �ʵ带 ã�Ƽ� File ��ü�� �ڵ����� �Ҵ�
    ��
    BlogVO.java: private MultipartFile file1MF;
    ��
     ���� ��ü ���: MultipartFile file1MF = blogVO.getFile1MF();          
     */
    MultipartFile file1MF = blogVO.getFile1MF();
    String file1 = "";
    long size1 = file1MF.getSize();
    String thumb = "";
    
    if (size1 > 0) {
      file1 = Upload.saveFileSpring(file1MF, upDir);
      
      if (Tool.isImage(file1)) {
        thumb = Tool.preview(upDir, file1, 120, 80); // Thumb �̹��� ����
      } 
    }
    blogVO.setFile1(file1);
    blogVO.setSize1(size1);
    blogVO.setThumb(thumb);
    // ---------------------------------------------------------------------------
    
    // ȸ�� ���� �� session ���κ���
    // int mno = (Integer)session.getAttribute("mno");
    blogVO.setMno(1);
    
    String root = request.getContextPath();
    
    // --------------------------- �亯 ���� �ڵ� ���� --------------------------
    BlogVO parentVO = blogProc.read(blogVO.getBlogno()); // �θ�� ���� ����
    
    blogVO.setGrpno(parentVO.getGrpno());     // �׷� ��ȣ
    blogVO.setAnsnum(parentVO.getAnsnum()); // �亯 ����

    blogProc.updateAnsnum(blogVO); // ���� ��ϵ� �亯 �ڷ� +1 ó����.

    blogVO.setIndent(parentVO.getIndent() + 1); // �亯 ���� ����
    blogVO.setAnsnum(parentVO.getAnsnum() + 1); // �θ� �ٷ� �Ʒ� ���
    // --------------------------- �亯 ���� �ڵ� ���� --------------------------
    
    if (blogProc.reply(blogVO) == 1) {
      
      categoryProc.increaseCnt(categoryno); // �� �� ����
      
      // msgs.add("�亯�� ����߽��ϴ�.");
      mav.setViewName("redirect:/blog/list_by_categoryno.do?categoryno=" + categoryno + "&nowPage="+nowPage + "&word_find="+word_find);
    } else {
      msgs.add("�亯 ��Ͽ� �����߽��ϴ�.");
      msgs.add("�˼������� �ٽ��ѹ� �õ����ּ���. �� 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back()\">�ٽ� �õ�</button>");
      links.add("<button type='button' onclick=\"location.href='./list_by_categoryno.do?categoryno="+categoryno+"&nowPage="+nowPage+"&word_find="+word_find+"'\">���</button>");
      links.add("<button type='button' onclick=\"location.href='"+root+"/home.do'\">Ȩ������</button>");
      
      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }
    
    return mav;
  }
 
  
}



