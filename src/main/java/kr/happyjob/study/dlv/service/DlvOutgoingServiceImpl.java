package kr.happyjob.study.dlv.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import kr.happyjob.study.dlv.dao.OutgoingDao;
import kr.happyjob.study.dlv.model.DlvOutgoingModel;

public class DlvOutgoingServiceImpl  implements DlvOutgoingService{

	@Autowired
	OutgoingDao outgoingDao;
	
	@Override
	public List<DlvOutgoingModel> orderList(Map<String, Object> paramMap) throws Exception {
		return outgoingDao.orderList(paramMap);
	}

	@Override
	public int outgoingCnt(Map<String, Object> paramMap) throws Exception {
		return 0;
	}

}
