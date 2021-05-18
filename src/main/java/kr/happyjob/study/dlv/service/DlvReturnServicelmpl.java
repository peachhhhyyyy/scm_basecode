package kr.happyjob.study.dlv.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.dlv.dao.ReturnDao;
import kr.happyjob.study.dlv.model.DlvReturnDetailModel;
import kr.happyjob.study.dlv.model.DlvReturnModel;
import kr.happyjob.study.dlv.model.DlvStaffNameModel;

@Service
public class DlvReturnServicelmpl implements DlvReturnService {

	
	@Autowired
	ReturnDao returndao;
	
	@Override
	public List<DlvReturnModel> returnList(Map<String, Object> paramMap) throws Exception {
		List<DlvReturnModel> returnList = returndao.returnList(paramMap);
		return returnList;
	}

	@Override
	public int returnlistCnt(Map<String, Object> paramMap) throws Exception {
		int totalCount = returndao.returnListCnt(paramMap);
		return totalCount;
	}
	
	@Override
	public List<DlvReturnModel> returnSearchList(Map<String, Object> paramMap) throws Exception {
		return returndao.returnSearchList(paramMap);
	}
	
	@Override
	public int returnSearchCnt(Map<String, Object> paramMap) throws Exception {
		return returndao.returnSearchCnt(paramMap);
	}

	@Override
	public List<DlvReturnDetailModel> returnDetailList(Map<String, Object> paramMap) throws Exception {
		List<DlvReturnDetailModel> returnDetailList = returndao.returnDetailList(paramMap);
		return returnDetailList;
	}

	@Override
	public int returnDetailInfo(Map<String, Object> paramMap) throws Exception {
		int returnDetailInfo = returndao.returnDetailInfo(paramMap);
		return returnDetailInfo;
	}

	@Override
	public List<DlvStaffNameModel> dlvStaffNameCombo(Map<String, Object> paramMap) throws Exception {
		return returndao.dlvStaffNameCombo(paramMap);
	}

	@Override
	public String getDlvStaffTel(Map<String, Object> paramMap) throws Exception {
		return returndao.getDlvStaffTel(paramMap); 
	}

	@Override
	public int updateReturnPaper(Map<String, Object> paramMap) throws Exception {
		return returndao.updateReturnPaper(paramMap);
	}

}
