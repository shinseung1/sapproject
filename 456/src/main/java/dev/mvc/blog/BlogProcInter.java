package dev.mvc.blog;

import java.util.HashMap;
import java.util.List;

public interface BlogProcInter {
  /**
   * ���
   * <insert id="create" parameterType="BlogVO">
   * @param blogVO
   * @return
   */
  public int create(BlogVO blogVO);

  // <select id="list_all_category" resultType="BlogVO">
  public List<BlogVO> list_all_category(); 
  
  /**
   * <select id="list_by_categoryno" resultType="BlogVO" parameterType="int">
   * @param categoryno
   * @return
   */
  public List<BlogVO> list_by_categoryno(int categoryno); 
  
  /**
   * ��ü ���ڵ� ����
   * <select id="total_count" resultType="int"> 
   * @return
   */
  public int total_count();  
  
  // <select id="read" resultType="BlogVO" parameterType="int">
  public BlogVO read(int blogno);
  
  // <update id="update" parameterType="BlogVO">
  public int update(BlogVO blogVO);
  
  // <delete id="delete" parameterType="int">
  public int delete(int blogno);
  
  /**
   * <select id="list_by_categoryno" resultType="BlogVO" parameterType="HashMap">
   * @param categoryno
   * @return
   */
  public List<BlogVO> list_by_categoryno(HashMap hashMap);

  /**
   * category�� �˻��� ���ڵ� ����
   * <select id="search_count" resultType="int" parameterType="BlogVO">
   * @return
   */
  public int search_count(HashMap hashMap);  
  
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
  public String paging(int categoryno, int search_count, int nowPage, String word_find); 
  
  /**
   * �ű� �亯�� �ֿ켱���� ����ϱ����� �亯 ���� ����
   * @param blogVO
   * @return
   */
  public int updateAnsnum(BlogVO blogVO);
  
  /**
   * �亯
   * @param blogVO
   * @return
   */
  public int reply(BlogVO blogVO);
  
}
 



