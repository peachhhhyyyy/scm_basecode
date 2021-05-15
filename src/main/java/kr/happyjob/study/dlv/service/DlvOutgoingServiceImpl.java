package kr.happyjob.study.dlv.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.dlv.dao.OutgoingDao;
import kr.happyjob.study.dlv.model.DlvOutgoingDetailModel;
import kr.happyjob.study.dlv.model.DlvOutgoingModel;
import kr.happyjob.study.dlv.model.DlvStaffNameModel;

@Service
public class DlvOutgoingServiceImpl implements DlvOutgoingService{

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
	public List<DlvOutgoingModel> outgoingSearchList(Map<String, Object> paramMap) throws Exception {
		return outgoingDao.outgoingSearchList(paramMap);
	}
	
	@Override
	public int outgoingSearchCnt(Map<String, Object> paramMap) throws Exception {
		return outgoingDao.outgoingSearchCnt(paramMap);
	}
	@Override
	public List<DlvOutgoingDetailModel> outgoingDetailList(Map<String, Object> paramMap) throws Exception {
		return outgoingDao.outgoingDetailList(paramMap) ;
	}

	@Override
	public List<DlvStaffNameModel> dlvStaffNameCombo(Map<String, Object> paramMap) throws Exception {
		return outgoingDao.dlvStaffNameCombo(paramMap);
	}

	@Override
	public String getDlvStaffTel(Map<String, Object> paramMap) throws Exception {
		return outgoingDao.getDlvStaffTel(paramMap); 
	}

	@Override
	public int updateDlvPaper(Map<String, Object> paramMap) throws Exception {
		return outgoingDao.updateDlvPaper(paramMap);
	}




	
	

}
