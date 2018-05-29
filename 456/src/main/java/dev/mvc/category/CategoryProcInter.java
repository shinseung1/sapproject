package dev.mvc.category;

import java.util.List;

public interface CategoryProcInter {
  // <insert id="create" parameterType="CategoryVO">
  public int create(CategoryVO categoryVO);
  
  // <select id="list" resultType="Categrp_CategoryVO">
  public List<Categrp_CategoryVO> list();
  
  /**
   * �Ѱ��� ���ڵ� ��ȸ
   * <select id="read" resultType="CategoryVO" parameterType="int"> 
   * @param categrpno
   * @return
   */
  public CategoryVO read(int categoryno);
  
  /**
   * ���ڵ带 �����մϴ�.
   * <update id="update" parameterType="CategoryVO"> 
   * @param vo
   * @return
   */
  public int update(CategoryVO categoryVO ); 
  
  /**
   * �Ѱ��� ���ڵ� ����
   * <delete id="delete" parameterType="int"> 
   * @param categoryno
   * @return
   */
  public int delete(int categoryno);
  
  // <update id="update_seqno_up" parameterType="int">
  public int update_seqno_up(int categoryno);
  
  // <update id="update_seqno_down" parameterType="int">
  public int update_seqno_down(int categoryno);
  
  // <select id="countByCategrpno" resultType="int" parameterType="int">
  public int countByCategrpno(int categrpno);
  
  // <delete id="deleteByCategrpno" parameterType="int">
  public int deleteByCategrpno(int categrpno);
  
  /**
   * �� �� ����
   * <update id="increaseCnt" parameterType="int"> 
   * @param categoryno
   * @return
   */
  public int increaseCnt(int categoryno);
  
  /**
   * �� �� ����
   * <update id="decreaseCnt" parameterType="int"> 
   * @param categoryno
   * @return
   */
  public int decreaseCnt(int categoryno);
 
}
 
