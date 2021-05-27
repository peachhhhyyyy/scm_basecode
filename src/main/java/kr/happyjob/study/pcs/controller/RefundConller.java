package kr.happyjob.study.pcs.controller;


import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.poi.util.SystemOutLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.pcs.model.RefundDetailModel;
import kr.happyjob.study.pcs.service.RefundService;

@Controller
@RequestMapping("/pcs/refund")
public class RefundConller {
  
  @Autowired
  RefundService refundService;
  
  // logger
  private final Logger log = LogManager.getLogger(this.getClass());  

  // 반품 화면 
  @RequestMapping(value="/list.do", method=RequestMethod.GET)
  public String selectList() {
    return "/pcs/refundList";
  }
  
  // 반품 목록 조회(기본,검색)
  @RequestMapping(value="/list.do", method=RequestMethod.POST)
  public String selectList(Model model, @RequestParam Map<String, Object> param) throws Exception{

    // 현재 페이지 번호
    int currentPage = Integer.parseInt((String)param.get("currentPage"));
   
    // 한 페이지에 보일 로우의 개수
    int pageSize = Integer.parseInt((String) param.get("pageSize")); 
    
    // 페이지 시작 로우 번호
    int pageIndex = (currentPage - 1) * pageSize; 
    
    param.put("pageIndex", pageIndex);
    param.put("pageSize", pageSize);

    // 총 로우의 개수
    int totalCount;
    
    
    // 검색어 유무 확인
    if(!param.containsKey("option")) {

      // 반품서 목록(기본)의 총 로우의 개수
      totalCount = refundService.countRefundList();
      
    }
    else {
      
      // 반품서 목록 조회(검색)
      String option = (String) param.get("option");
      String keyword = (String) param.get("keyword");
      String date = (String) param.get("date");
      
      // param 에 옵션, 키워드, 날짜 추가하여  DB에서 조회
      param.put("option", option);
      param.put("keyword", keyword);
      param.put("date", date);

      // 반품서 목록(검색)의 총 로우의 개수
      totalCount = refundService.countConditionList(param);
      
    }
    
    List<RefundDetailModel> refundList = refundService.selectRefundList(param);
   
    model.addAttribute("refundList", refundList);
    model.addAttribute("totalCount", totalCount);
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPage", currentPage);
    
    return "/pcs/refundListData";
  }

  // 반품서 단건 조회
  @ResponseBody
  @RequestMapping(value="/detail.do", method=RequestMethod.POST)
  public RefundDetailModel selectRefundDetail(@RequestParam(required=false)Map<String, Object> param, RefundDetailModel refundDetail) throws Exception {
    
    String temp = (String) param.get("refund_list_no");
    int refund_list_no = Integer.parseInt(temp);
    
    refundDetail = refundService.selectOneRefund(refund_list_no);
    
    return refundDetail;
  }
  
  
  // 반품 완료 처리
  @ResponseBody
  @RequestMapping(value="returndate.do", method=RequestMethod.POST)
  public int insertReturnDate(@RequestParam Map<String,Object> param, HttpSession session) throws Exception {
    
    // 현재 로그인 중인 PCS 직원의 ID 알아내기
      String direct_id = (String)session.getAttribute("loginId");
      param.put("direct_id", direct_id);
      
      int purch_list_no = Integer.parseInt((String) param.get("purch_list_no"));
      
      // 구매 테이블에 반품 처리
      int refundResult = refundService.insertReturnDate(purch_list_no);
      
      // 환불액 입금 처리
      int  amtResult = refundService.insertAmt(param);
      
      int result = 0;
      
      // 반품과 입금처리 둘 다 처리되어야  성공(1)으로 처리
      if (refundResult == 1 && amtResult == 1) {
        result = 1;
      }
      else if (refundResult == 0 || amtResult == 0) {
        result = 0;
      }
      
      return result;
  }
  
}
