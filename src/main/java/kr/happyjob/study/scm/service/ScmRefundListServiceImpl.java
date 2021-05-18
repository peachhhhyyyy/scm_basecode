package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.ScmRefundListDao;
import kr.happyjob.study.scm.model.ScmRefundListModel;

@Service
public class ScmRefundListServiceImpl implements ScmRefundListService {

	@Autowired
	ScmRefundListDao scmRefundListDao;

	@Override
	public List<ScmRefundListModel> getRefundList(Map<String, Object> paramMap) throws Exception {
		return scmRefundListDao.selectRefundList(paramMap);
	}

	@Override
	public int getRefundListCnt(Map<String, Object> paramMap) throws Exception {
		return scmRefundListDao.selectRefundListCnt(paramMap);
	}
	
	@Override
	public ScmRefundListModel getRefundDetail(Map<String, Object> paramMap) throws Exception {
		return scmRefundListDao.selectRefundDetail(paramMap);
	}
	
	@Override
	public String getScmManagerName(Map<String, Object> paramMap) throws Exception {
		return scmRefundListDao.selectScmManagerName(paramMap);
	}
}
