package sap.grp.proj;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("sap.grp.proj.StartloginProc")
public class StartloginProc implements StartloginProcInter {

	@Autowired
	@Qualifier("sap.grp.proj.StartloginDAO")
	private StartloginDAOInter startDAOInter;
	
	@Override
	public int checkId(String id) {
		int count = startDAOInter.checkId(id);
		return count;
	}

}
