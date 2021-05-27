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

import kr.happyjob.study.scm.model.CusInfoModel;
import kr.happyjob.study.scm.service.CusInfoService;

@Controller
@RequestMapping("/scm")
public class CusInfoController {
	
  @Autowired // 묶어준다
  CusInfoService cusInfoService;
  
  private static final Logger logger = LoggerFactory.getLogger(CusInfoController.class);
  
  @RequestMapping("cusinfo.do")
  public String cusinfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession Session) throws Exception {
    
    logger.info("===== 기업고객 관리 페이지 =====");
    
    return "scm/cusInfo";
    
  }
  
  // 창고 조회
  @RequestMapping("cusListInfo.do")
  public String cusListInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
    
    int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재 페이지 번호
    int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); // 페이지 사이즈
    int pageIndex = (currentPage - 1) * pageSize; // 페이지 시작 row 번호
    
    paramMap.put("pageIndex", pageIndex);
    paramMap.put("pageSize", pageSize);
    
    logger.info("===== cusListInfo paramMap ===== : " + paramMap);
    
    // 기업 목록 조회
    List<CusInfoModel> cusList = cusInfoService.cusList(paramMap);
    model.addAttribute("cusList", cusList);
    
    // 기업 목록 조회 카운트
    int cusListCnt = cusInfoService.cusListCnt(paramMap);
    model.addAttribute("cusListCnt", cusListCnt);
    
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPageWarehouse", currentPage);
    
    
    return "scm/cusInfoList";
  }
  
}
