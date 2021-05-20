package kr.happyjob.study.dlv.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dlv.model.DlvReturnDetailModel;
import kr.happyjob.study.dlv.model.DlvReturnModel;
import kr.happyjob.study.dlv.model.DlvStaffNameModel;

public interface DlvReturnService {
	
	//반품 리스트 조회
	public List<DlvReturnModel> returnList(Map<String, Object> paramMap) throws Exception;
	
	//반품 리스트 카운트 조회
	public int returnlistCnt(Map<String, Object> paramMap) throws Exception;
	
	// 검색 조건 출하내역 조회
	public List<DlvReturnModel>returnSearchList(Map<String, Object> paramMap) throws Exception ;
	
	// 검색 조건 출하내역 건수
	public int returnSearchCnt(Map<String, Object> paramMap)throws Exception;
	
	//반품 상세페이지 리스트 조회
	public List<DlvReturnDetailModel> returnDetailList(Map<String, Object> paramMap) throws Exception;
	
	//반품 상세페이지 업데이트
	public int returnDetailInfo(Map<String, Object> paramMap) throws Exception;
	
	// 반품지시서 업데이트(배송사원, 상태(STTcd))
	public int updateReturnPaper(Map<String, Object> paramMap)throws Exception;
	
	// 배송 사원 이름,loginID 조회
	public List<DlvStaffNameModel> dlvStaffNameCombo(Map<String, Object> paramMap)throws Exception ;
	
	// 배송 사원 연락처 조회
	public String getDlvStaffTel(Map<String, Object> paramMap)throws Exception ;
}
