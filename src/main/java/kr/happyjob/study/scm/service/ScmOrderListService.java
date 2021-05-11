package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ScmOrderListModel;

public interface ScmOrderListService {

	List<ScmOrderListModel> getOrderList(Map<String, Object> paramMap) throws Exception;

}
