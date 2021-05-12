package kr.happyjob.study.dlv.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.dlv.dao.ReturnDao;
import kr.happyjob.study.dlv.model.DlvReturnDetailModel;
import kr.happyjob.study.dlv.model.DlvReturnModel;

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
	public List<DlvReturnDetailModel> returnDetailList(Map<String, Object> paramMap) throws Exception {
		List<DlvReturnDetailModel> returnDetailList = returndao.returnDetailList(paramMap);
		return returnDetailList;
	}

}
