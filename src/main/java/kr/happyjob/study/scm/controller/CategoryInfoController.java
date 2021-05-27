package kr.happyjob.study.scm.controller;

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

import kr.happyjob.study.scm.model.CategoryInfoModel;
import kr.happyjob.study.scm.service.CategoryInfoService;

@Controller
@RequestMapping("/scm")
public class CategoryInfoController {
  @Autowired
  CategoryInfoService categoryInfoService;
  
  @RequestMapping("categoryInfo.do")
  public String initcategoryInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession Session) throws Exception{
 
    return "scm/categoryInfo";
  }
  
  //품목 조회
  @RequestMapping("listLargeCategory.do")
  public String listLargeCategory(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception{
    
    int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));  // 현재 페이지 번호
    int pageSize    = Integer.parseInt((String)paramMap.get("pageSize"));      // 페이지 사이즈
    int pageIndex   = (currentPage -1)*pageSize;                  // 페이지 시작 row 번호
    
    paramMap.put("pageIndex", pageIndex);
    paramMap.put("pageSize", pageSize);
    
    // 공급처 목록 조회
    List<CategoryInfoModel> listLargeCategoryModel = categoryInfoService.listLargeCategory(paramMap);
    model.addAttribute("listLargeCategoryModel", listLargeCategoryModel);
    
    // 공급처 목록 카운트 조회
    int totalCount = categoryInfoService.totalCntLargeCategory(paramMap);
    model.addAttribute("totalLargeCategory", totalCount);
    
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPageLargeCategory",currentPage);  
    
    return "scm/listLargeCategory";
  }
}