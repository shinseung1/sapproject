package dev.mvc.category;

import java.util.List;

public interface CategoryProcInter {
  // <insert id="create" parameterType="CategoryVO">
  public int create(CategoryVO categoryVO);
  
  // <select id="list" resultType="Categrp_CategoryVO">
  public List<Categrp_CategoryVO> list();
  
  /**
   * 한건의 레코드 조회
   * <select id="read" resultType="CategoryVO" parameterType="int"> 
   * @param categrpno
   * @return
   */
  public CategoryVO read(int categoryno);
  
  /**
   * 레코드를 수정합니다.
   * <update id="update" parameterType="CategoryVO"> 
   * @param vo
   * @return
   */
  public int update(CategoryVO categoryVO ); 
  
  /**
   * 한건의 레코드 삭제
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
   * 글 수 증가
   * <update id="increaseCnt" parameterType="int"> 
   * @param categoryno
   * @return
   */
  public int increaseCnt(int categoryno);
  
  /**
   * 글 수 감소
   * <update id="decreaseCnt" parameterType="int"> 
   * @param categoryno
   * @return
   */
  public int decreaseCnt(int categoryno);
 
}
 
