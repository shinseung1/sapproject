package dev.mvc.category;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.category.CategoryDAO")
public class CategoryDAO implements CategoryDAOInter {
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate;
  
  public CategoryDAO() {
    System.out.println("--> CategoryDAO created.");
  }

  @Override
  public int create(CategoryVO categoryVO) {
    // namespace.еб╠в ID
    int count = sqlSessionTemplate.insert("category.create", categoryVO);
    return count;
  }

  @Override
  public List<Categrp_CategoryVO> list() {
    List<Categrp_CategoryVO> list = sqlSessionTemplate.selectList("category.list");
    
    return list;
  }
  
  @Override
  public CategoryVO read(int categoryno) {
    return sqlSessionTemplate.selectOne("category.read", categoryno);
  }

  @Override
  public int update(CategoryVO categoryVO ) {
    return sqlSessionTemplate.update("category.update", categoryVO );
  }
  
  @Override
  public int delete(int categoryno) {
    return sqlSessionTemplate.delete("category.delete", categoryno);
  }
  
  @Override
  public int update_seqno_up(int categoryno) {
    int count = sqlSessionTemplate.update("category.update_seqno_up", categoryno);
    return count;
  }

  @Override
  public int update_seqno_down(int categoryno) {
    int count = sqlSessionTemplate.update("category.update_seqno_down", categoryno);
    return count;
  }

  @Override
  public int countByCategrpno(int categrpno) {
    int count = sqlSessionTemplate.selectOne("category.countByCategrpno", categrpno);
    return count;
  }

  @Override
  public int deleteByCategrpno(int categrpno) {
    int count = sqlSessionTemplate.delete("category.deleteByCategrpno", categrpno);
    return count;
  }
  
  @Override
  public int increaseCnt(int categoryno) {
    return sqlSessionTemplate.update("category.increaseCnt", categoryno);
  }
  
  @Override
  public int decreaseCnt(int categoryno) {
    return sqlSessionTemplate.update("category.decreaseCnt", categoryno);
  }
  
}





