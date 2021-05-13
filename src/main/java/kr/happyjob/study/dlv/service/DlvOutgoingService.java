package kr.happyjob.study.dlv.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dlv.model.DlvOutgoingDetailModel;
import kr.happyjob.study.dlv.model.DlvOutgoingModel;
import kr.happyjob.study.dlv.model.DlvStaffNameModel;

public interface DlvOutgoingService {
	
	// 배송 준비 중 부터 리스트 조회
	public List<DlvOutgoingModel> outgoingList(Map<String, Object> paramMap)throws Exception ;
	
	// 배송 준비 중 부터 리스트 건수
	public int outgoingCnt(Map<String, Object> paramMap)throws Exception;
	
	// 검색 조건 출하내역 조회
	public List<DlvOutgoingModel> outgoingSearchList(Map<String, Object> paramMap) throws Exception ;
	
	// 검색 조건 출하내역 건수
	public int outgoingSearchCnt(Map<String, Object> paramMap)throws Exception;
	
	// 배송 준비 중 부터 한건에 대한 상세 조회
	public List<DlvOutgoingDetailModel> outgoingDetailList(Map<String, Object> paramMap)throws Exception ;
	
	// 배송 사원 이름 조회
	public List<DlvStaffNameModel> dlvStaffNameCombo(Map<String, Object> paramMap)throws Exception ;
}
