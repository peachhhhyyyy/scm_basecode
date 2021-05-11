package kr.happyjob.study.pcs.controller;


import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.pcs.service.RefundService;

@Controller
@RequestMapping("/pcs/refund")
public class RefundConller {
  
  @Autowired
//  RefundService refundService;
  
  // logger
//  private final Logger logger = LogManager.getLogger(this.getClass());  

  // 반품 화면 
  @RequestMapping(value="/list.do", method=RequestMethod.GET)
  public String getList() {
    return "/pcs/refundList";
  }
  
  // 반품 목록 조회
  @RequestMapping(value="/list.do", method=RequestMethod.POST)
  public String getList(Model model, @RequestParam Map<String, Object> paramMap){
    return "";
  }









}
