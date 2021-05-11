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

import kr.happyjob.study.dlv.model.DlvOutgoingDetailModel;
import kr.happyjob.study.dlv.model.DlvOutgoingModel;
import kr.happyjob.study.dlv.service.DlvOutgoingService;

@Controller
@RequestMapping("/dlv")
public class DlvOutgoingController {
	
	@Autowired
	DlvOutgoingService dlvOutgoingService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@RequestMapping("outgoing.do")
	public String initBoard() {
		
		logger.info("환영해");
		
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
		
		logger.info("이건 paramMap" + paramMap);
		
		// 출하내역 가져오기 //
		List<DlvOutgoingModel> outgoingList = dlvOutgoingService.outgoingList(paramMap);
		model.addAttribute("outgoingList", outgoingList);
		logger.info("outgoingList"+ outgoingList);

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
		
		return "/dlv/outgoingDetailList";
	}
	
	

}
