package kr.happyjob.study.scm.controller;

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
  
  //상호 조회
  @RequestMapping("listMiddleCategory.do")
  public String listMiddleCategory(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception{
    
    int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));  // 현재 페이지 번호
    int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));      // 페이지 사이즈
    int pageIndex = (currentPage-1)*pageSize;                 // 페이지 시작 row 번호
    
    
    paramMap.put("pageIndex", pageIndex);
    paramMap.put("pageSize", pageSize);
   
    
    // 제품 목록 조회
    List<CategoryInfoModel> listMiddleCategoryModel = categoryInfoService.listMiddleCategory(paramMap);
    model.addAttribute("listMiddleCategoryModel", listMiddleCategoryModel);
    
    // 제품 목록 카운트 조회
    int totalCount = categoryInfoService.totalCntMiddleCategory(paramMap);
    model.addAttribute("totalMiddleCategory", totalCount);
    
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPageMiddleCategory",currentPage);
    
    
    return "scm/listMiddleCategory";
  }
  
  //품목 단건 조회
  @RequestMapping("selectLargeCategory.do")
  @ResponseBody
  public Map<String, Object> selectLargeCategory (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception{

    String result = "SUCCESS";
    String resultMsg = "조회 되었습니다.";
    
    CategoryInfoModel categoryInfoModel = categoryInfoService.selectLargeCategory(paramMap);
    
    Map<String, Object> resultMap = new HashMap<String, Object>();
    resultMap.put("result", result);
    resultMap.put("resultMsg", resultMsg);
    resultMap.put("categoryInfoModel", categoryInfoModel);
    
    System.out.println(resultMap);
    return resultMap;
  }
  
 //품목 저장
 @RequestMapping("saveLargeCategory.do")
 @ResponseBody
 public Map<String, Object> saveLargeCategory (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
     HttpServletResponse response, HttpSession session) throws Exception{
   
   String action = (String)paramMap.get("action");
   
   String result = "SUCCESS";
   String resultMsg = "";
   
   if("I".equals(action)){
     //공급처등록
     int saveResult = categoryInfoService.insertLargeCategory(paramMap);
     if (saveResult == 0) {
       result = "FAIL";
       resultMsg = "중복된 코드입니다.";
     } else{
     resultMsg = "등록 완료"; }
   } else if("U".equals(action)){
     //공급처 수정
     categoryInfoService.updateLargeCategory(paramMap);
     resultMsg = "수정 완료";
   } else if("D".equals(action)){
     //공급처 삭제
    int deleteResult = categoryInfoService.deleteLargeCategory(paramMap);
    if (deleteResult == 0) {
      result = "FAIL";
      resultMsg = "삭제가 실패하였습니다.\n해당 품목을 참조하는 상호를 확인해주세요.";
    } else {
      resultMsg = "삭제 완료";
    }     
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
  
  //상호 단건 조회
  @RequestMapping("selectMiddleCategory.do")
  @ResponseBody
  public Map<String, Object> selectMiddleCategory (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception{

    String result = "SUCCESS";
    String resultMsg = "조회 되었습니다.";
    
    CategoryInfoModel categoryInfoModel = categoryInfoService.selectMiddleCategory(paramMap);
    
    Map<String, Object> resultMap = new HashMap<String, Object>();
    resultMap.put("result", result);
    resultMap.put("resultMsg", resultMsg);
    resultMap.put("categoryInfoModel", categoryInfoModel);
    
    System.out.println(resultMap);
    return resultMap;
  }
  
 //상호 저장
 @RequestMapping("saveMiddleCategory.do")
 @ResponseBody
 public Map<String, Object> saveMiddleCategory (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
     HttpServletResponse response, HttpSession session) throws Exception{
   
   String action = (String)paramMap.get("Maction");
   
   String result = "SUCCESS";
   String resultMsg = "";
   
   if("I".equals(action)){
     //공급처등록
     int saveResult = categoryInfoService.insertMiddleCategory(paramMap);
     if (saveResult == 0) {
       result = "FAIL";
       resultMsg = "중복된 코드입니다.";
     } else{
     resultMsg = "등록 완료"; }
   } else if("U".equals(action)){
     //공급처 수정
     categoryInfoService.updateMiddleCategory(paramMap);
     resultMsg = "수정 완료";
   } else if("D".equals(action)){
     //공급처 삭제
    int deleteResult = categoryInfoService.deleteMiddleCategory(paramMap);
    if (deleteResult == 0) {
      result = "FAIL";
      resultMsg = "삭제가 실패하였습니다.\n해당 품목을 참조하는 제품을 확인해주세요.";
    } else {
      resultMsg = "삭제 완료";
    }     
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
}