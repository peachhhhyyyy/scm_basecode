package kr.happyjob.study.dlv.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.dlv.dao.OutgoingDao;
import kr.happyjob.study.dlv.model.DlvOutgoingDetailModel;
import kr.happyjob.study.dlv.model.DlvOutgoingModel;

@Service
public class DlvOutgoingServiceImpl  implements DlvOutgoingService{

	@Autowired
	OutgoingDao outgoingDao;
	
	@Override
	public List<DlvOutgoingModel> outgoingList(Map<String, Object> paramMap) throws Exception {
		return outgoingDao.outgoingList(paramMap);
	}

	@Override
	public int outgoingCnt(Map<String, Object> paramMap) throws Exception {
		return outgoingDao.outgoingCnt(paramMap);
	}

	@Override
	public List<DlvOutgoingDetailModel> outgoingDetailList(Map<String, Object> paramMap) throws Exception {
		return outgoingDao.outgoingDetailList(paramMap);
	}
	
	

}
