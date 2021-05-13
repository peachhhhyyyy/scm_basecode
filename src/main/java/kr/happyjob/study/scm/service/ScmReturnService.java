package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ScmReturnListModel;

public interface ScmReturnService {
	List<ScmReturnListModel> getReturnList(Map<String, Object> paramMap) throws Exception;
}
