package kr.happyjob.study.ecv.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.ecv.dao.EcvDirectionDao;
import kr.happyjob.study.ecv.model.EcvDeliveryDirectionModel;
import kr.happyjob.study.ecv.model.EcvPurchaseDirectionModel;

@Service
public class EcvDirectionServiceImpl implements EcvDirectionService {

	@Autowired
	EcvDirectionDao ecvDirectionDao;

	@Override
	public List<EcvPurchaseDirectionModel> getPurchaseDirectionList(Map<String, Object> paramMap) throws Exception {
		return ecvDirectionDao.selectPurchaseDirectionList(paramMap);
	}
	
	@Override
	public int getPurchaseDirectionListCnt(Map<String, Object> paramMap) throws Exception {
		return ecvDirectionDao.selectPurchaseDirectionListCnt(paramMap);
	}
	
	@Override
	public List<EcvDeliveryDirectionModel> getDeliveryDirectionList(Map<String, Object> paramMap) throws Exception {
		return ecvDirectionDao.selectDeliveryDirectionList(paramMap);
	}
	
	@Override
	public int getDeliveryDirectionListCnt(Map<String, Object> paramMap) throws Exception {
		return ecvDirectionDao.selectDeliveryDirectionListCnt(paramMap);
	}
	
	@Override
	public int updateStateToPurchase(Map<String, Object> paramMap) throws Exception {
		return ecvDirectionDao.updatePurchaseApprove(paramMap);
	}
	
	@Override
	public int updateStateToRefund(Map<String, Object> paramMap) throws Exception {
		return ecvDirectionDao.updateRefundApprove(paramMap);
	}
}