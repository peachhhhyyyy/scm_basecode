package kr.happyjob.study.ctm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.ctm.model.OrderModel;
import kr.happyjob.study.ctm.service.OrderService;

@Controller
@RequestMapping("/ctm")
public class OrderController {
  @Autowired //묶어준다
  OrderService orderService;
  
  
  @RequestMapping("order.do")
  public String initOrder(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession Session) throws Exception{
 
    return "ctm/order";
  }
  
  // 주문 화면 조회
  @RequestMapping("listProduct.do")
  public String listProduct(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception{
    
    int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));  // 현재 페이지 번호
    int pageSize    = Integer.parseInt((String)paramMap.get("pageSize"));      // 페이지 사이즈
    int pageIndex   = (currentPage -1)*pageSize;                  // 페이지 시작 row 번호
    
    paramMap.put("pageIndex", pageIndex);
    paramMap.put("pageSize", pageSize);
    
    // 제품 목록 조회
    List<OrderModel> listProductModel = orderService.listProduct(paramMap);
    model.addAttribute("listProductModel", listProductModel);
    
    // 제품 총 개수 조회
    int totalCount = orderService.totalCntProduct(paramMap);
    model.addAttribute("totalProduct", totalCount);
    
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPageProduct",currentPage);  
    
    return "ctm/listProduct";
  }  
}