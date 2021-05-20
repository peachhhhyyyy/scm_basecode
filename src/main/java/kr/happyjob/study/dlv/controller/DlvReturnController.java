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

import kr.happyjob.study.dlv.model.DlvReturnDetailModel;
import kr.happyjob.study.dlv.model.DlvReturnModel;
import kr.happyjob.study.dlv.model.DlvStaffNameModel;
import kr.happyjob.study.dlv.service.DlvReturnService;

@Controller
@RequestMapping("/dlv")
public class DlvReturnController {
	@Autowired
	DlvReturnService dlvReturnService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@RequestMapping("returnMain.do")
	public String returnMain(){
		
		logger.info("반품메인페이지");
		
		return "/dlv/returnMain";
	}
	
	// 반품리스트 조회
	@RequestMapping("returnList.do")
	public String returnlist(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	    int pageIndex = (currentPage - 1) * pageSize;
	    
	    paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		logger.info("이건 paramMap" + paramMap);
		
		// 수주내역 가져오기
		List<DlvReturnModel> returnList = dlvReturnService.returnList(paramMap);
		model.addAttribute("returnList", returnList);

		// 목록 수 추출하기
		int returnlistCnt = dlvReturnService.returnlistCnt(paramMap);
		
	    model.addAttribute("returnlistCnt", returnlistCnt);
	    model.addAttribute("pageSize", pageSize);
	    model.addAttribute("currentPage",currentPage);
	    
		return "/dlv/returnList";
	}
	
		// 승인완료 부터 검색 조건 반품내역 조회
		@RequestMapping("returnSearchList.do")
		public String returnSearchList(Model model, @RequestParam Map<String, Object> paramMap, 
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
			
			int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		    int pageIndex = (currentPage - 1) * pageSize;
		    
		    paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			logger.info(" 검색조건으로 가져온 paramMap" + paramMap);
			
			// 반품내역 가져오기 //
			List<DlvReturnModel> retrunSearchList = dlvReturnService.returnSearchList(paramMap);
			model.addAttribute("retrunSearchList", retrunSearchList);
//			logger.info("======= retrunSearchList ======= : "+ retrunSearchList);

			// 반품내역 목록 수 추출하기 //
			int returnSearchCnt = dlvReturnService.returnSearchCnt(paramMap);
			logger.info("======= returnSearchCnt ======= : " + returnSearchCnt);
		    model.addAttribute("returnSearchCnt", returnSearchCnt);
		    
		    model.addAttribute("pageSize", pageSize);
		    model.addAttribute("currentPage",currentPage);
		    
			return "/dlv/returnList";
		}
	
	
	
	//반품내역 상세 페이지조회
	@RequestMapping("returnDetailList.do")
	public String returnDetailList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		List<DlvReturnDetailModel> returnDetailList = dlvReturnService.returnDetailList(paramMap);
		model.addAttribute("returnDetailList", returnDetailList);
		logger.info("returnDetailList : "+returnDetailList);
		
		List<DlvStaffNameModel> dlvStaffNameCombo = dlvReturnService.dlvStaffNameCombo(paramMap);
		model.addAttribute("dlvStaffNameCombo", dlvStaffNameCombo);
		
//		System.out.println("====== Return Dlv Name ====== : " + dlvStaffNameCombo.toString());
		
		return "/dlv/returnDetail";
	}
	
	@RequestMapping("selDlvTelReturn.do")
	@ResponseBody
	public Map<String, String> selDlvTel(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		// 배송사원 번호
		String dlvStaffTel = dlvReturnService.getDlvStaffTel(paramMap);
		
		Map<String, String> resultStaffTelMap = new HashMap<String, String>();
		
		resultStaffTelMap.put("dlvStaffTel", dlvStaffTel);
		
		System.out.println("Map에 들어간 배송사원 번호 : " + resultStaffTelMap.get("dlvStaffTel"));
		
		
		return resultStaffTelMap;
	}
	
	@RequestMapping("updateSubmitInfo.do")
	public String updateSubmitInfo(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		 	
			logger.info("===== submit 정보 ===== : "+ paramMap);
			
			if(paramMap.get("state").equals("6")) {
				String staffNameAndId = (String) paramMap.get("dlvStaffNameAndLoginId");
				String[] staffNameAndIdArray = staffNameAndId.split(" ");
				
				String staffName = staffNameAndIdArray[0];
				String staffId = staffNameAndIdArray[1];
				
				paramMap.put("dlvStaffName", staffName);
				paramMap.put("dlvStaffLoginId", staffId);
				logger.info("===== 수정된 submit 정보 ===== : "+ paramMap);
			}
			
//			logger.info("======== loginID ======== : " + session.getAttribute("loginId"));
			
			paramMap.put("mngLoginId", session.getAttribute("loginId"));
			
			int ResultDBReturn = dlvReturnService.updateReturnPaper(paramMap);
			logger.info("===== SHIP_LIST Update Result ===== : " + ResultDBReturn);
			
			
		return "/dlv/returnMain";
	}
}
