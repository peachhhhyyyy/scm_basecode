package kr.happyjob.study.ecv.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.ecv.model.EcvPurchaseDirectionModel;
import kr.happyjob.study.ecv.service.EcvDirectionService;

@Controller
@RequestMapping("/ecv")
public class EcvDirectionController {
    
    @Autowired
    EcvDirectionService ecvDirectionService;
    
    private final Logger logger = LogManager.getLogger(this.getClass());
    private final String className = this.getClass().toString();
    
    @RequestMapping("purchaseDirec.do")
    public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
            HttpServletResponse response, HttpSession session) throws Exception {

        logger.info("+ Start " + className + ".init");

        /* ############## set input data################# */
        paramMap.put("loginId", session.getAttribute("loginId")); // 로그인 아이디
        paramMap.put("userType", session.getAttribute("userType")); // 유저 타입
        paramMap.put("reg_date", session.getAttribute("reg_date")); // 가입일

        logger.info("   - paramMap : " + paramMap);

        logger.info("+ end " + className + ".init");

        return "/ecv/ecvDirectionList";
    }
    
	@RequestMapping("directionListInfo.do")
	public String getPurchaseDirectionList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".directionListInfo");

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		logger.info("paramMap:" + paramMap);

		// 발주지시서 목록
		List<EcvPurchaseDirectionModel> purchaseList = ecvDirectionService.getPurchaseDirectionList(paramMap);
		model.addAttribute("purchaseList", purchaseList);
		model.addAttribute("listName", "purchase");

		// 발주지시서 목록 갯수 추출
		int purchaseListCnt = ecvDirectionService.getPurchaseDirectionListCnt(paramMap);
		model.addAttribute("purchaseListCnt", purchaseListCnt);

		// 페이징 처리에 사용될 값들
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage", currentPage);

		logger.info("+ end " + className + ".directionListInfo");

		return "/ecv/ecvDirectionInfo";
	}
	
	@RequestMapping("ecvApprove.do")
	public Map<String, String> ecvApprove(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		// paramMap에 있는 SSTcd int형으로 변환해주기
		String STTcd = (String) paramMap.get("STTcd");
		paramMap.put("STTcd", STTcd);
		
		int mapperResult;
		String result = "";
		String resultMsg = "";
		
		if (STTcd.equals("10")) {
			logger.info("====== 주문상태를 승인완료(발주)로 변경합니다. ======");
			mapperResult = ecvDirectionService.updateStateToPurchase(paramMap);
			
			if (mapperResult == 1) {
				result = "SUCCESS";
				resultMsg = "발주요청 승인을 완료하였습니다.";
			} else {
				result = "FAIL";
				resultMsg = "발주요청 승인에 실패하였습니다.";
			}
		} else if (STTcd.equals("5")) {
			logger.info("====== 주문상태를 승인완료(반품)로 변경합니다. ======");
			mapperResult = ecvDirectionService.updateStateToRefund(paramMap);
			
			if (mapperResult == 1) {
				result = "SUCCESS";
				resultMsg = "반품요청 승인을 완료하였습니다.";
			} else {
				result = "FAIL";
				resultMsg = "반품요청 승인에 실패하였습니다.";
			}
		}
		
		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ end " + className + ".updateState");
		
		return resultMap;
	}
    
}