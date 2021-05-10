package kr.happyjob.study.dlv.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.dlv.model.DivReturnModel;
import kr.happyjob.study.dlv.service.DivReturnService;
import kr.happyjob.study.dlv.service.DlvReturnServiceImpl;

@Controller
@RequestMapping("/dlv")
public class DivReturnController {
	
	
	DlvReturnServiceImpl drtService = new DlvReturnServiceImpl();

	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@RequestMapping("return.do")
	public String returnMain() {
		
		logger.info("반품계획 메인페이지");
		
		String returnType = "/dlv/returnmain";
		return returnType;
	}
	// 반품내역 조회
	@RequestMapping("/returnList.do")
	public String returnList(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		session.setAttribute("paramMap", paramMap);
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	    int pageIndex = (currentPage - 1) * pageSize;
	    
	    paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		logger.info("paraMap"+paramMap);
		
		// 반품내역 가져오기
		List<DivReturnModel> divReturnModel = drtService.returnList(paramMap);
		model.addAttribute("DivReturnModel", divReturnModel);

		// 반품내역 목록 수 추출하기
		int returnListCnt = ((DivReturnService) drtService).returnListCnt(paramMap);
		logger.info("목록 수 추출하기로 왔음");
	    model.addAttribute("returnListCnt", returnListCnt);
	    model.addAttribute("pageSize", pageSize);
	    model.addAttribute("currentPage",currentPage);
	    
	    return "/dlv/returnList";
		//ModelAndView mvvv = new ModelAndView("/div/returnList","divReturnModel",divReturnModel);
		//return mvvv;
		
	}
	
}
