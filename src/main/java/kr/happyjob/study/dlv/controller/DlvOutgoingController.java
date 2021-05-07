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

import kr.happyjob.study.system.model.NoticeModel;

@Controller
public class DlvOutgoingController {
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@RequestMapping("/dlv/outgoing.do")
	public String initBoard() {
		
		logger.info("환영해");
		
		String returnType = "/dlv/outgoing";
		return returnType;
	}
	
	// 배송 준비 중 부터의 수주내역 조회
//	@RequestMapping("/search/orderlist.do")

}
