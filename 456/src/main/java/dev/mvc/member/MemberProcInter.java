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
 * ����
 * <update id="update" parameterType="MemberVO">
 * @param memberVO
 * @return
 */
public int update(MemberVO memberVO);
/**
 * �н����� ����
 * <update id="passwd_update" parameterType="MemberVO"> 
 * @param memberVO
 * @return
 */
public int passwd_update(MemberVO memberVO);
/**
 * ���ڵ� 1�� ����
 * <delete id="delete" parameterType="int">
 * @param mno ������ ȸ�� ��ȣ
 * @return ������ ���ڵ� ����
 */
public int delete(int mno);

int login(String id, String passwd);

public int passwd_update(int mno , String passwd);
public int passwd_check(int mno , String passwd);
}