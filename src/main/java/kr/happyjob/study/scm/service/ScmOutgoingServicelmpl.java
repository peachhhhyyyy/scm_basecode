package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.ScmOutgoingListDao;
import kr.happyjob.study.scm.model.ScmOutgoingListModel;

@Service
public class ScmOutgoingServicelmpl implements ScmOutgoingService{

	@Autowired
	ScmOutgoingListDao solDao;
	//반품지시서 조회
	@Override
	public List<ScmOutgoingListModel> getOutgoingList(Map<String, Object> paramMap) throws Exception {
		return solDao.getOutgoingList(paramMap);
	}
	//반품지시서 카운트조회
	@Override
	public int scmOutgoingListCnt(Map<String, Object> paramMap) throws Exception {
		return solDao.scmOutgoingListCnt(paramMap);
		
	}

}
