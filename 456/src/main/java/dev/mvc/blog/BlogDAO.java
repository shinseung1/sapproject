package dev.mvc.blog;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.blog.BlogDAO")
public class BlogDAO implements BlogDAOInter{
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate;
  
  public BlogDAO() {
    System.out.println("--> BlogDAO created.");
  }
  
  @Override
  public int create(BlogVO blogVO) {
    int count = sqlSessionTemplate.insert("blog.create", blogVO);
    return count;
  }

  @Override
  public List<BlogVO> list_all_category() {
    List<BlogVO> list = sqlSessionTemplate.selectList("blog.list_all_category");
    return list;
  }
  
  @Override
  public List<BlogVO> list_by_categoryno(int categoryno) {
    List<BlogVO> list = null;
    list = sqlSessionTemplate.selectList("blog.list_by_categoryno", categoryno);

    return list;
  }

  @Override
  public int total_count() {
    int count = sqlSessionTemplate.selectOne("blog.total_count");
    return count;
  }

  @Override
  public BlogVO read(int blogno) {
    BlogVO blogVO = sqlSessionTemplate.selectOne("blog.read", blogno);
    return blogVO;
  }

  @Override
  public int update(BlogVO blogVO) {
    int count = sqlSessionTemplate.update("blog.update", blogVO);
    return count;
  }

  @Override
  public int delete(int blogno) {
    int count = sqlSessionTemplate.delete("blog.delete", blogno);
    return count;
  }
  
  @Override
  public List<BlogVO> list_by_categoryno(HashMap hashMap) {
    List<BlogVO> list = null;
    list = sqlSessionTemplate.selectList("blog.list_by_categoryno", hashMap);

    return list;
  }

  @Override
  public int search_count(HashMap hashMap) {
    int cnt = sqlSessionTemplate.selectOne("blog.search_count", hashMap);
    
    return cnt;
  }
  
  @Override
  public int updateAnsnum(BlogVO blogVO) {
    return sqlSessionTemplate.update("blog.updateAnsnum", blogVO); 
  }

  @Override
  public int reply(BlogVO blogVO) {
    return sqlSessionTemplate.insert("blog.reply", blogVO);
  }

}



