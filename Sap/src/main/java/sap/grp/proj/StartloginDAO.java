package sap.grp.proj;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
 
@Repository("sap.grp.proj.StartloginDAO")
public class StartloginDAO implements StartloginDAOInter {
 
  @Autowired
  private SqlSessionTemplate mybatis;

@Override
public int checkId(String id) {
	int cnt = mybatis.selectOne(id);
	return cnt;
}

}
 