package kr.happyjob.study.dlv.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import kr.happyjob.study.dlv.dao.ReturnDao;
import kr.happyjob.study.dlv.model.DivReturnModel;

public class DlvReturnServiceImpl implements DivReturnService {

	
	private Logger logger = LogManager.getLogger(this.getClass());
	@Autowired
	ReturnDao returnDao;
	
	@Override
	public List<DivReturnModel> returnList(Map<String, Object> paramMap) throws Exception {
		logger.info("@@이것은service returnList에 왔다는 것이다, paramMap값: "+paramMap);
		return returnDao.returnList(paramMap);
	}

	@Override
	public int returnListCnt(Map<String, Object> paramMap) throws Exception {
		logger.info("@@이것은 service returnListCnt에 왔다는 것이다, paramMap값: "+paramMap);
		return 0;
	}

}
