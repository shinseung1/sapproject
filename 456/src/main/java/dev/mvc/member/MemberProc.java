package dev.mvc.member;
 
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
 
@Component("dev.mvc.member.MemberProc")
public class MemberProc implements MemberProcInter {

	@Autowired
	@Qualifier("dev.mvc.member.MemberDAO")
	private MemberDAO memberDAO ;
	
	public MemberProc() {}
	
	@Override
	public int checkid(String id) {
		int result = memberDAO.checkid(id);
		return result;
	}
	@Override
	  public int create(MemberVO memberVO) {
	    int count = memberDAO.create(memberVO);
	    return count;
	  }
	
	public List<MemberVO> list(){
		List<MemberVO> list = memberDAO.list();
		return list;
	}
	
	public MemberVO read(int mno) {
		MemberVO memberVO = memberDAO.read(mno);
		return memberVO;
	}
	public MemberVO readById(String id) {
		MemberVO memberVO = memberDAO.readById(id);
		return memberVO;
	}
	 @Override
	  public int update(MemberVO memberVO) {
	    int count = memberDAO.update(memberVO);
	    return count;
	  }
	 @Override
	  public int passwd_update(MemberVO memberVO) {
	    int count = memberDAO.passwd_update(memberVO);
	    
	    return count;
	  }
	 @Override
	  public int delete(int mno) {
	    int count = memberDAO.delete(mno);
	    return count;
	  }
	 @Override
	  public int login(String id, String passwd) {
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("id", id);
	    map.put("passwd", passwd);
	    
	    int count = memberDAO.login(map);
	    
	    return count;
	  }

	@Override
	public int passwd_update(int mno, String passwd) {

		Map <String , Object> map = new HashMap<String, Object>();
		map.put("mno", mno);
		map.put("passwd", passwd);
		
		int cnt = memberDAO.passwd_update(map);
		return cnt;
	
	}

	@Override
	public int passwd_check(int mno, String passwd) {

		Map <String , Object> map = new HashMap<String, Object>();
		map.put("mno", mno);
		map.put("passwd", passwd);
		
		int cnt = memberDAO.passwd_check(map);
		return cnt;
	
	}
	   
	 
}