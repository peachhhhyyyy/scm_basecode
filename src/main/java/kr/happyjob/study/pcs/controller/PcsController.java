package kr.happyjob.study.pcs.controller;

import java.util.List;
import java.util.Map;

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

import kr.happyjob.study.pcs.model.PcsModel;
import kr.happyjob.study.pcs.service.PcsService;

@Controller
@RequestMapping("/pcs/") // 여기서 선언한 것은 상위 path명
public class PcsController {
  
  @Autowired
  PcsService pcsService;
  
  private final Logger logger = LogManager.getLogger(this.getClass());

  // Get class name for logger
  private final String className = this.getClass().toString();

  // 처음 로딩될 때 발주지시서 목록 연결
  @RequestMapping("pcsOrderingOrder.do")
  public String pcsOrderingOrder(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {
   
    //logger.info("#####################" + model);

    return "pcs/pcsOrderingOrder";
  }
  
  // 공통 그룹 코드 목록 조회
  @RequestMapping("listPcsOrderingOrder.do")
  public String listComnGrpCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {
    
    logger.info("+ Start " + className + ".listPcsOrderingOrder");
    logger.info("   - paramMap : " + paramMap);
    
    int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));  // 현재 페이지 번호
    int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));      // 페이지 사이즈
    int pageIndex = (currentPage-1)*pageSize;                       // 페이지 시작 row 번호
        
    paramMap.put("pageIndex", pageIndex);
    paramMap.put("pageSize", pageSize);

    // 공통 그룹코드 목록 조회
    List<PcsModel> listPcsOrderingOrderModel = pcsService.pcsOrderingOrder(paramMap);
    model.addAttribute("listPcsOrderingOrderModel", listPcsOrderingOrderModel);

    // 공통 그룹코드 목록 카운트 조회
    int totalCount =  pcsService.countPcsOrderingOrder(paramMap);
    model.addAttribute("totalCount", totalCount);
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPage", currentPage);
    
    logger.info("+ End " + className + ".listPcsOrderingOrder");
    
    return "pcs/listPcsOrderingOrder";
  } 
  
  // 처음 로딩될 때 발주서 연결
  @RequestMapping("pcsOrderForm.do")
  public String pcsOrderForm(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {
   
    return "pcs/pcsOrderForm";
  }
}