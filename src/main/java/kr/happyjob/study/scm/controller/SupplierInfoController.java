package kr.happyjob.study.scm.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.scm.service.SupplierInfoService;


@Controller
@RequestMapping("/scm")
public class SupplierInfoController {
  @Autowired
  SupplierInfoService supplierInfoService;
  
  // 1. 초기화면 호출
  @RequestMapping("supplierInfo.do")
  public String supplierInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
    HttpServletResponse response, HttpSession session) throws Exception {
    
    return "scm/supplierInfo";   
  }
  
  // 2. 공급처정보 목록 ajax 통신
  @RequestMapping("supplierList.do")
  public String supplierList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {
    
    int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));  // 현재 페이지 번호
    int pageSize    = Integer.parseInt((String)paramMap.get("pageSize"));     // 페이지 사이즈
    int pageIndex   = (currentPage-1)*pageSize;
    
    paramMap.put("pageIndex", pageIndex);
    paramMap.put("pageSize", pageSize);
    
    // 상품 목록 조회
    List<SupplierInfoModel> supplierInfoModelList = supplierInfoService.selectSupplierInfo(paramMap);
    model.addAttribute("supplierInfoModelList", supplierInfoModelList);
    
    // 상품 목록 카운트 조회
    int totalCount = supplierInfoService.countSupplierInfo(paramMap);
    model.addAttribute("totalCount", totalCount);
    
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPage",currentPage);
    
    return "scm/supplierList";
  }
}
