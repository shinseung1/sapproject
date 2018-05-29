package dev.mvc.blog;

import java.util.HashMap;
import java.util.List;

public interface BlogDAOInter {
  /**
   * ���
   * <xmp>
   * <insert id="create" parameterType="BlogVO">
   * </xmp>
   * @param blogVO
   * @return
   */
  public int create(BlogVO blogVO);
  
  // <select id="list_all_category" resultType="BlogVO">
  public List<BlogVO> list_all_category(); 
  
  /**
   * <xmp>
   * <select id="list_by_categoryno" resultType="BlogVO" parameterType="int">
   * </xmp>
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


