package dev.mvc.categrp;

import java.util.List;

public interface CategrpDAOInter {
  /**
   * <Xmp>
   *   ī�װ� �׷� ���
   *   <insert id="create" parameterType="CategrpVO">
   * </Xmp>
   * @param categrpVO
   * @return ó���� ���ڵ� ����
   */
  public int create(CategrpVO categrpVO);
  
  /**
   * <Xmp>
   *   ���
   *   <select id="list" resultType="CategrpVO">
   * </Xmp>
   * @return
   */
  public List<CategrpVO> list();  
  
  /**
   * <Xmp>
   * ��ȸ
   * <select id="read" resultType="CategrpVO" parameterType="int"> 
   * </Xmp>
   * @param categrpno ��ȸ�� ���ڵ� ��ȣ
   * @return ��ȸ�� ��ü
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






