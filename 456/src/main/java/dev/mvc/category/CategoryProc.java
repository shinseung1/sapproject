package dev.mvc.category;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.category.CategoryProc")
public class CategoryProc implements CategoryProcInter {
  @Autowired
  @Qualifier("dev.mvc.category.CategoryDAO")
  private CategoryDAOInter categoryDAO = null;
  
  public CategoryProc() {
    System.out.println("--> CategoryProc created.");
  }

  @Override
  public int create(CategoryVO categoryVO) {
    return categoryDAO.create(categoryVO);
  }

  @Override
  public List<Categrp_CategoryVO> list() {
    return categoryDAO.list();
  }
  
  @Override
  public CategoryVO read(int categoryno) {
    return categoryDAO.read(categoryno);
  }

  @Override
  public int update(CategoryVO categoryVO) {
    return categoryDAO.update(categoryVO);
  }
  
  @Override
  public int delete(int categoryno) {
    return categoryDAO.delete(categoryno);
  }
  
  @Override
  public int update_seqno_up(int categoryno) {
    int count  = categoryDAO.update_seqno_up(categoryno);
    
    return count;
  }

  @Override
  public int update_seqno_down(int categoryno) {
    int count  = categoryDAO.update_seqno_down(categoryno);
    
    return count;
  }
  
  @Override
  public int countByCategrpno(int categrpno) {
    int count  = categoryDAO.countByCategrpno(categrpno);
    
    return count;
  }
   
  @Override
  public int deleteByCategrpno(int categrpno) {
    int count  = categoryDAO.deleteByCategrpno(categrpno);
    
    return count;
  }
  
  @Override
  public int increaseCnt(int categoryno) {
    int count = categoryDAO.increaseCnt(categoryno);
    
    return count;
  }
  
  @Override
  public int decreaseCnt(int categoryno) {
    return categoryDAO.decreaseCnt(categoryno);
  }
  
}
 
 
 
 

 