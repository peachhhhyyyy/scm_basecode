package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ScmReturnListModel;

public interface ScmReturnListDao {
	List<ScmReturnListModel> selectReturnList(Map<String, Object> paramMap) throws Exception;
	
}
