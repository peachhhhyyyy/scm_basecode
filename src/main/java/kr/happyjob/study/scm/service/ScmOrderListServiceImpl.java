package kr.happyjob.study.scm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.ScmOrderListDao;
import kr.happyjob.study.scm.model.DeliveryInfoModel;
import kr.happyjob.study.scm.model.ProductInfoModel;
import kr.happyjob.study.scm.model.ScmOrderListModel;

@Service
public class ScmOrderListServiceImpl implements ScmOrderListService {

	@Autowired
	ScmOrderListDao scmOrderListDao;

	private final Logger logger = LogManager.getLogger(this.getClass());
	// Get class name for logger
	private final String className = this.getClass().toString();

	@Override
	public List<ScmOrderListModel> getOrderList(Map<String, Object> paramMap) throws Exception {
		return scmOrderListDao.selectOrderList(paramMap);
	}

	@Override
	public int getOrderListCnt(Map<String, Object> paramMap) throws Exception {
		return scmOrderListDao.selectOrderListCnt(paramMap);
	}

	@Override
	public ProductInfoModel getProductInfo(Map<String, Object> paramMap) throws Exception {
		return scmOrderListDao.selectProductInfo(paramMap);
	}

	@Override
	public String getScmManagerName(Map<String, Object> paramMap) throws Exception {
		return scmOrderListDao.selectScmManagerName(paramMap);
	}

	@Override
	public DeliveryInfoModel getDeliveryInfo(Map<String, Object> paramMap) throws Exception {
		return scmOrderListDao.selectDeliveryInfo(paramMap);
	}

	@Override
	public Map<String, String> updateState(Map<String, Object> paramMap) throws Exception {
		logger.info("+ Start " + className + ".updateState");

		// paramMap에 있는 SSTcd String 으로 변환해주기
		String STTcd = (String) paramMap.get("STTcd");
		paramMap.put("STTcd", STTcd);

		int mapperResult;
		String result = "";
		String resultMsg = "";

		if (STTcd.equals("13")) {
			logger.info("====== 주문상태를 배송준비로 변경합니다. ======");
			mapperResult = scmOrderListDao.updateStateToDelivery(paramMap);
			// 창고에 있는 재고 수 차감 Dao
			int updateProductResult = scmOrderListDao.updateProductCount(paramMap);

			if (mapperResult == 1 && updateProductResult == 1) {
				result = "SUCCESS";
				resultMsg = "배송 요청을 완료하였습니다.";
			} else {
				result = "FAIL";
				resultMsg = "배송 요청에 실패하였습니다.";
			}
		} else if (STTcd.equals("9")) {
			logger.info("====== 주문상태를 승인대기(발주)로 변경합니다. ======");
			mapperResult = scmOrderListDao.updateStateToPurchase(paramMap);

			if (mapperResult == 1) {
				result = "SUCCESS";
				resultMsg = "발주 요청을 완료하였습니다.";
			} else {
				result = "FAIL";
				resultMsg = "발주 요청에 실패하였습니다.";
			}
		}

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		logger.info("+ end " + className + ".updateState");

		return resultMap;
	}

	@Override
	public int insertData(Map<String, Object> paramMap) throws Exception {
		logger.info("+ Start " + className + ".insertData");

		String STTcd = (String) paramMap.get("STTcd");

		if (STTcd.equals("13")) {
			return scmOrderListDao.insertDataToDTable(paramMap);
		}

		if (STTcd.equals("9")) {
			return scmOrderListDao.insertDataToPTable(paramMap);
		}

		logger.info("+ end " + className + ".insertData");

		return 0;
	}

}
