package dev.mvc.member;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
 
@Repository("dev.mvc.member.MemberDAO")
public class MemberDAO implements MemberDAOInter {
 
  @Autowired
  private SqlSessionTemplate mybatis;
 
  public MemberDAO() {
    System.out.println("--> MemberDAO created.");
  }  
  
  public int checkid(String id) {
	 int result = mybatis.selectOne("member.checkid",id);
	 return result;
	  
  }
  /**
   * 회원 등록
   * <insert id="create" parameterType="MemberVO">
   * @param memberVO
   * @return 등록된 회원수 1 or 0
   */
  @Override
  public int create(MemberVO memberVO) {
    int count = mybatis.insert("member.create", memberVO);
    return count;
  }  
  
  public List<MemberVO> list(){
	  List<MemberVO> list = mybatis.selectList("member.list");
  return list;
  }
  
  @Override
  public MemberVO read(int mno) {
	MemberVO memberVO = mybatis.selectOne("member.read");
	return memberVO;
	  
  }
  public MemberVO readById(String id) {
	  MemberVO memberVO = mybatis.selectOne("member.read");
	  return memberVO;
  }
  @Override
  public int update(MemberVO memberVO) {
    int count = mybatis.update("member.update", memberVO);
    return count;
  }  
  @Override
  public int passwd_update(MemberVO memberVO) {
    int count = mybatis.update("member.passwd_update", memberVO);
    return count;
  }  
  public int passwd_check(MemberVO memberVO) {
	  int count = mybatis.update("member.passwd_check",memberVO);
	  return count;
  }
  
  public int delete(int mno) {
	  int count = mybatis.delete("member.delete", mno);
	    return count;
  }
  @Override
  public int login(Map<String, Object> map) {
    int count = mybatis.selectOne("member.login", map);
    return count;
  }

  public int passwd_check(Map <String , Object> map) {
	  int cnt = mybatis.selectOne("member.passwd_check" , map);
	  return cnt;
	  
  }
  public int passwd_update(Map<String,Object> map) {
	  int cnt =  mybatis.selectOne("member.passwd_update " , map);
	  return cnt;
  
  }

}
 