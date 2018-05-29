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
      String size1Label = Tool.unit(size1); // ���� ���� ���ڿ� ��ȯ ��) KB, MB, GB
      blogVO.setSize1Label(size1Label);
    }
    
    String title = blogVO.getTitle();
    title = Tool.convertChar(title); // HTML ��� ����, Ư�� ���� ��ȯ
    blogVO.setTitle(title);
    
    // String content = blogVO.getContent();
    // content = Tool.convertChar(content); // HTML ��� ����, Ư�� ���� ��ȯ
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
     ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
     1 ������: nowPage = 1, (1 - 1) * 10 --> 0 
     2 ������: nowPage = 2, (2 - 1) * 10 --> 10
     3 ������: nowPage = 3, (3 - 1) * 10 --> 20
     */
    int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Blog.RECORD_PER_PAGE;
    
     // ���� rownum, 1 ������: 1 / 2 ������: 11 / 3 ������: 21 
    int startNum = beginOfPage + 1; 
    //  ���� rownum, 1 ������: 10 / 2 ������: 20 / 3 ������: 30
    int endNum = beginOfPage + Blog.RECORD_PER_PAGE;   
    /*
     1 ������: WHERE r >= 1 AND r <= 10
     2 ������: WHERE r >= 11 AND r <= 20
     3 ������: WHERE r >= 21 AND r <= 30
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
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param categoryno ī�װ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage     ���� ������
   * @param word_find �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  public String paging(int categoryno, int search_count, int nowPage, String word_find){ 
    int totalPage = (int)(Math.ceil((double)search_count/Blog.RECORD_PER_PAGE)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/Blog.PAGE_PER_BLOCK));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/Blog.PAGE_PER_BLOCK));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * Blog.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * Blog.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
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
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("���� ������: " + nowPage + " / " + totalPage + "  "); 

    int _nowPage = (nowGrp-1) * Blog.PAGE_PER_BLOCK; // ���� �������� �̵� 
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./list_by_categoryno.do?&word_find="+word_find+"&nowPage="+_nowPage+"&categoryno="+categoryno+"'>����</A></span>"); 
    } 

    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // ���� ������, ���� 
      }else{
        // ���� �������� �ƴ� ������
        str.append("<span class='span_box_1'><A href='./list_by_categoryno.do?word_find="+word_find+"&nowPage="+i+"&categoryno="+categoryno+"'>"+i+"</A></span>");   
      } 
    } 
     
    _nowPage = (nowGrp * Blog.PAGE_PER_BLOCK)+1; // 10�� ���� �������� �̵� 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./list_by_categoryno.do?&word_find="+word_find+"&nowPage="+_nowPage+"&categoryno="+categoryno+"'>����</A></span>"); 
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
 
 
 