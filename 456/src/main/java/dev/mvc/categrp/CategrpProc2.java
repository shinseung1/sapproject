package dev.mvc.categrp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.categrp.CategrpProc2")
public class CategrpProc2 implements CategrpProcInter {
  @Autowired
  @Qualifier("dev.mvc.categrp.CategrpDAO")
  private CategrpDAOInter categrpDAO = null;
  
  public CategrpProc2() {
    System.out.println("--> CategrpProc2 created.");
    
    if (categrpDAO != null) {
      System.out.println("--> categrpDAO วาด็ตส");
    }
  }

  @Override
  public int create(CategrpVO categrpVO) {
    int count = categrpDAO.create(categrpVO);
    return count;
  }

  @Override
  public List<CategrpVO> list() {
    System.out.println("CategrpProc2 list() called.");
    List<CategrpVO> list = categrpDAO.list();
    
    return list;
  }

  @Override
  public CategrpVO read(int categrpno) {
    CategrpVO categrpVO = categrpDAO.read(categrpno);
    
    return categrpVO;
  }

  @Override
  public int update(CategrpVO categrpVO) {
    int count = categrpDAO.update(categrpVO);
    return count;
  }

  @Override
  public int delete(int categrpno) {
    int count = categrpDAO.delete(categrpno);
    return count;
  }
  
  @Override
  public int update_seqno_up(int categrpno) {
    int count  = categrpDAO.update_seqno_up(categrpno);
    
    return count;
  }

  @Override
  public int update_seqno_down(int categrpno) {
    int count  = categrpDAO.update_seqno_down(categrpno);
    
    return count;
  }

 
}





