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

import kr.happyjob.study.scm.model.WarehouseInfoModel;
import kr.happyjob.study.scm.service.WarehouseInfoService;

@Controller
@RequestMapping("/scm")
public class WarehouseInfoController {
  @Autowired // 묶어준다
  WarehouseInfoService warehouseInfoService;
  
  private static final Logger logger = LoggerFactory.getLogger(WarehouseInfoController.class);
  private final String className = this.getClass().toString();
  
  @RequestMapping("warehouseInfo.do")
  public String initWarehouseInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession Session) throws Exception {
    
    logger.info("+ Start " + className + ".initWarehouseInfo");
    logger.info("   - paramMap : " + paramMap);
    
    logger.info("+ End " + className + ".initWarehouseInfo");
    
    return "scm/warehouseInfo";
    
  }
  
  // 창고 조회
  @RequestMapping("listWarehouse.do")
  public String listWarehouse(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
    
    logger.info("+ Start " + className + ".listWarehouse");
    logger.info("   - paramMap : " + paramMap);
    
    int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재 페이지 번호
    int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); // 페이지 사이즈
    int pageIndex = (currentPage - 1) * pageSize; // 페이지 시작 row 번호
    
    paramMap.put("pageIndex", pageIndex);
    paramMap.put("pageSize", pageSize);
    
    // 창고 목록 조회
    List<WarehouseInfoModel> listWarehouseModel = warehouseInfoService.listWarehouse(paramMap);
    model.addAttribute("listWarehouseModel", listWarehouseModel);
    
    // 창고 목록 카운트 조회
    int totalCount = warehouseInfoService.totalCntWarehouse(paramMap);
    model.addAttribute("totalWarehouse", totalCount);
    
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPageWarehouse", currentPage);
    
    logger.info("+ End " + className + ".listWarehouse");
    
    return "scm/listWarehouse";
  }
  
  //제품 조회
  @RequestMapping("listWarehouseProduct.do")
  public String listWarehouseProduct(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception{
    
    logger.info("+ Start " + className + ".listWarehouseProduct");
    logger.info("   - paramMap : " + paramMap);
    
    
    int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));  // 현재 페이지 번호
    int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));      // 페이지 사이즈
    int pageIndex = (currentPage-1)*pageSize;                 // 페이지 시작 row 번호
    
    paramMap.put("pageIndex", pageIndex);
    paramMap.put("pageSize", pageSize);
    
    // 제품 목록 조회
    List<WarehouseInfoModel> listWarehouseProductModel = warehouseInfoService.listWarehouseProduct(paramMap);
    model.addAttribute("listWarehouseProductModel", listWarehouseProductModel);
    
    // 제품 목록 카운트 조회
    int totalCount = warehouseInfoService.totalCntProduct(paramMap);
    model.addAttribute("totalProduct", totalCount);
    
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPageProduct",currentPage);
    
    logger.info("+ End " + className + ".listWarehouseProduct");
    
    
    return "scm/listWarehouseProduct";
  }
  
}
