package kr.happyjob.study.ecv.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ecv.model.EcvDeliveryDirectionModel;
import kr.happyjob.study.ecv.model.EcvPurchaseDirectionModel;

public interface EcvDirectionService {

	List<EcvPurchaseDirectionModel> getPurchaseDirectionList(Map<String, Object> paramMap) throws Exception;

	int getPurchaseDirectionListCnt(Map<String, Object> paramMap) throws Exception;

	List<EcvDeliveryDirectionModel> getDeliveryDirectionList(Map<String, Object> paramMap) throws Exception;

	int getDeliveryDirectionListCnt(Map<String, Object> paramMap) throws Exception;

	int updateStateToPurchase(Map<String, Object> paramMap) throws Exception;

	int updateStateToRefund(Map<String, Object> paramMap) throws Exception;

}