package kr.happyjob.study.dlv.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dlv.model.DivReturnModel;


public interface ReturnDao {
	// 반품 리스트 조회
	public List<DivReturnModel> returnList(Map<String, Object> paramMap) throws Exception;

}
