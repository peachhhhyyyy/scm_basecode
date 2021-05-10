package kr.happyjob.study.dlv.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dlv.model.DlvOutgoingModel;

public interface OutgoingDao {

	// 배송 준비 중 부터의 리스트 조회
	public List<DlvOutgoingModel> orderList(Map<String, Object> paramMap)throws Exception ;
}
