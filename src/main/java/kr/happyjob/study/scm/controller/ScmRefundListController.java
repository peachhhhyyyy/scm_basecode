package kr.happyjob.study.scm.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;

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
		
		logger.info("startDate: " + paramMap.get("startDate"));
		logger.info("searchType: " + paramMap.get("searchType"));
		logger.info("keyword: " + paramMap.get("keyword"));
		
		// paramMap에 check_[number] 가 있으면 ArrayList에 담기
		ArrayList<Integer> checkedStateList = new ArrayList<Integer>(); 
		paramMap.forEach((key, value) -> {
			System.out.println(String.format("key -> %s, value -> %s", key, value));
			if (key.substring(0, 5).equals("check")) {
				checkedStateList.add(Integer.parseInt((String) value));
			}
		});
		logger.info("checkedStateList: "+checkedStateList);
		// checkList paramMap에 담기
		paramMap.put("checkedStateList", checkedStateList);
		
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
	
	@RequestMapping("refundDirectionInsert.do")
	@ResponseBody
	public Map<String, String> sendRefundDirection(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".sendRefundDirection");
		
		paramMap.put("loginId", session.getAttribute("loginId"));
		logger.info("   - paramMap : " + paramMap);

		// 해당 주문 상태 '승인대기(반품)'으로 업데이트
		Map<String, String> resultMap = scmRefundListService.updateState(paramMap);
		
		// 해당 반품 내용을 DB '반품지시서 테이블'에 INSERT
		int insertResult = scmRefundListService.insertData(paramMap);
		if (insertResult == 1) {
			logger.info("====== 반품지시서 INSERT 성공 ======");
		} else {
			logger.info("====== 반품지시서 INSERT 실패 ======");
		}
		
		logger.info("+ end " + className + ".sendRefundDirection");

		return resultMap;
	}
}
