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
  
  //공급처 조회
  @RequestMapping("listProduct.do")
  public String listProduct(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception{
    
    int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));  // 현재 페이지 번호
    int pageSize    = Integer.parseInt((String)paramMap.get("pageSize"));      // 페이지 사이즈
    int pageIndex   = (currentPage -1)*pageSize;                  // 페이지 시작 row 번호
    
    paramMap.put("pageIndex", pageIndex);
    paramMap.put("pageSize", pageSize);
    
    // 공급처 목록 조회
    List<OrderModel> listProductModel = orderService.listProduct(paramMap);
    model.addAttribute("listProductModel", listProductModel);
    
    // 공급처 목록 카운트 조회
    int totalCount = orderService.totalCntProduct(paramMap);
    model.addAttribute("totalProduct", totalCount);
    
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPageProduct",currentPage);  
    
    return "ctm/listProduct";
  }
  
//공급처 저장
 @RequestMapping("saveProduct.do")
 @ResponseBody
 public Map<String, Object> saveProduct (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
     HttpServletResponse response, HttpSession session) throws Exception{
   
   String action = (String)paramMap.get("action");
   
   String result = "SUCCESS";
   String resultMsg = "";
   
   if("I".equals(action)){
     //공급처등록
     orderService.insertProduct(paramMap);
     resultMsg = "등록 완료";
   } else if("U".equals(action)){
     //공급처 수정
     orderService.updateProduct(paramMap);
     resultMsg = "수정 완료";
   } else if("D".equals(action)){
     //공급처 삭제
     orderService.deleteProduct(paramMap);
     resultMsg = "삭제 완료";
   }
   else{
     result = "FALSE";
     resultMsg = "저장 실패";
   }
   
   Map<String, Object> resultMap = new HashMap<String, Object>();
   resultMap.put("result", result);
   resultMap.put("resultMsg", resultMsg);
   
   return resultMap;
 }
  
  //공급처 단건 조회
  @RequestMapping("selectProduct.do")
  @ResponseBody
  public Map<String, Object> selectProduct (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception{

    String result = "SUCCESS";
    String resultMsg = "조회 되었습니다.";
    
    OrderModel productInfoModel = orderService.selectProduct(paramMap);
    
    Map<String, Object> resultMap = new HashMap<String, Object>();
    resultMap.put("result", result);
    resultMap.put("resultMsg", resultMsg);
    resultMap.put("productInfoModel", productInfoModel);
    
    System.out.println(resultMap);
    return resultMap;
  }
  

  
}