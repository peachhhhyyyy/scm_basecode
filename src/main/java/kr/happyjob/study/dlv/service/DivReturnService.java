package kr.happyjob.study.dlv.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dlv.model.DivReturnModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;



public interface DivReturnService {
	
	// 반품 리스트 조회
	public List<DivReturnModel> returnList(Map<String, Object> paramMap)throws Exception ;
	
	// 반품 리스트 카운트
	public int returnListCnt(Map<String, Object> paramMap)throws Exception;
	}

