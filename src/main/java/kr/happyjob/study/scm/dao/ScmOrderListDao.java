package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ScmOrderListModel;


public interface ScmOrderListDao {
	List<ScmOrderListModel> selectOrderList(Map<String, Object> paramMap) throws Exception;
}
