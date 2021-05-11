package kr.happyjob.study.dlv.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dlv.model.DlvOutgoingDetailModel;
import kr.happyjob.study.dlv.model.DlvOutgoingModel;

public interface OutgoingDao {

	// 1. 배송 준비 중 부터의 리스트 조회 / 상세조회 항목 포함.
	public List<DlvOutgoingModel> outgoingList(Map<String, Object> paramMap)throws Exception ;
	
	// 1-1 리스트 목록 카운트 조회
	public int outgoingCnt(Map<String, Object> paramMap)throws Exception ;
	
	// 1-2 주문코드에 대한 상세조회
	public List<DlvOutgoingDetailModel> outgoingDetailList(Map<String, Object> paramMap)throws Exception ;
}
