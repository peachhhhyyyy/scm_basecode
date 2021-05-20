package kr.happyjob.study.ecv.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ecv.model.EcvPurchaseDirectionModel;
import kr.happyjob.study.ecv.model.EcvRefundDirectionModel;

public interface EcvDirectionService {

	List<EcvPurchaseDirectionModel> getPurchaseDirectionList(Map<String, Object> paramMap) throws Exception;

	int getPurchaseDirectionListCnt(Map<String, Object> paramMap) throws Exception;

	List<EcvRefundDirectionModel> getRefundDirectionList(Map<String, Object> paramMap) throws Exception;

	int getRefundDirectionListCnt(Map<String, Object> paramMap) throws Exception;

	int updateStateToPurchase(Map<String, Object> paramMap) throws Exception;

	int updateStateToRefund(Map<String, Object> paramMap) throws Exception;

}