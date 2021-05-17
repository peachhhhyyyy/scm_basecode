package kr.happyjob.study.ecv.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ecv.model.EcvDeliveryDirectionModel;
import kr.happyjob.study.ecv.model.EcvPurchaseDirectionModel;

public interface EcvDirectionDao {

	List<EcvPurchaseDirectionModel> selectPurchaseDirectionList(Map<String, Object> paramMap) throws Exception;

	int selectPurchaseDirectionListCnt(Map<String, Object> paramMap) throws Exception;

	List<EcvDeliveryDirectionModel> selectDeliveryDirectionList(Map<String, Object> paramMap) throws Exception;

	int selectDeliveryDirectionListCnt(Map<String, Object> paramMap) throws Exception;

	int updatePurchaseApprove(Map<String, Object> paramMap) throws Exception;

	int updateRefundApprove(Map<String, Object> paramMap) throws Exception;

}
