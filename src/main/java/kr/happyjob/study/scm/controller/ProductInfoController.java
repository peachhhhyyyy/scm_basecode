package kr.happyjob.study.scm.controller;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.happyjob.study.scm.model.ProductInfoModel;
import kr.happyjob.study.scm.service.ProductInfoService;


@Controller
@RequestMapping("/scm")

public class ProductInfoController {
  @Autowired
  ProductInfoService productInfoService;
  
  
   // 초기화면 호출   
  //ProductInfo
  @RequestMapping("productInfo.do")
  public String ProductInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {
    
    return "scm/productInfo"; /* 호출할 jsp 파일명 */
  }
  
  // 2. 제품정보 목록 ajax 통신
  @RequestMapping("productList.do")
  public String productList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {
    
    
    int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));  // 현재 페이지 번호
    int pageSize    = Integer.parseInt((String)paramMap.get("pageSize"));     // 페이지 사이즈
    int pageIndex   = (currentPage -1)*pageSize;                   // 페이지 시작 row 번호
        
    paramMap.put("pageIndex", pageIndex);
    paramMap.put("pageSize", pageSize);
    
    // 상품 목록 조회
    List<ProductInfoModel> ProductInfoModelList = productInfoService.selectProductInfo(paramMap);
    model.addAttribute("ProductInfoModelList", ProductInfoModelList);
    
    // 상품 목록 카운트 조회
    int totalCount = productInfoService.countProductInfo(paramMap);
    model.addAttribute("totalCount", totalCount);

    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPage",currentPage);
    
    return "scm/productList";
  } 
  
//  //3. 제품 단일 정보 ajax 통신
// @RequestMapping("detailProduct.do")
// @ResponseBody
// public Map<String,Object> detailProduct(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
//     HttpServletResponse response, HttpSession session) throws Exception {
//   
//     
//   String resultMsg="";
//   
//   // 선택 제품 정보 조회 ( 창고 여러개 넣어져 있을 시 여러 개 리턴) 
//   List<ProductInfoModel> detail = productInfoService.selectProductDetail(paramMap); // <- 임시수정했음
//   //List<CommentsVO> comments = null;
//   
//   if(detail != null) {
//     
//     resultMsg = "SUCCESS";  // 성공시 찍습니다. 
//     
//   }else {
//     resultMsg = "FAIL / 불러오기에 실패했습니다.";  // null이면 실패입니다.
//   }
//   
//   Map<String, Object> resultMap = new HashMap<String, Object>();
//   resultMap.put("result", detail); // 리턴 값 해쉬에 담기 
//   resultMap.put("resultMsg", resultMsg); // success 용어 담기 
//     
//   return resultMap;
// }   
// 
//   //4. 제품 정보 및 파일 등록
//   @ResponseBody
//    @RequestMapping("productSave.do")
//       public Map<String,Object> productSave(Model model, @RequestParam Map<String,Object> paramMap, MultipartHttpServletRequest request,
//       HttpServletResponse response, HttpSession session) throws Exception {
//  
//      Map<String, Object> resultMap = new HashMap<String, Object>();
//  String resultMsg = "";
//  
//
//  String wareStr = (String) paramMap.get("ware_list");
//  String[] wareArray =  wareStr.split(",");
//  paramMap.put("ware_list", wareArray);
//  
//  boolean flag = productInfoService.insertProduct(paramMap, request);
//
//  if(flag) { resultMsg = "SUCCESS"; 
//  }else { 
//    resultMsg = "FAIL / 불러오기에 실패했습니다.";
//  }
//
//  resultMap.put("resultMsg", resultMsg); // success 용어 담기
//
//  return resultMap;
//}
// 
// 
//   // 5. 제품 정보 및 파일 삭제
//  @ResponseBody
//  @RequestMapping("productDel.do")
//  public Map<String,Object> productDel(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
//      HttpServletResponse response, HttpSession session) throws Exception {
// 
//    Map<String, Object> resultMap = new HashMap<String, Object>();
//    String resultMsg = "";
//    
//    boolean flag = productInfoService.deleteProduct(paramMap, request);
//    
//    if(flag) {
//      resultMsg = "SUCCESS";
//    }else {
//      resultMsg = "FAIL / 불러오기에 실패했습니다.";
//    }
//
//    resultMap.put("resultMsg", resultMsg); // success 용어 담기
//
//    return resultMap;   
//  }
//  
//  
//  
//  //6. 제품 정보 및 파일 수정
// @ResponseBody
// @RequestMapping("productUpd.do")
// public Map<String,Object> productUpd(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
//     HttpServletResponse response, HttpSession session) throws Exception {
//   Map<String, Object> resultMap = new HashMap<String, Object>();
//   String resultMsg = "";
//   
//   //여러개의 옵션을 배열에 담기 위해 일단 문자열로 변환 (1,2,3,4) 라잌댓
//       String wareStr = (String) paramMap.get("ware_list");
//       String[] wareArray =  wareStr.split(",");
//       paramMap.put("ware_list", wareArray);
//   
//   boolean flag = productInfoService.deleteProduct(paramMap, request);
//   
//   boolean flag2 = productInfoService.insertProduct(paramMap, request);
//   
//   if(flag && flag2) {
//     resultMsg = "SUCCESS";
//   }else {
//     resultMsg = "FAIL / 불러오기에 실패했습니다.";
//   }
//   
//   resultMap.put("resultMsg", resultMsg); // success 용어 담기
//   
//   return resultMap;
//   
// }
   
}