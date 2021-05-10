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

import kr.happyjob.study.scm.model.ProdInfoModel;
import kr.happyjob.study.scm.service.ProdInfoService;


@Controller
@RequestMapping("/scm")

public class ProdInfoController {
  @Autowired
  ProdInfoService ProdInfoService;
  
  
  /* 지출결의서 초기화면 호출   */
  
  @RequestMapping("ProdInfo.do")
  public String initComnCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {
    
    return "scm/ProdInfo"; /* 호출할 jsp 파일명 */
  }
  
  /**
   * 지출결의서 목록 조회
   */
  @RequestMapping("listProdInfo.do")
  public String listProdInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {
    
    
    int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));  // 현재 페이지 번호
    int pageSize    = Integer.parseInt((String)paramMap.get("pageSize"));     // 페이지 사이즈
    int pageIndex   = (currentPage-1)*pageSize;                   // 페이지 시작 row 번호
        
    paramMap.put("pageIndex", pageIndex);
    paramMap.put("pageSize", pageSize);
    
    // 공통 그룹코드 목록 조회
    List<ProdInfoModel> listProdInfoModel = ProdInfoService.listProdInfo(paramMap);
    model.addAttribute("listProdInfoModel", listProdInfoModel);
    
    // 공통 그룹코드 목록 카운트 조회
    int totalCount = ProdInfoService.countListProdInfo(paramMap);
    model.addAttribute("totalCntProdInfo", totalCount);
    
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPageProdInfo",currentPage);
    
    return "scm/ProdInfoList";
  } 
  
}
