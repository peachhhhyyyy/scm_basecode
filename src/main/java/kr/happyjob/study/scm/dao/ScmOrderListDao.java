package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.DeliveryInfoModel;
import kr.happyjob.study.scm.model.ProductInfoModel;
import kr.happyjob.study.scm.model.ScmOrderListModel;


public interface ScmOrderListDao {
	List<ScmOrderListModel> selectOrderList(Map<String, Object> paramMap) throws Exception;
	
	int selectOrderListCnt(Map<String, Object> paramMap) throws Exception;
	
	ProductInfoModel selectProductInfo(Map<String, Object> paramMap) throws Exception;
	
	String selectScmManagerName(Map<String, Object> paramMap) throws Exception;
	
	DeliveryInfoModel selectDeliveryInfo(Map<String, Object> paramMap) throws Exception;
	
	int updateStateToDelivery(Map<String, Object> paramMap) throws Exception;
	
	int insertDataToDTable(Map<String, Object> paramMap) throws Exception;
	
	int updateStateToPurchase(Map<String, Object> paramMap) throws Exception;
	
	int insertDataToPTable(Map<String, Object> paramMap) throws Exception;
	
	int updateProductCount(Map<String, Object> paramMap) throws Exception;
}
