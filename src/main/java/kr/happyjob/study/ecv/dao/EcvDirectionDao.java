package kr.happyjob.study.ecv.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ecv.model.EcvPurchaseDirectionModel;
import kr.happyjob.study.ecv.model.EcvRefundDirectionModel;

public interface EcvDirectionDao {

	List<EcvPurchaseDirectionModel> selectPurchaseDirectionList(Map<String, Object> paramMap) throws Exception;

	int selectPurchaseDirectionListCnt(Map<String, Object> paramMap) throws Exception;

	List<EcvRefundDirectionModel> selectRefundDirectionList(Map<String, Object> paramMap) throws Exception;

	int selectRefundDirectionListCnt(Map<String, Object> paramMap) throws Exception;

	int updatePurchaseApprove(Map<String, Object> paramMap) throws Exception;

	int updateRefundApprove(Map<String, Object> paramMap) throws Exception;

}
