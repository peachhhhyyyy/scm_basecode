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

import kr.happyjob.study.scm.model.EmployeeInfoModel;
import kr.happyjob.study.scm.service.EmployeeInfoService;

@Controller
@RequestMapping("/scm/")
public class EmployeeInfoController {
  
  @Autowired
  EmployeeInfoService employeeInfoService;
  
  private final Logger logger = LogManager.getLogger(this.getClass());

  // Get class name for logger
  private final String className = this.getClass().toString();

  // 처음 로딩될 때 직원정보관리 페이지 연결
  @RequestMapping("employeeinfo.do")
  public String employeeInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {

    return "scm/employeeInfo";
  }
  
  // 직원정보관리 목록 조회
  @RequestMapping("employeeInfoList.do")
  public String employeeInfoList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {
    
    logger.info("+ Start " + className + ".employeeInfoList");
    logger.info("   - paramMap : " + paramMap);
    
    int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));  // 현재 페이지 번호
    int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));      // 페이지 사이즈
    int pageIndex = (currentPage-1)*pageSize;                       // 페이지 시작 row 번호
        
    paramMap.put("pageIndex", pageIndex);
    paramMap.put("pageSize", pageSize);

    logger.info("   - paramMap : " + paramMap);

    // 직원정보관리 목록 조회
    List<EmployeeInfoModel> employeeInfoModel = employeeInfoService.employeeInfo(paramMap);
    model.addAttribute("employeeInfoModel", employeeInfoModel);
    
    // 직원정보관리 목록 카운트 조회
    int totalCount =  employeeInfoService.countEmployeeInfo(paramMap);
    model.addAttribute("totalCount", totalCount);
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPage", currentPage);
    
    logger.info("+ End " + className + ".employeeInfoList");
    
    return "scm/listEmployee";
  } 
  
  // 직원이름 클릭 시 모달창 띄우기
  @RequestMapping("selectSubmitBtn.do")
  @ResponseBody
  public Map<String, Object> selectSubmitBtn(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {
    
    logger.info("+ Start " + className + ".selectSubmitBtn");
    logger.info("   - paramMap : " + paramMap);
    
    EmployeeInfoModel employeeInfoModel = employeeInfoService.selectSubmitBtn(paramMap);
    
    Map<String, Object> resultMap = new HashMap<String, Object>();
    resultMap.put("employeeInfoModel", employeeInfoModel);

    logger.info("+ End " + className + ".selectSubmitBtn");
    
    return resultMap;
  }
}