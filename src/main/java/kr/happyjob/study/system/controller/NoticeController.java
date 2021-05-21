package kr.happyjob.study.system.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.system.model.NoticeModel;
import kr.happyjob.study.system.service.NoticeService;

@Controller
@RequestMapping("/system/")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	// logger
	private final Logger log = LogManager.getLogger(this.getClass());

	
	// 공지사항 화면
	@RequestMapping(value="notice.do", method=RequestMethod.GET)
	  public String notice() throws Exception {
		
		return "system/notice";
	}
	
	// 공지사항 목록 조회(기본, 검색)
	@RequestMapping(value="notice.do", method=RequestMethod.POST)
	public String selectNotice(@RequestParam Map<String, Object> param, Model model, HttpSession session)throws Exception {
	  
	  System.out.println("공지사항 목록 조회 파라미터: " + param);
	  
	  // 현재 페이지 번호
	  int currentPage = Integer.parseInt((String) param.get("currentPage"));
	  
	  // 한 페이지에 보일 로우의 개수
	  int pageSize = Integer.parseInt((String)param.get("pageSize"));
	  
	  // 페이지 시작 로우 번호
	  int pageIndex = (currentPage - 1) * pageSize;
	  
	  param.put("pageIndex", pageIndex);
	  param.put("pageSize", pageSize);
	  
	  // 총 로우의 개수
	  int totalCount;
	  
	  
	  String userType = (String) session.getAttribute("userType");
	  
	  // 권한 설명
	  // 0(전체)
	  // 1(고객)
	  // 2(직원) >> E = SCM, F = PCS, F = DLV 
	  int auth;
	  
	  switch(userType) {
	    case "E" :
	    case "F" :
	    case "G" :
	      auth = 2;
	      break;
	      
	    case "J" :
	      auth = 1;
	      break;
	      
	     default:
	      auth = 0;
	      break;
	  }
	  
	  param.put("auth", auth);
	  
	  // 검색어 유무 확인
	  if(!param.containsKey("option")) {
	    totalCount = noticeService.countNoticeList();
	  }
	  else {
	    
	    String option = (String) param.get("option");
      String keyword = (String) param.get("keyword");
      String formerDate = (String) param.get("formerDate");
      String latterDate = (String) param.get("latterDate");
      
      param.put("option", option);
      param.put("keyword", keyword);
      param.put("formerDate", formerDate);
      param.put("latterDate", latterDate);
      
      totalCount = noticeService.countConditionList(param);
	    
	  }
	  
	  
	  List<NoticeModel> noticeList = noticeService.selectNoticeList(param); 
	  
	  model.addAttribute("noticeList", noticeList);
	  model.addAttribute("totalCount", totalCount);
	  model.addAttribute("pageSize", pageSize);
	  model.addAttribute("currentPage", currentPage);
	  
	  
	  return "/system/noticeList";
	}
	
	
	// 공지사항 작성
	@ResponseBody
	@RequestMapping(value="writeNotice.do", method=RequestMethod.POST)
	public int insertNotice(@RequestParam Map<String, Object> param) throws Exception {
	  System.out.println("공지사항 작성 parameter확인:" + param);
	  
	  int auth = Integer.parseInt((String) param.get("auth"));
	  
	  param.put("auth", auth);
	  
	  int result = noticeService.insertNotice(param);
	 
	  
	  return result;
	}
	
	// 공지사항 단건 조회
	@ResponseBody
	@RequestMapping(value="detailNotice.do", method=RequestMethod.POST)
	public NoticeModel selectDetailNotice(@RequestParam Map<String, Object> param) throws Exception {
//	  public NoticeModel selectDetailNotice(@RequestParam Map<String, Object> notice_id) {
	  
	  int notice_id = Integer.parseInt((String) param.get("notice_id"));
	  
	  // 조회수 증가
	  int updateViewCount = noticeService.updateViewCount(param);
	  
	  NoticeModel notice;
	  
	  if(updateViewCount == 1) {
	    notice = noticeService.selectNoticeDetail(notice_id);
	  } else {
	    log.info("조회수 증가 실패");
	    return null;
	  }
	  
	  return notice;
	}
	
	// 공지사항 수정
	@ResponseBody
	@RequestMapping(value="modifyNotice.do", method=RequestMethod.POST)
	public int updateNotice(@RequestParam Map<String, Object> param) throws Exception {
// 파라미터를 int가 아니라 map으로 던져보자
	  int auth = Integer.parseInt((String)param.get("auth"));
	  param.put("auth", auth);
	  
	  int result = noticeService.updateNotice(param);
	  
	  return result;
	}
	
	// 공지사항 삭제
	@ResponseBody
	@RequestMapping(value="deleteNotice.do", method=RequestMethod.POST)
	public int deleteNotice(@RequestParam Map<String, Object> param) throws Exception {
	  
	  int result = noticeService.deleteNotice(param);
	  
	  return result;
	}
	
}
