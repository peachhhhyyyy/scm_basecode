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

import kr.happyjob.study.dlv.model.DlvOutgoingModel;
import kr.happyjob.study.dlv.service.DlvOutgoingService;
import kr.happyjob.study.dlv.service.DlvOutgoingServiceImpl;

@Controller
@RequestMapping("/dlv")
public class DlvOutgoingController {
	
//	@Autowired
//	DlvOutgoingService dlvOutgoingService;
	
	DlvOutgoingService dlvOutgoingService = new DlvOutgoingServiceImpl();
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@RequestMapping("outgoing.do")
	public String initBoard() {
		
		logger.info("환영해");
		
		String returnType = "/dlv/outgoing";
		return returnType;
	}
	
	// 배송 준비 중 부터의 수주내역 조회
	@RequestMapping("orderlist.do")
	public String orderList(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	    int pageIndex = (currentPage - 1) * pageSize;
	    
	    paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		logger.info(paramMap);
		
		// 수주내역 가져오기
		List<DlvOutgoingModel> dlvOutgoingModel = dlvOutgoingService.orderList(paramMap);
		model.addAttribute("dlvOutgoingModel", dlvOutgoingModel);

		// 목록 수 추출하기
		int outgoingCnt = dlvOutgoingService.outgoingCnt(paramMap);
		
	    model.addAttribute("noticeCnt", outgoingCnt);
	    model.addAttribute("pageSize", pageSize);
	    model.addAttribute("currentPage",currentPage);
	    
		return "/dlv/orderList";
	}
	
	

}
