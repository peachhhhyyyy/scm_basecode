package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.CusInfoModel;

public interface CusInfoDao {
	/* 기업 고객 목록 조회 */
	public List<CusInfoModel> cusList(Map<String, Object> paramMap) throws Exception;
	  
	/* 기업 고객 카운트 조회 */
	public int cusListCnt(Map<String, Object> paramMap) throws Exception;
}
