package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ScmReturnListModel;

public interface ScmReturnListDao {
	//반품지시서 리스트조회
	public List<ScmReturnListModel> selectReturnList(Map<String, Object> paramMap) throws Exception;
	//반품지시서 카운트 조회
	public int scmReturnListCnt(Map<String, Object> paramMap) throws Exception;
}
