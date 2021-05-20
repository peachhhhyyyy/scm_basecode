package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ScmRefundListModel;

public interface ScmRefundListDao {

	List<ScmRefundListModel> selectRefundList(Map<String, Object> paramMap) throws Exception;

	int selectRefundListCnt(Map<String, Object> paramMap) throws Exception;

	ScmRefundListModel selectRefundDetail(Map<String, Object> paramMap) throws Exception;

	String selectScmManagerName(Map<String, Object> paramMap) throws Exception;

	int updateStateToRefund(Map<String, Object> paramMap) throws Exception;

	int insertDataToRTable(Map<String, Object> paramMap) throws Exception;
}
