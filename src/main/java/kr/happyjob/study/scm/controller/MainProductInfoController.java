package kr.happyjob.study.scm.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.scm.model.MainProductInfoModel;
import kr.happyjob.study.scm.service.MainProductInfoService;

@Controller
@RequestMapping("/scm")
public class MainProductInfoController {
  @Autowired
  MainProductInfoService mainProductInfoService;
  
  private static final Logger logger = LoggerFactory.getLogger(MainProductInfoController.class);
  private final String className = this.getClass().toString();
  
  @RequestMapping("mainProductInfo.do")
  public String initMainProductInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession Session) throws Exception {
    
    logger.info("+ Start " + className + ".initMainProductInfo");
    logger.info("   - paramMap : " + paramMap);
    
    logger.info("+ End " + className + ".initMainProductInfo");
    
    return "scm/mainProductInfo";
  }
  
 //제품 조회
 @RequestMapping("listMainProduct.do")
 public String listWarehouse(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
   
   logger.info("+ Start " + className + ".listWarehouse");
   logger.info("   - paramMap : " + paramMap);
   
   int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재 페이지 번호
   int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); // 페이지 사이즈
   int pageIndex = (currentPage - 1) * pageSize; // 페이지 시작 row 번호
   
   paramMap.put("pageIndex", pageIndex);
   paramMap.put("pageSize", pageSize);
   
   // 제품 목록 조회
   List<MainProductInfoModel> listMainProductModel = mainProductInfoService.listMainProduct(paramMap);
   model.addAttribute("listMainProductModel", listMainProductModel);
   
   // 제품 목록 카운트 조회
   int totalCount = mainProductInfoService.totalCntMainProduct(paramMap);
   model.addAttribute("totalMainProduct", totalCount);
   
   model.addAttribute("pageSize", pageSize);
   model.addAttribute("currentPageMainProduct", currentPage);
   
   logger.info("+ End " + className + ".listMainProduct");
   
   return "scm/listMainProduct";
 }
}
