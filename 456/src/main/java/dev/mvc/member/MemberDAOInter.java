package dev.mvc.member;

import java.util.List;
import java.util.Map;

public interface MemberDAOInter {
	public int checkid(String id);
	/**
	   회원 등록
	   <pre>
	   <insert id="create" parameterType="MemberVO">
	   MySQL insert SQL 실행
	   </pre>
	   @param memberVO
	   @return 등록된 회원수 1 or 0
	   */
	  public int create(MemberVO memberVO);   
	  public List<MemberVO> list();
	  public MemberVO read(int mno);
	  public MemberVO readById(String id);
	  public int update(MemberVO memberVO);
	  /**
	   * 패스워드 변경
	   * <update id="passwd_update" parameterType="MemberVO"> 
	   * @param memberVO
	   * @return
	   */
	  public int passwd_update(MemberVO memberVO);
	  public int delete (int mno);
	  /**
	   * 로그인 
	   * <select id="login"  resultType="int"  parameterType="Map">
	   * @param map
	   * @return
	   */
	  public int login(Map<String, Object> map);
	  /**
	   * 패스워드 체크 <select id="passwd_check" resultType="int" parameterType="HashMap">
	   * 
	   * @param memberVO
	   * @return
	   */
	  public int passwd_check(Map<String, Object> map);
	 
	  /**
	   * 패스워드 변경 
	   * <update id="passwd_update" parameterType="Map">
	   * 
	   * @param map
	   * @return
	   */
	  public int passwd_update(Map<String, Object> map);
}
 