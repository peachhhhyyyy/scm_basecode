package kr.happyjob.study.dlv.controller;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DlvOutgoingController {
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@RequestMapping("/dlv/outgoing.do")
	public String initBoard() {
		
		logger.info("환영해");
		
		String returnType = "/dlv/outgoing";
		return returnType;
	}
	
}
