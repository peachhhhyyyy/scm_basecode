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

import kr.happyjob.study.scm.model.ScmReturnListModel;
import kr.happyjob.study.scm.service.ScmReturnService;

@Controller
@RequestMapping("/scmReturn")
public class ScmReturnController {
	@Autowired
	ScmReturnService srtservice;
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	
	@RequestMapping("scmReturnList.do")
	public String getReturnList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		List<ScmReturnListModel> returnList = srtservice.getReturnList(paramMap);
		model.addAttribute("returnList",returnList);
		logger.info("scmReturnList 값: "+paramMap);
		
		return "/scm/scmReturnMain";
	}
	
}
