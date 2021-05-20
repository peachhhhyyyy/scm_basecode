package kr.happyjob.study.dlv.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dlv.model.DlvReturnDetailModel;
import kr.happyjob.study.dlv.model.DlvReturnModel;
import kr.happyjob.study.dlv.model.DlvStaffNameModel;


public interface ReturnDao {
	// 반품 리스트 조회
	public List<DlvReturnModel> returnList(Map<String, Object> paramMap) throws Exception;
	
	// 반품 리스트 조회수 
	public int returnListCnt(Map<String, Object> paramMap) throws Exception;
	
	// 반품 검색조건 리스트 조회
	public List<DlvReturnModel> returnSearchList(Map<String, Object> paramMap) throws Exception;
	
	// 반품 검색조건 건수
	public int returnSearchCnt(Map<String, Object> paramMap) throws Exception;
	
	// 반품 상세페이지 조회
	public List<DlvReturnDetailModel> returnDetailList(Map<String, Object> paramMap) throws Exception;
	
	// 반품 상세페이지 업데이트
	public int returnDetailInfo(Map<String, Object> paramMap) throws Exception;
	
	// 배송사원이름 조회 -> 콤보박스로 감.
	public List<DlvStaffNameModel> dlvStaffNameCombo(Map<String, Object> paramMap)throws Exception ;
	
	// 배송사원연락 조회 -> 위에서 선택된 배송사원의 이름을 기반으로 검색함.
	public String getDlvStaffTel(Map<String, Object> paramMap)throws Exception ;
	
	// 배송지시서 업데이트
	public int updateReturnPaper(Map<String, Object> paramMap)throws Exception;
}
