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

import kr.happyjob.study.dlv.model.DivReturnModel;
import kr.happyjob.study.dlv.service.DivReturnService;

@Controller
@RequestMapping("/dlv")
public class DivReturnController {
	@Autowired
	DivReturnService divReturnService;
	
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
		List<DivReturnModel> returnList = divReturnService.returnList(paramMap);
		model.addAttribute("returnList", returnList);

		// 목록 수 추출하기
		int returnlistCnt = divReturnService.returnlistCnt(paramMap);
		
	    model.addAttribute("returnlistCnt", returnlistCnt);
	    model.addAttribute("pageSize", pageSize);
	    model.addAttribute("currentPage",currentPage);
	    
		return "/dlv/returnList";
	}
}
