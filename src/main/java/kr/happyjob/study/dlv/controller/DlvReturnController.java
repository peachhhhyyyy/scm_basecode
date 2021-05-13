package kr.happyjob.study.dlv.controller;


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

import kr.happyjob.study.dlv.model.DlvReturnDetailModel;
import kr.happyjob.study.dlv.model.DlvReturnModel;
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
	
	//반품내역 상세 페이지조회
	@RequestMapping("returnDetailList.do")
	public String returnDetailList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		List<DlvReturnDetailModel> returnDetailList = dlvReturnService.returnDetailList(paramMap);
		model.addAttribute("returnDetailList", returnDetailList);
		logger.info("returnDetailList"+returnDetailList);
		return "/dlv/returnDetail";
	}
	
	@RequestMapping("returnDetailInfo.do")
	public String returnDetailInfo(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		 	
		 	
			logger.info("returnDetailInfo 페이지");
			String order_cd = (String)paramMap.get("order_cd");
			String state = (String)paramMap.get("state");
			String refund_list_no = (String)paramMap.get("refund_list_no");
			logger.info("order_cd:"+ order_cd+"state: "+state+"refund_list_n:" +refund_list_no);
			int returnDetailInfo = dlvReturnService.returnDetailInfo(paramMap);
			
			logger.info("returnDetailInfo 값:"+ returnDetailInfo);
		return "/dlv/returnMain";
	}
	
}
