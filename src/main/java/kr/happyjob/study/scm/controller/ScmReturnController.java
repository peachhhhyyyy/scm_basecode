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

import kr.happyjob.study.scm.model.ScmReturnDetailListModel;
import kr.happyjob.study.scm.model.ScmReturnListModel;
import kr.happyjob.study.scm.service.ScmReturnService;

@Controller
@RequestMapping("/scm")
public class ScmReturnController {
	@Autowired
	ScmReturnService srtservice;
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@RequestMapping("scmReturnMain.do")
	public String returnMain(){
		
		logger.info("반품지시서 메인페이지");
		
		return "/scm/scmReturnMain";
	}
	
	@RequestMapping("scmReturnList.do")
	public String getReturnList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		//지시서 조회페이징
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	    int pageIndex = (currentPage - 1) * pageSize;
	    
	    paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		logger.info("이건 paramMap" + paramMap);
		//반품지시서 조회
		List<ScmReturnListModel> returnList = srtservice.getReturnList(paramMap);
		model.addAttribute("returnList",returnList);
		logger.info("scmReturnList 값: "+ paramMap);
		
		//목록수 추출하기
		int scmReturnListCnt = srtservice.scmReturnListCnt(paramMap);
		System.out.println("scmReturnListCnt : " + scmReturnListCnt);
		
		model.addAttribute("scmReturnListCnt", scmReturnListCnt);
		model.addAttribute("pageSize", pageSize);
		
		model.addAttribute("currentPage", currentPage);
		return "/scm/scmReturnList";
	}
	
	@RequestMapping("scmReturnDetailList.do")
	public String scmOutgoingDetailList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("상세조건 paramMap : " + paramMap);
		
		//반품지시서 상세조회
		List<ScmReturnDetailListModel> returnDetailList = srtservice.getReturnDetailList(paramMap);
		model.addAttribute("returnDetailList",returnDetailList);
		logger.info("returnDetailList 값: "+ paramMap);
		
		return "/scm/scmReturnDetailList";
	}
	
}
