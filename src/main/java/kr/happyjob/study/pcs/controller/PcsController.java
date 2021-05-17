package kr.happyjob.study.pcs.controller;

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
   
    // 발주버튼 조회시 필요목록
    List<PcsModel> listPcsOrderingOrderModel = pcsService.pcsOrderingOrder(paramMap);
    model.addAttribute("listPcsOrderingOrderModel", listPcsOrderingOrderModel);
    
    return "pcs/pcsOrderingOrder";
  }
  
  // 발주지시서 목록 조회
  @RequestMapping("listPcsOrderingOrder.do")
  public String listPcsOrderingOrder(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {
    
    logger.info("+ Start " + className + ".listPcsOrderingOrder");
    logger.info("   - paramMap : " + paramMap);
    
    int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));  // 현재 페이지 번호
    int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));      // 페이지 사이즈
    int pageIndex = (currentPage-1)*pageSize;                       // 페이지 시작 row 번호
        
    paramMap.put("pageIndex", pageIndex);
    paramMap.put("pageSize", pageSize);
    
    logger.info("   - paramMap : " + paramMap);

    // 발주지시서 목록 조회
    List<PcsModel> listPcsOrderingOrderModel = pcsService.pcsOrderingOrder(paramMap);
    model.addAttribute("listPcsOrderingOrderModel", listPcsOrderingOrderModel);
    
    // 발주지시서 목록 카운트 조회
    int totalCount =  pcsService.countPcsOrderingOrder(paramMap);
    model.addAttribute("totalCount", totalCount);
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPage", currentPage);
    
    logger.info("+ End " + className + ".listPcsOrderingOrder");
    
    return "/pcs/listPcsOrderingOrder";
  } 
  
  // 발주 버튼 클릭 시 내용 전송
  @RequestMapping("selectPurchBtn.do")
  @ResponseBody
  public Map<String, Object> selectPurchBtn(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {
    
    logger.info("+ Start " + className + ".selectPurchBtn");
    logger.info("   - paramMap : " + paramMap);

    String result = "SUCCESS";
    String resultMsg = "전송 되었습니다.";
   
    PcsModel pcsModel = pcsService.selectPurchBtn(paramMap);
    
    Map<String, Object> resultMap = new HashMap<String, Object>();
    resultMap.put("result", result);
    resultMap.put("resultMsg", resultMsg);
    resultMap.put("pcsModel", pcsModel);
    logger.info("+ End " + className + ".selectPurchBtn");
    
    return resultMap;
  }
  
  // 처음 로딩될 때 발주서 목록 연결
  @RequestMapping("pcsOrderForm.do")
  public String pcsOrderForm(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {

    logger.info("+ Start " + className + ".pcsOrderForm");
    logger.info("   - paramMap : " + paramMap);
    logger.info("+ End " + className + ".pcsOrderForm");
    
    return "pcs/pcsOrderForm";
  }
  
  // 발주서 목록 조회
  @RequestMapping("listPcsOrderForm.do")
  public String listPcsOrderForm(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {
    
    logger.info("+ Start " + className + ".listPcsOrderForm");
    logger.info("   - paramMap : " + paramMap);
    
    int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));  // 현재 페이지 번호
    int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));      // 페이지 사이즈
    int pageIndex = (currentPage-1)*pageSize;                       // 페이지 시작 row 번호
        
    paramMap.put("pageIndex", pageIndex);
    paramMap.put("pageSize", pageSize);

    // 발주지시서 목록 조회
    List<PcsModel> listPcsOrderFormModel = pcsService.pcsOrderForm(paramMap);
    model.addAttribute("listPcsOrderFormModel", listPcsOrderFormModel);

    // 발주지시서 목록 카운트 조회
    int totalCount =  pcsService.countPcsOrderForm(paramMap);
    model.addAttribute("totalCount", totalCount);
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPage", currentPage);
    
    logger.info("+ End " + className + ".listPcsOrderForm");
    
    return "pcs/listPcsOrderForm";
  } 
  
  // 발주 버튼 클릭 시 내용 전송
  @RequestMapping("sendproc.do")
  @ResponseBody
  public Map<String, Object> sendproc(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {
    
    logger.info("+ Start " + className + ".sendproc");
    logger.info("   - paramMap : " + paramMap);

    String result = "SUCCESS";
    String resultMsg = "전송 되었습니다.";
   
    //하단에 전송 후에 구현되어야 할 로직 작성
    //pcsService.selectPurchBtn(paramMap);
    
    Map<String, Object> resultMap = new HashMap<String, Object>();
    resultMap.put("result", result);
    resultMap.put("resultMsg", resultMsg);
    //resultMap.put("pcsModel", pcsModel);
    
    logger.info("+ End " + className + ".sendproc");
    
    return resultMap;
  } 
  
  // 입고완료 버튼 클릭 시 상태 변경
  @RequestMapping("updateSTTcd.do")
  public String updateSTTcd(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {

    logger.info("+ Start " + className + ".updateSTTcd");
    logger.info("   - paramMap : " + paramMap);
    logger.info("+ End " + className + ".updateSTTcd");
    
    // 상태코드 수정 저장
    int updateSTTcdModel = pcsService.updateSTTcd(paramMap);
    model.addAttribute("updateSTTcdModel", updateSTTcdModel);
    
    return "pcs/listPcsUpdateSTTcd";
  }
}