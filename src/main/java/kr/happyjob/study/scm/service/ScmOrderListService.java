package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.DeliveryInfoModel;
import kr.happyjob.study.scm.model.ProductInfoModel;
import kr.happyjob.study.scm.model.ScmOrderListModel;

public interface ScmOrderListService {

	List<ScmOrderListModel> getOrderList(Map<String, Object> paramMap) throws Exception;

	int getOrderListCnt(Map<String, Object> paramMap) throws Exception;

	ProductInfoModel getProductInfo(Map<String, Object> paramMap) throws Exception;

	String getScmManagerName(Map<String, Object> paramMap) throws Exception;

	DeliveryInfoModel getDeliveryInfo(Map<String, Object> paramMap) throws Exception;

	Map<String, String> updateState(Map<String, Object> paramMap) throws Exception;

	int insertData(Map<String, Object> paramMap) throws Exception;

}
