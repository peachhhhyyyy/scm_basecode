package kr.happyjob.study.scm.controller;

import java.util.HashMap;
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

import kr.happyjob.study.scm.model.ScmPurchaseModel;
import kr.happyjob.study.scm.service.ScmPurchaseService;

@Controller
@RequestMapping("/scm/")
public class ScmPurchaseController {
  
  @Autowired
  ScmPurchaseService scmPcsService;
  
  private final Logger logger = LogManager.getLogger(this.getClass());

  // Get class name for logger
  private final String className = this.getClass().toString();

  // 처음 로딩될 때 발주지시서 목록 연결
  @RequestMapping("scmPurchaseMain.do")
  public String scmPurchaseMain(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {
    
    return "scm/scmPurchaseMain";
  }
  
  // 발주지시서 목록 조회
  @RequestMapping("scmPurchaseList.do")
  public String scmPurchaseList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session, @RequestParam Map<String, Object> param) throws Exception {
    
    logger.info("+ Start " + className + ".scmPurchaseList");
    logger.info("   - paramMap : " + paramMap);
    
    int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));  // 현재 페이지 번호
    int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));      // 페이지 사이즈
    int pageIndex = (currentPage-1)*pageSize;                       // 페이지 시작 row 번호
        
    paramMap.put("pageIndex", pageIndex);
    paramMap.put("pageSize", pageSize);
    
    // 값이 없는 경우 주의 (분기 처리 해야 함)
    String date1 = (String) param.get("date");
    String date2 = (String) param.get("date");
   
    System.out.println("날짜 1 : " + date1);
    System.out.println("날짜 2 : " + date2);
    
    param.put("date1", date1);
    param.put("date2", date2);
    
    logger.info("   - paramMap : " + paramMap);

    // 발주지시서 목록 조회
    List<ScmPurchaseModel> scmPurchaseOrderingOrderModel = scmPcsService.scmPcsOrderingOrder(paramMap);
    model.addAttribute("scmPurchaseOrderingOrderModel", scmPurchaseOrderingOrderModel);
    
    // 발주지시서 목록 카운트 조회
    int totalCount =  scmPcsService.countScmPcsOrderingOrder(paramMap);
    model.addAttribute("totalCount", totalCount);
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPage", currentPage);
    
    logger.info("+ End " + className + ".scmPurchaseList");
    
    return "scm/scmPurchaseList";
  } 
 
  // 발주 버튼 클릭 시 모달팝업 창 띄우기
  @RequestMapping("selectPurchBtn.do")
  @ResponseBody
  public Map<String, Object> selectPurchBtn(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {
    
    logger.info("+ Start " + className + ".selectPurchBtn");
    logger.info("   - paramMap : " + paramMap);
    
    String result = "SUCCESS";
    String resultMsg = "전송 되었습니다.";
   
    ScmPurchaseModel scmPurchaseModel = scmPcsService.selectPurchBtn(paramMap);
    
    Map<String, Object> resultMap = new HashMap<String, Object>();
    resultMap.put("result", result);
    resultMap.put("resultMsg", resultMsg);
    resultMap.put("scmPurchaseModel", scmPurchaseModel);
    
    logger.info("+ End " + className + ".selectPurchBtn");
    
    return resultMap;
  }
}
