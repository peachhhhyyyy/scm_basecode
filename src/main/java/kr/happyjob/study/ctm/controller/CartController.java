package kr.happyjob.study.ctm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
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

import kr.happyjob.study.ctm.model.CartModel;
import kr.happyjob.study.ctm.service.CartService;


@Controller
@RequestMapping("/ctm")

public class CartController {
	@Autowired
	CartService CartService;
	
	
	/* 지출결의서 초기화면 호출   */
	
	@RequestMapping("cart.do")
	public String initComnCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		return "ctm/cart"; /* 호출할 jsp 파일명 */
	}
	
	/**
	 * 지출결의서 목록 조회
	 */
	@RequestMapping("listCart.do")
	public String listCart(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize    = Integer.parseInt((String)paramMap.get("pageSize"));	    // 페이지 사이즈
		int pageIndex   = (currentPage-1)*pageSize;								    // 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 공통 그룹코드 목록 조회
		List<CartModel> listCartModel = CartService.listCart(paramMap);
		model.addAttribute("listCartModel", listCartModel);
		
		// 공통 그룹코드 목록 카운트 조회
		int totalCount = CartService.countListCart(paramMap);
		model.addAttribute("totalCntCart", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageCart",currentPage);
		
		return "ctm/cartList";
	}	
	
}
