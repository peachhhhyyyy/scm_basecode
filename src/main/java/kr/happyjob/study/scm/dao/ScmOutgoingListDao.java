package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ScmOutgoingListModel;

public interface ScmOutgoingListDao {
	//반품지시서 리스트조회
	public List<ScmOutgoingListModel> getOutgoingList(Map<String, Object> paramMap) throws Exception;
	//반품지시서 카운트 조회
	public int scmOutgoingListCnt(Map<String, Object> paramMap) throws Exception;
}
