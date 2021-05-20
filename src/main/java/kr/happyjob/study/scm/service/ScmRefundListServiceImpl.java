package kr.happyjob.study.scm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.ScmRefundListDao;
import kr.happyjob.study.scm.model.ScmRefundListModel;

@Service
public class ScmRefundListServiceImpl implements ScmRefundListService {

	@Autowired
	ScmRefundListDao scmRefundListDao;

	private final Logger logger = LogManager.getLogger(this.getClass());
	// Get class name for logger
	private final String className = this.getClass().toString();

	@Override
	public List<ScmRefundListModel> getRefundList(Map<String, Object> paramMap) throws Exception {
		return scmRefundListDao.selectRefundList(paramMap);
	}

	@Override
	public int getRefundListCnt(Map<String, Object> paramMap) throws Exception {
		return scmRefundListDao.selectRefundListCnt(paramMap);
	}

	@Override
	public ScmRefundListModel getRefundDetail(Map<String, Object> paramMap) throws Exception {
		return scmRefundListDao.selectRefundDetail(paramMap);
	}

	@Override
	public String getScmManagerName(Map<String, Object> paramMap) throws Exception {
		return scmRefundListDao.selectScmManagerName(paramMap);
	}

	@Override
	public Map<String, String> updateState(Map<String, Object> paramMap) throws Exception {
		logger.info("+ Start " + className + ".updateState");

		String STTcd = (String) paramMap.get("STTcd");
		paramMap.put("STTcd", STTcd);

		int mapperResult;
		String result = "";
		String resultMsg = "";

		if (STTcd.equals("3")) {
			logger.info("====== 주문상태를 승인대기(반품)으로 변경합니다. ======");
			mapperResult = scmRefundListDao.updateStateToRefund(paramMap);

			if (mapperResult == 1) {
				result = "SUCCESS";
				resultMsg = "반품 요청을 완료하였습니다.";
			} else {
				result = "FAIL";
				resultMsg = "반품 요청에 실패하였습니다.";
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

		if (STTcd.equals("3")) {
			return scmRefundListDao.insertDataToRTable(paramMap);
		} else {
			logger.info("====== 반품지시서에 넣고자 하는 데이터의 STTcd가 4가 아닙니다! =======");
		}

		logger.info("+ end " + className + ".insertData");

		return 0;
	}
}
