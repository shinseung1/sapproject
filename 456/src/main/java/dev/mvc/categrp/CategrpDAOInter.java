package dev.mvc.categrp;

import java.util.List;

public interface CategrpDAOInter {
  /**
   * <Xmp>
   *   카테고리 그룹 등록
   *   <insert id="create" parameterType="CategrpVO">
   * </Xmp>
   * @param categrpVO
   * @return 처리된 레코드 갯수
   */
  public int create(CategrpVO categrpVO);
  
  /**
   * <Xmp>
   *   목록
   *   <select id="list" resultType="CategrpVO">
   * </Xmp>
   * @return
   */
  public List<CategrpVO> list();  
  
  /**
   * <Xmp>
   * 조회
   * <select id="read" resultType="CategrpVO" parameterType="int"> 
   * </Xmp>
   * @param categrpno 조회할 레코드 번호
   * @return 조회된 객체
   */
  public CategrpVO read(int categrpno);
  
  // <update id="update" parameterType="CategrpVO">
  public int update(CategrpVO categrpVO);
  
  // <delete id="delete" parameterType="int">
  public int delete(int categrpno);
  
  // <update id="update_seqno_up" parameterType="int">
  public int update_seqno_up(int categrpno);
  
  // <update id="update_seqno_down" parameterType="int">
  public int update_seqno_down(int categrpno);
  
  
}






