package dev.mvc.categrp;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.categrp.CategrpDAO")
public class CategrpDAO implements CategrpDAOInter {
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public CategrpDAO() {
    System.out.println("--> CategrpDAO created.");
    
    if (sqlSessionTemplate != null) {
      System.out.println("--> sqlSessionTemplate 할당됨");
    }
    
  }

  @Override
  public int create(CategrpVO categrpVO) {
    // namespace.태그 ID
    int count = sqlSessionTemplate.insert("categrp.create", categrpVO);
    return count;
  }

  @Override
  public List<CategrpVO> list() {
    List<CategrpVO> list = sqlSessionTemplate.selectList("categrp.list");
    
/*    if (list instanceof List) {
      System.out.println("--> List 타입입니다.");
    }
    
    if (list instanceof ArrayList) {
      System.out.println("--> ArrayList 타입입니다.");
    }
    
    if (list instanceof Vector) {
      System.out.println("--> Vector 타입입니다.");
    }*/
    
    return list;
  }

  @Override
  public CategrpVO read(int categrpno) {
    CategrpVO categrpVO = sqlSessionTemplate.selectOne("categrp.read", categrpno);
    
    return categrpVO;
  }

  /**
   * 수정 처리
   */
  @Override
  public int update(CategrpVO categrpVO) {
    // namespace.태그 ID
    int count = sqlSessionTemplate.update("categrp.update", categrpVO);
    return count;
  }

  @Override
  public int delete(int categrpno) {
    int count = sqlSessionTemplate.delete("categrp.delete", categrpno);
    return count;
  }
  
  @Override
  public int update_seqno_up(int categrpno) {
    int count = sqlSessionTemplate.update("categrp.update_seqno_up", categrpno);
    return count;
  }

  @Override
  public int update_seqno_down(int categrpno) {
    int count = sqlSessionTemplate.update("categrp.update_seqno_down", categrpno);
    return count;
  }
 
  
}



