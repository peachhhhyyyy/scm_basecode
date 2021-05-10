package kr.happyjob.study.dlv.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dlv.model.DlvOutgoingModel;

public interface OutgoingDao {

	// 1. 배송 준비 중 부터의 리스트 조회
	public List<DlvOutgoingModel> outgoingList(Map<String, Object> paramMap)throws Exception ;
	
	// 1-1 리스트 목록 카운트 조회
	public int outgoingCnt(Map<String, Object> paramMap)throws Exception ;
}
