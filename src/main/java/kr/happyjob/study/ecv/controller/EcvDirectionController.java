package kr.happyjob.study.ecv.controller;

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

@Controller
@RequestMapping("/ecv")
public class EcvDirectionController {
	
	@Autowired
	EcvDirectionService ecvDirectionService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();
	
	@RequestMapping("purchaseDirec.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".init");

		/* ############## set input data################# */
		paramMap.put("loginId", session.getAttribute("loginId")); // 로그인 아이디
		paramMap.put("userType", session.getAttribute("userType")); // 유저 타입
		paramMap.put("reg_date", session.getAttribute("reg_date")); // 가입일

		logger.info("   - paramMap : " + paramMap);

		logger.info("+ end " + className + ".init");

		return "ecv/directionList.jsp";
	}
	
	
}
