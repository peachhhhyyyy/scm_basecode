package kr.happyjob.study.dlv.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.dlv.model.DlvOutgoingDetailModel;
import kr.happyjob.study.dlv.model.DlvOutgoingModel;
import kr.happyjob.study.dlv.model.DlvStaffNameModel;
import kr.happyjob.study.dlv.service.DlvOutgoingService;

@Controller
@RequestMapping("/dlv")
public class DlvOutgoingController {
	
	@Autowired
	DlvOutgoingService dlvOutgoingService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@RequestMapping("outgoing.do")
	public String initBoard() {
		
		logger.info("환영해 ");
		
		return "/dlv/outgoing";
	}
	
	
	// 배송 준비 중 부터의 수주내역 조회
	@RequestMapping("outgoingList.do")
	public String outgoingList(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	    int pageIndex = (currentPage - 1) * pageSize;
	    
	    paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
//		logger.info("paramMap" + paramMap);
		
//		logger.info("=============== 세션ID =============== : "+ session.getAttribute("loginId"));
//		paramMap.put("loginID", session.getAttribute("loginId"));
		
		// 출하내역 가져오기 //
		List<DlvOutgoingModel> outgoingList = dlvOutgoingService.outgoingList(paramMap);
		model.addAttribute("outgoingList", outgoingList);
//		logger.info("outgoingList : "+ outgoingList);

		//출하내역 목록 수 추출하기 //
		int outgoingCnt = dlvOutgoingService.outgoingCnt(paramMap);
	    model.addAttribute("outgoingCnt", outgoingCnt);
	    
	    model.addAttribute("pageSize", pageSize);
	    model.addAttribute("currentPage",currentPage);
	    
		return "/dlv/outgoingList";
	}
	
	// 출하계획 상세 페이지조회
	@RequestMapping("outgoingDetailList.do")
	public String outgoingDetailList(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		List<DlvOutgoingDetailModel> outgoingDetailList = dlvOutgoingService.outgoingDetailList(paramMap);
		model.addAttribute("outgoingDetailList", outgoingDetailList);
		
//		logger.info("상세조회 내용" + outgoingDetailList.toString());
		
		
		// 배송사원 이름
		List<DlvStaffNameModel> dlvStaffNameCombo = dlvOutgoingService.dlvStaffNameCombo(paramMap);
		model.addAttribute("dlvStaffNameCombo", dlvStaffNameCombo);
		
//		logger.info(dlvStaffNameCombo.toString());
		
		return "/dlv/outgoingDetailList";
	}
	
	
	// 배송 준비 중 부터의 검색 조건 수주내역 조회
	@RequestMapping("outgoingSearchList.do")
	
	public String outgoingSearchList(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	    int pageIndex = (currentPage - 1) * pageSize;
	    
	    paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
//		logger.info(" 검색조건 paramMap" + paramMap);
		
		// 출하내역 가져오기 //
		List<DlvOutgoingModel> outgoingSearchList = dlvOutgoingService.outgoingSearchList(paramMap);
		model.addAttribute("outgoingSearchList", outgoingSearchList);
//		logger.info("======= outgoingSearchList ======= : "+ outgoingSearchList);

		//출하내역 목록 수 추출하기 //
		int outgoingSearchCnt = dlvOutgoingService.outgoingSearchCnt(paramMap);
//		logger.info("======= outgoingSearchCnt ======= : " + outgoingSearchCnt);
	    model.addAttribute("outgoingSearchCnt", outgoingSearchCnt);
	    
	    model.addAttribute("pageSize", pageSize);
	    model.addAttribute("currentPage",currentPage);
	    
		return "/dlv/outgoingList";
	}
	
	
	@RequestMapping("selDlvTel.do")
	@ResponseBody
	public Map<String, String> selDlvTel(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		// 배송사원 번호
		String dlvStaffTel = dlvOutgoingService.getDlvStaffTel(paramMap);
		
		Map<String, String> resultStaffTelMap = new HashMap<String, String>();
		
		resultStaffTelMap.put("dlvStaffTel", dlvStaffTel);
		
		System.out.println("Map에 들어간 배송사원 번호 : " + resultStaffTelMap.get("dlvStaffTel"));
		
		
		return resultStaffTelMap;
	}
	
	@RequestMapping("submitDlvInfo.do")
	public String submitDlvInfo(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		 	
			logger.info("===== submit 정보 ===== : "+ paramMap);
			
			// ================== 진수형 작성 ================== //
			if(paramMap.get("state").equals("14")) {
				String staffNameAndId = (String) paramMap.get("dlvStaffNameAndLoginId");
				String[] staffNameAndIdArray = staffNameAndId.split(" ");
				logger.info("===== 이름과 아이디 배열 ===== : " + staffNameAndIdArray);
				
				String staffName = staffNameAndIdArray[0];
				String staffId = staffNameAndIdArray[1];
				
				paramMap.put("dlvStaffName", staffName);
				paramMap.put("dlvStaffLoginId", staffId);
				logger.info("===== 수정된 submit 정보 ===== : "+ paramMap);
			}
			// ============================================== //
			
			logger.info("======== loginID ======== : " + session.getAttribute("loginId"));
			
			paramMap.put("mngLoginId", session.getAttribute("loginId"));
			
			int ResultDBReturn = dlvOutgoingService.updateDlvPaper(paramMap);
//			logger.info("===== SHIP_LIST Update Result ===== : " + ResultDBReturn);
			
		return "/dlv/outgoing";
	}
}
