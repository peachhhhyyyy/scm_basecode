package kr.happyjob.study.dlv.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dlv.model.DlvOutgoingModel;

public interface DlvOutgoingService {
	
	// 배송 준비 중 부터 리스트 조회
	public List<DlvOutgoingModel> orderList(Map<String, Object> paramMap)throws Exception ;
	
	// 배송 준비 중 부터 리스트 카운트 조회
	public int outgoingCnt(Map<String, Object> paramMap)throws Exception ;
	
}
