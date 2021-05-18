package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ScmRefundListModel;

public interface ScmRefundListService {

	List<ScmRefundListModel> getRefundList(Map<String, Object> paramMap) throws Exception;

	int getRefundListCnt(Map<String, Object> paramMap) throws Exception;

}
