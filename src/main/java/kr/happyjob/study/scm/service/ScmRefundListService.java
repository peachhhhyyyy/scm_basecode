package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ScmRefundListModel;

public interface ScmRefundListService {

	List<ScmRefundListModel> getRefundList(Map<String, Object> paramMap) throws Exception;

	int getRefundListCnt(Map<String, Object> paramMap) throws Exception;

	ScmRefundListModel getRefundDetail(Map<String, Object> paramMap) throws Exception;

	String getScmManagerName(Map<String, Object> paramMap) throws Exception;

	Map<String, String> updateState(Map<String, Object> paramMap) throws Exception;

	int insertData(Map<String, Object> paramMap) throws Exception;

}
