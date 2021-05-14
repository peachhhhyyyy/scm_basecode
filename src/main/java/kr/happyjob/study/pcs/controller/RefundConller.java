package kr.happyjob.study.pcs.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.pcs.model.RefundDetailModel;
import kr.happyjob.study.pcs.model.RefundListModel;
import kr.happyjob.study.pcs.service.RefundService;

@Controller
@RequestMapping("/pcs/refund")
public class RefundConller {
  
  @Autowired
  RefundService refundService;
  
  // logger
  private final Logger logger = LogManager.getLogger(this.getClass());  

  // 반품 화면 
  @RequestMapping(value="/list.do", method=RequestMethod.GET)
  public String getList() {
    return "/pcs/refundList";
  }
  
  // 반품 목록 조회
  // calllAjax수정해야 함
  @RequestMapping(value="/list.do", method=RequestMethod.POST)
  public String getList(Model model, @RequestParam Map<String, Object> paramMap) throws Exception{
    
    logger.info("파라미터 확인:" + paramMap);
    
    // 현재 페이지 번호
    int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
    // 한 페이지에 보이 로우의 개수
    int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); 
    // 페이지 시작 로우 번호
    int pageIndex = (currentPage - 1) * pageSize; 
    // 총 페이지 개수
    int totalCount = refundService.countRefundList();
    
    paramMap.put("pageIndex", pageIndex);
    paramMap.put("pageSize", pageSize);
    
    List<RefundDetailModel> refundList = refundService.selectRefundList(paramMap);
    model.addAttribute("refundList", refundList);
    
    model.addAttribute("totalCount", totalCount);
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPage", currentPage);
    
    logger.info("DB에서 넘어온 데이터 확인:" + refundList);
    
    return "/pcs/refundListData";
  }

  // 반품서 단건 조회
  @ResponseBody
  @RequestMapping(value="/detail.do", method=RequestMethod.POST)
  public RefundDetailModel getOneRefund(@RequestParam(required=false)Map<String, Object> param, Model model, RefundDetailModel refundDetail) throws Exception {
    logger.info("단건 파라미터 확인:" +  param);
    logger.info("파라미터 타입확인" + param.get("refund_list_no").getClass().getName());
    
    
    String temp = (String) param.get("refund_list_no");
    int refund_list_no = Integer.parseInt(temp);
    
//    
    refundDetail = refundService.selectOneRefund(refund_list_no);
    logger.info("단건 조회내역 확인" + refundDetail);
    logger.info("날짜 확인" + refundDetail.getPurch_date());
    
    return refundDetail;
  }
  
  // 반품 완료 처리
  @ResponseBody
  @RequestMapping(value="returndate.do", method=RequestMethod.POST)
  public int insertReturnDate(@RequestParam Map<String,Object> param) throws Exception {
//    Map<String,Integer>로 받아서 테스트
//    위의 방법이 실패시 <String,Object>로 실행 -> 실패. 아래는 에러메시지
//    java.lang.ClassCastException: java.lang.String cannot be cast to java.lang.Integer
    logger.info("purch_list_no확인" + param);
    logger.info("purch_list_no타입" + param.get("purch_list_no").getClass().getName());
    logger.info("refundmodel" + param.get("purch_list_no"));
   
    String temp = (String) param.get("purch_list_no");
    int purch_list_no = Integer.parseInt(temp);
//    logger.info("refund_list_no확인" + purch_list_no.getClass().getName());
    
    int result = refundService.insertReturnDate(purch_list_no);
    
//    logger.info("update결과:" + result);
    return result;
  }
//  @ResponseBody
//  @RequestMapping(value="returndate.do", method=RequestMethod.POST)
//  public int insertReturnDate(@RequestParam Map<String,Object> param, RefundListModel refundList) throws Exception {
//    
//    logger.info("purch_list_no확인" + param);
//    logger.info("purch_list_no내용확인" + param.get("purch_list_no"));
//    logger.info("refundmodel" + refundList.getPurch_list_no());
//    
////    String temp = (String) param.get("purch_list_no");
////    int purch_list_no = Integer.parseInt(temp);
//    int result = refundService.insertReturnDate(purch_list_no);
//    
//    logger.info("update결과:" + result);
//    return result;
//  }
  








}
