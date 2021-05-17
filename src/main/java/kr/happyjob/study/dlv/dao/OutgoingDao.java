package kr.happyjob.study.dlv.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dlv.model.DlvOutgoingDetailModel;
import kr.happyjob.study.dlv.model.DlvOutgoingModel;
import kr.happyjob.study.dlv.model.DlvStaffNameModel;

public interface OutgoingDao {

	// 1. 배송 준비 중 부터의 리스트 조회 / 상세조회 항목 포함.
	public List<DlvOutgoingModel> outgoingList(Map<String, Object> paramMap)throws Exception ;
	
	// 리스트 목록 건수 조회
	public int outgoingCnt(Map<String, Object> paramMap)throws Exception;
	
	// 검색 조건 출하내역 Dao
	public List<DlvOutgoingModel> outgoingSearchList(Map<String, Object> paramMap)throws Exception ;
	
	// 검색 조건 출하내역 건수
	public int outgoingSearchCnt(Map<String, Object> paramMap)throws Exception;
	
	// 주문코드에 대한 상세조회
	public List<DlvOutgoingDetailModel> outgoingDetailList(Map<String, Object> paramMap)throws Exception ;
	
	// 배송사원이름 조회 -> 콤보박스로 감.
	public List<DlvStaffNameModel> dlvStaffNameCombo(Map<String, Object> paramMap)throws Exception ;
	
	// 배송사원연락 조회 -> 위에서 선택된 배송사원의 이름을 기반으로 검색함.
	public String getDlvStaffTel(Map<String, Object> paramMap)throws Exception ;
	
	// 배송지시서 업데이트
	public int updateDlvPaper(Map<String, Object> paramMap)throws Exception;
}
