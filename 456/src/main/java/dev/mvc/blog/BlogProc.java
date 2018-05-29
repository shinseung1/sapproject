package dev.mvc.blog;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import nation.web.tool.Tool;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.blog.BlogProc")
public class BlogProc implements BlogProcInter {
  @Autowired
  @Qualifier("dev.mvc.blog.BlogDAO")
  private BlogDAOInter blogDAO = null;
  
  public BlogProc() {
    System.out.println("--> BlogProc created.");
  }
  
  @Override
  public int create(BlogVO blogVO) {
    int count = 0;
    count = blogDAO.create(blogVO);
    
    return count; 
  }

  @Override
  public List<BlogVO> list_all_category() {
    List<BlogVO> list = blogDAO.list_all_category();
    
    Iterator<BlogVO> iter = list.iterator();
    
    while(iter.hasNext()) {
      BlogVO blogVO = iter.next();
      String title = Tool.textLength(blogVO.getTitle(), 90);
      blogVO.setTitle(title);
    }
    
    return list;
  }
  
  @Override
  public List<BlogVO> list_by_categoryno(int categoryno) {
    List<BlogVO> list = blogDAO.list_by_categoryno(categoryno); 
    Iterator<BlogVO> iter = list.iterator();
    
    while(iter.hasNext() == true) {
      BlogVO blogVO = iter.next();
      String title = Tool.textLength(blogVO.getTitle(), 90);
      blogVO.setTitle(title);
    }
    
    return list;
  }

  @Override
  public int total_count() {
    int count = 0;
    count = blogDAO.total_count();
    
    return count; 
  }

  @Override
  public BlogVO read(int blogno) {
    System.out.println("blogno: " + blogno);
    
    BlogVO blogVO = blogDAO.read(blogno);
    
    long size1 = blogVO.getSize1();
    
    if (size1 > 0) {
      String size1Label = Tool.unit(size1); // 파일 단위 문자열 변환 예) KB, MB, GB
      blogVO.setSize1Label(size1Label);
    }
    
    String title = blogVO.getTitle();
    title = Tool.convertChar(title); // HTML 출력 설정, 특수 문자 변환
    blogVO.setTitle(title);
    
    // String content = blogVO.getContent();
    // content = Tool.convertChar(content); // HTML 출력 설정, 특수 문자 변환
    // blogVO.setContent(content);
    
    return blogVO;
  }

  @Override
  public int update(BlogVO blogVO) {
    int count = blogDAO.update(blogVO);
    
    return count;
  }

  @Override
  public int delete(int blogno) {
    int count = blogDAO.delete(blogno);
    return count;
  }
  
/*  @Override
  public List<BlogVO> list_by_categoryno(HashMap hashMap) {
    List<BlogVO> list = blogDAO.list_by_categoryno(hashMap); 
    Iterator<BlogVO> iter = list.iterator();
    
    while(iter.hasNext() == true) {
      BlogVO blogVO = iter.next();
      String title = Tool.textLength(blogVO.getTitle(), 90);
      blogVO.setTitle(title);
    }
    
    return list;
  }*/

  @Override
  public int search_count(HashMap hashMap) {
    int cnt = blogDAO.search_count(hashMap);
    
    return cnt;
  }

  @Override
  public List<BlogVO> list_by_categoryno(HashMap hashMap) {
    /* 
     페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
     1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
     2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
     3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
     */
    int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Blog.RECORD_PER_PAGE;
    
     // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
    int startNum = beginOfPage + 1; 
    //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
    int endNum = beginOfPage + Blog.RECORD_PER_PAGE;   
    /*
     1 페이지: WHERE r >= 1 AND r <= 10
     2 페이지: WHERE r >= 11 AND r <= 20
     3 페이지: WHERE r >= 21 AND r <= 30
     */
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);
    
    
    List<BlogVO> list = blogDAO.list_by_categoryno(hashMap); 
    Iterator<BlogVO> iter = list.iterator();
    
    while(iter.hasNext() == true) {
      BlogVO blogVO = iter.next();
      String title = Tool.textLength(blogVO.getTitle(), 90);
      blogVO.setTitle(title);
    }
    
    return list;
  }
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param categoryno 카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word_find 검색어
   * @return 페이징 생성 문자열
   */ 
  public String paging(int categoryno, int search_count, int nowPage, String word_find){ 
    int totalPage = (int)(Math.ceil((double)search_count/Blog.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Blog.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/Blog.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * Blog.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Blog.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 

    int _nowPage = (nowGrp-1) * Blog.PAGE_PER_BLOCK; // 이전 페이지로 이동 
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./list_by_categoryno.do?&word_find="+word_find+"&nowPage="+_nowPage+"&categoryno="+categoryno+"'>이전</A></span>"); 
    } 

    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
      }else{
        // 현재 페이지가 아닌 페이지
        str.append("<span class='span_box_1'><A href='./list_by_categoryno.do?word_find="+word_find+"&nowPage="+i+"&categoryno="+categoryno+"'>"+i+"</A></span>");   
      } 
    } 
     
    _nowPage = (nowGrp * Blog.PAGE_PER_BLOCK)+1; // 10개 다음 페이지로 이동 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./list_by_categoryno.do?&word_find="+word_find+"&nowPage="+_nowPage+"&categoryno="+categoryno+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  } 

  @Override
  public int updateAnsnum(BlogVO blogVO) {
    int count = 0;
    count = blogDAO.updateAnsnum(blogVO);
    
    return count;
  }

  @Override
  public int reply(BlogVO blogVO) {
    int count = 0;
    count = blogDAO.reply(blogVO);
    
    return count;
  }

}
 
 
 