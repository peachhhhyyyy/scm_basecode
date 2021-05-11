package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.ScmOrderListDao;
import kr.happyjob.study.scm.model.ScmOrderListModel;

@Service
public class ScmOrderListServiceImpl implements ScmOrderListService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	ScmOrderListDao ScmOrderListDao;

	@Override
	public List<ScmOrderListModel> getOrderList(Map<String, Object> paramMap) throws Exception {
		return ScmOrderListDao.selectOrderList(paramMap);
	}
	
	@Override
	public int getOrderListCnt(Map<String, Object> paramMap) throws Exception {
		return ScmOrderListDao.selectOrderListCnt(paramMap);
	}

}
