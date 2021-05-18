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
	
	// Set logger
	private final Logger log = LogManager.getLogger(this.getClass());

	
	
	// 처음 로딩될 때 공지사항 연결
	@RequestMapping("notice.do")
	public String init(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {

		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		System.out.println(loginID);
//		paramMap.put("writer", loginID);
		
		return "system/notice";
	}
	
	// 공지사항 리스트 출력
//	@RequestMapping("noticeList.do")
//	public String noticeList(Model model, @RequestParam Map<String, Object> paramMap, 
//			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
//		
//		logger.info("   - paramMap : " + paramMap);
//		String title = (String) paramMap.get("title");
//		
//		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
//	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
//	    int pageIndex = (currentPage - 1) * pageSize;
//		
//		paramMap.put("pageIndex", pageIndex);
//		paramMap.put("pageSize", pageSize);
//		paramMap.put("title", title);
//		
//		// 공지사항 목록 조회
//		List<NoticeModel> noticeList = noticeService.noticeList(paramMap);
//		model.addAttribute("notice", noticeList);
//		
//		// 목록 수 추출해서 보내기
//		int noticeCnt = noticeService.noticeCnt(paramMap);
//		
//	    model.addAttribute("noticeCnt", noticeCnt);
//	    model.addAttribute("pageSize", pageSize);
//	    model.addAttribute("currentPage",currentPage);
//	    
//	    return "system/noticeList";
//	}
	
	// 공지사항 작성
	@ResponseBody
	@RequestMapping(value="writeNotice.do", method=RequestMethod.POST)
	public int writeNotice(HttpSession session) {
	  System.out.println("공지사항 작성");
	  
	  String msg;
	 
	  // 세션에서 userType= 'A'(관리자) 확인
	  char userType = (char) session.getAttribute("userType");
	  
	  if(userType == 'A') {
	    // 글 작성 진행
	    
	  } 
	  else {
	    // JSP에서는 글작성 버튼이 관리자만 보이도록 처리
	    //  -> 글 조회해 올 때, Model에 userType 저장해주기
	    msg = "글 작성은 관리자만 가능합니다.";
	  }
	  
	  // 
	  
	  return 0;
	}
	
	// 공지사항 상세 조회
//	@RequestMapping("detailNotice.do")
//	@ResponseBody
//	public Map<String,Object> detailNotice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
//		
//		//System.out.println("상세정보 보기를 위한 param에서 넘어온 값을 찍어봅시다.: " + paramMap);
//		  logger.info("+ Start " + className + ".detailNotice");
//		  logger.info("   - paramMap : " + paramMap);
//		  
//		String result="";
//		
//		// 선택된 게시판 1건 조회 
//		NoticeModel detailNotice = noticeService.noticeDetail(paramMap);
//		
//		if(detailNotice != null) {
//			result = "SUCCESS";  // 성공시 찍습니다. 
//		}else {
//			result = "FAIL / 불러오기에 실패했습니다.";  // null이면 실패입니다.
//		}
//		
//		Map<String, Object> resultMap = new HashMap<String, Object>();
//		resultMap.put("resultMsg", result); // success 용어 담기 
//		resultMap.put("result", detailNotice); // 리턴 값 해쉬에 담기 
//		//resultMap.put("resultComments", comments);
//		System.out.println(detailNotice);
//		
//		logger.info("+ End " + className + ".detailNotice");
//	    
//	    return resultMap;
//	}
//	
//	// 공지사항 신규등록, 업데이트
//	@RequestMapping("noticeSave.do")
//	@ResponseBody
//	public Map<String, Object> noticeSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
//		
//		logger.info("+ Start " + className + ".noticeSave");
//		logger.info("   - paramMap : " + paramMap);
//		
//		String action = (String)paramMap.get("action");
//		String resultMsg = "";
//		
//		// 사용자 정보 설정
//		paramMap.put("loginID", session.getAttribute("loginId"));
//		if ("I".equals(action)) {
//			// 그룹코드 신규 저장
//			noticeService.insertNotice(paramMap);
//			resultMsg = "SUCCESS";
//		} else if("U".equals(action)) {
//			// 그룹코드 수정 저장
//			noticeService.updateNotice(paramMap);
//			resultMsg = "UPDATED";
//			System.out.println(paramMap);
//		} else {
//			resultMsg = "FALSE : 등록에 실패하였습니다.";
//		}
//		
//		//결과 값 전송
//		Map<String, Object> resultMap = new HashMap<String, Object>();
//		resultMap.put("resultMsg", resultMsg);
//	    
//	    return resultMap;
//	}
//	
//	// 공지사항 삭제
//	@RequestMapping("noticeDelete.do")
//	@ResponseBody
//	public Map<String, Object> noticeDelete(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
//			HttpServletResponse response, HttpSession session) throws Exception {
//		
//		logger.info("+ Start " + className + ".noticeDelete");
//		logger.info("   - paramMap : " + paramMap);
//
//		String result = "SUCCESS";
//		String resultMsg = "삭제 되었습니다.";
//		
//		// 그룹코드 삭제
//		noticeService.deleteNotice(paramMap);
//		
//		Map<String, Object> resultMap = new HashMap<String, Object>();
//		resultMap.put("result", result);
//		resultMap.put("resultMsg", resultMsg);
//		
//		logger.info("+ End " + className + ".noticeDelete");
//		
//		return resultMap;
//	}
//	
}
