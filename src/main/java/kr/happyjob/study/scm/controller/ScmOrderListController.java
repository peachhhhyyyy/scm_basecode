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

import kr.happyjob.study.scm.model.DeliveryInfoModel;
import kr.happyjob.study.scm.model.ProductInfoModel;
import kr.happyjob.study.scm.model.ScmOrderListModel;
import kr.happyjob.study.scm.service.ScmOrderListService;

@Controller
@RequestMapping("/scm")
public class ScmOrderListController {

	@Autowired
	ScmOrderListService scmOrderListService;

	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("scmOrderList.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".init");

		/* ############## set input data################# */
		paramMap.put("loginId", session.getAttribute("loginId")); // 로그인 아이디
		paramMap.put("userType", session.getAttribute("userType")); // 유저 타입
		paramMap.put("reg_date", session.getAttribute("reg_date")); // 가입일

		logger.info("   - paramMap : " + paramMap);

		logger.info("+ end " + className + ".init");

		return "/scm/orderList";
	}

	@RequestMapping("listInfo.do")
	public String getOrderList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".listInfo");

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		logger.info("After putting pageIndex, pageSize, paramMap:" + paramMap);
		
		logger.info("startDate: " + paramMap.get("startDate"));
		
		// paramMap에 check(배송상태 체크박스)가 있으면 걸러내기
		ArrayList<Integer> checkedStateList = new ArrayList<Integer>(); 
		paramMap.forEach((key, value) -> {
			System.out.println(String.format("key -> %s, value -> %s", key, value));
			if (key.substring(0, 5).equals("check")) {
				checkedStateList.add(Integer.parseInt((String) value));
			}
		});
		logger.info("checkedStateList: "+checkedStateList);
		paramMap.put("checkedStateList", checkedStateList);
		
		// 수주내역 목록 조회
		List<ScmOrderListModel> orderList = scmOrderListService.getOrderList(paramMap);
		model.addAttribute("orderList", orderList);

		// 수주내역 목록 갯수 추출
		int orderListCnt = scmOrderListService.getOrderListCnt(paramMap);
		model.addAttribute("orderListCnt", orderListCnt);

		// 페이징 처리에 사용될 값들
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage", currentPage);

		logger.info("+ end " + className + ".listInfo");

		return "/scm/listInfo";
	}

	@RequestMapping("productInfo.do")
	public String productInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".productInfo");

		paramMap.put("loginId", session.getAttribute("loginId")); // 로그인 아이디,
																	// SCM 관리자명
																	// 가져올 때 쓰임
		logger.info("paramMap:" + paramMap);

		ProductInfoModel productInfo = scmOrderListService.getProductInfo(paramMap);
		String scmManager = scmOrderListService.getScmManagerName(paramMap);
		productInfo.setScmManager(scmManager);

		model.addAttribute("productInfo", productInfo);

		logger.info("+ end " + className + ".productInfo");

		return "/scm/productInfo";
	}

	@RequestMapping("deliveryInfo.do")
	public String deliveryInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".deliveryInfo");

		String loginId = (String) session.getAttribute("loginId");

		paramMap.put("loginId", loginId); // 로그인 아이디, SCM 관리자명 가져올 때 쓰임
		logger.info("paramMap:" + paramMap);

		DeliveryInfoModel deliveryInfo = scmOrderListService.getDeliveryInfo(paramMap);
		String scmManager = scmOrderListService.getScmManagerName(paramMap);
		deliveryInfo.setScmManager(scmManager);

		model.addAttribute("deliveryInfo", deliveryInfo);

		logger.info("+ end " + className + ".deliveryInfo");

		return "/scm/deliveryInfo";
	}

	@RequestMapping("sendDeliveryDirection.do")
	@ResponseBody
	public Map<String, String> sendDeliveryDirection(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".sendDeliveryDirection");

		String loginId = (String) session.getAttribute("loginId");

		paramMap.put("loginId", loginId); // 로그인 아이디, SCM 관리자명 가져올 때 쓰임
		logger.info("paramMap:" + paramMap);

		// 해당 주문 상태 '배송준비'로 업데이트
		Map<String, String> resultMap = scmOrderListService.updateState(paramMap);

		// 해당 배송지시서 내용을 DB 배송지시서 테이블에 INSERT
		scmOrderListService.insertData(paramMap);

		logger.info("+ end " + className + ".sendDeliveryDirection");

		return resultMap;
	}

	@RequestMapping("sendPurchaseDirection.do")
	@ResponseBody
	public Map<String, String> sendPurchaseDirection(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".sendPurchaseDirection");

		String loginId = (String) session.getAttribute("loginId");

		paramMap.put("loginId", loginId); // 로그인 아이디, SCM관리자id 가져올 때 쓰임
		logger.info("paramMap:" + paramMap);

		// 해당 주문 상태 '승인대기(발주)'로 업데이트
		Map<String, String> resultMap = scmOrderListService.updateState(paramMap);

		// 해당 발주지시서 내용을 DB '발주지시서 테이블'에 INSERT
		scmOrderListService.insertData(paramMap);

		logger.info("+ end " + className + ".sendPurchaseDirection");

		return resultMap;
	}

}