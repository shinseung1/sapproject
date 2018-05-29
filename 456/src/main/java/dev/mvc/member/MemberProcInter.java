package dev.mvc.member;

import java.util.List;
import java.util.Map;

public interface MemberProcInter {
 public int checkid(String id);
 public int create(MemberVO memberVO); 
 public List<MemberVO> list();
 public MemberVO read(int mno);
 public MemberVO readById(String id);
/**
 * 변경
 * <update id="update" parameterType="MemberVO">
 * @param memberVO
 * @return
 */
public int update(MemberVO memberVO);
/**
 * 패스워드 변경
 * <update id="passwd_update" parameterType="MemberVO"> 
 * @param memberVO
 * @return
 */
public int passwd_update(MemberVO memberVO);
/**
 * 레코드 1건 삭제
 * <delete id="delete" parameterType="int">
 * @param mno 삭제할 회원 번호
 * @return 삭제된 레코드 갯수
 */
public int delete(int mno);

int login(String id, String passwd);

public int passwd_update(int mno , String passwd);
public int passwd_check(int mno , String passwd);
}