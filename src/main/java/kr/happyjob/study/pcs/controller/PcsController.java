package kr.happyjob.study.pcs.controller;

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

@Controller
@RequestMapping("/pcs/") // 여기서 선언한 것은 상위 path명
public class PcsController<PcsService> {
  
  // 처음 로딩될 때 공지사항 연결
  @RequestMapping("pcsOrderingOrder.do")
  public String pcsOrderingOrder(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
      HttpServletResponse response, HttpSession session) throws Exception {
   
    return "pcs/pcsOrderingOrder";
  }
}