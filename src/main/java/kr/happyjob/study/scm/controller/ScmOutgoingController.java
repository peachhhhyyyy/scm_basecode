package kr.happyjob.study.scm.controller;

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

import kr.happyjob.study.scm.model.ScmOutgoingDetailListModel;
import kr.happyjob.study.scm.model.ScmOutgoingListModel;
import kr.happyjob.study.scm.service.ScmOutgoingService;

@Controller
@RequestMapping("/scm")
public class ScmOutgoingController {
	@Autowired
	ScmOutgoingService solservice;
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@RequestMapping("scmOutgoingMain.do")
	public String outgoingMain(){
		
		logger.info("배송지시서 메인페이지");
		
		return "/scm/scmOutgoingMain";
	}
	
	@RequestMapping("scmOutgoingList.do")
	public String getOutgoingList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		//지시서 조회페이징
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	    int pageIndex = (currentPage - 1) * pageSize;
	    
	    paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		logger.info("paramMap : " + paramMap);
		//반품지시서 조회
		List<ScmOutgoingListModel> outgoingList = solservice.getOutgoingList(paramMap);
		model.addAttribute("outgoingList",outgoingList);
		logger.info("outgoingList 값: "+ outgoingList);
		
		//목록수 추출하기
		int scmOutgoingListCnt = solservice.scmOutgoingListCnt(paramMap);
		System.out.println("scmOutgoingListCnt : " + scmOutgoingListCnt);
		
		model.addAttribute("scmOutgoingListCnt", scmOutgoingListCnt);
		model.addAttribute("pageSize", pageSize);
		
		model.addAttribute("currentPage", currentPage);
		return "/scm/scmOutgoingList";
	}
	
	@RequestMapping("scmOutgoingDetailList.do")
	public String scmOutgoingDetailList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("상세조건 paramMap : " + paramMap);
		
		//반품지시서 조회
		List<ScmOutgoingDetailListModel> outgoingSearchList = solservice.getOutgoingDetailList(paramMap);
		model.addAttribute("outgoingSearchList",outgoingSearchList);
		logger.info("outgoingSearchList 값: "+ paramMap);
		
		return "/scm/scmOutgoingDetailList";
	}
}
