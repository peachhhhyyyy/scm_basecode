package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ScmReturnDetailListModel;
import kr.happyjob.study.scm.model.ScmReturnListModel;

public interface ScmReturnService {
	// 반품지시서 조회
	public List<ScmReturnListModel> getReturnList(Map<String, Object> paramMap) throws Exception;
	// 반품지시서 카운트조회
	public int scmReturnListCnt(Map<String, Object> paramMap) throws Exception;
	// 반품지시서 상세조회
	public List<ScmReturnDetailListModel> getReturnDetailList(Map<String, Object> paramMap) throws Exception;
}
