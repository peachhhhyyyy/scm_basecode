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

import kr.happyjob.study.scm.model.ProductInfoModel;
import kr.happyjob.study.scm.model.ScmOrderListModel;
import kr.happyjob.study.scm.service.ScmOrderListService;

@Controller
@RequestMapping("/scm")
public class ScmOrderListController {
	
	@Autowired
	ScmOrderListService ScmOrderListService;
	
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

		String returnType = "/scm/orderList";

		logger.info("+ end " + className + ".init");

		return returnType;
	}
	
	@RequestMapping("listInfo.do")
	public String getOrderList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	    int pageIndex = (currentPage - 1) * pageSize;
	    
	    paramMap.put("pageIndex", pageIndex);
	    paramMap.put("pageSize", pageSize);
	    logger.info("After putting pageIndex, pageSize, paramMap:" + paramMap);
	    
	    // 수주내역 목록 조회
	    List<ScmOrderListModel> orderList = ScmOrderListService.getOrderList(paramMap);
	    model.addAttribute("orderList", orderList);
	    
	    // 수주내역 목록 갯수 추출
	    int orderListCnt = ScmOrderListService.getOrderListCnt(paramMap);
	    model.addAttribute("orderListCnt", orderListCnt);
	    
	    // 페이징 처리에 사용될 값들
	    model.addAttribute("pageSize", pageSize);
	    model.addAttribute("currentPage", currentPage);
	    
		
		return "/scm/listInfo";
	}
	
	@RequestMapping("productInfo.do")
	public String productInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		paramMap.put("loginId", session.getAttribute("loginId")); // 로그인 아이디
	    logger.info("paramMap:" + paramMap);
	    
	    ProductInfoModel productInfo = ScmOrderListService.getProductInfo(paramMap);
		String scmManager = ScmOrderListService.getScmManagerName(paramMap);
		
		productInfo.setScmManager(scmManager);

		logger.info("productInfo.getProductName: " + productInfo.getProductName());
		logger.info("productInfo.getScmManager: " + productInfo.getScmManager());
	    
		return "/scm/productInfo";
	}

}