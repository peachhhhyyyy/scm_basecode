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

import kr.happyjob.study.scm.model.ScmRefundListModel;
import kr.happyjob.study.scm.service.ScmRefundListService;

@Controller
@RequestMapping("/scm")
public class ScmRefundListController {

	@Autowired
	ScmRefundListService scmRefundListService;

	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();

	@RequestMapping("scmRefundList.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".init");

		/* ############## set input data################# */
		paramMap.put("loginId", session.getAttribute("loginId")); // 로그인 아이디
		paramMap.put("userType", session.getAttribute("userType")); // 유저 타입
		paramMap.put("reg_date", session.getAttribute("reg_date")); // 가입일

		logger.info("   - paramMap : " + paramMap);

		logger.info("+ end " + className + ".init");

		return "/scm/refundList";
	}

	@RequestMapping("refundListInfo.do")
	public String getRefundList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".getRefundList");
		logger.info("   - paramMap : " + paramMap);

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		logger.info("After putting pageIndex, pageSize, paramMap:" + paramMap);

		// tb_order 테이블에서 STTcd가 (3-반품대기,4-승인대기(반품),5-승인완료(반품), 6-반품진행중,
		// 7-반품완료)인 주문만 보이도록
		List<ScmRefundListModel> refundList = scmRefundListService.getRefundList(paramMap);
		model.addAttribute("refundList", refundList);

		int refundListCnt = scmRefundListService.getRefundListCnt(paramMap);
		model.addAttribute("refundListCnt", refundListCnt);

		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage", currentPage);

		logger.info("+ end " + className + ".getRefundList");

		return "/scm/refundListInfo";
	}
	
	@RequestMapping("refundDetailInfo.do")
	public String getRefundDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".getRefundDetail");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginId", session.getAttribute("loginId"));	// SCM 관리자 아이디

		ScmRefundListModel refundDetail = scmRefundListService.getRefundDetail(paramMap);
		String scmManager = scmRefundListService.getScmManagerName(paramMap);
		refundDetail.setScmManager(scmManager);
		
		model.addAttribute("refundDetail", refundDetail);

		logger.info("+ end " + className + ".getRefundDetail");

		return "/scm/refundDetail";
	}
}
