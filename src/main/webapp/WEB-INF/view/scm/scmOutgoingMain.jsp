<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>SCM | 배송지시서</title>
	<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
	<link rel="stylesheet" href="${CTX_PATH}/css/view/scm/outgoingPaper.css">
	<script type="text/javascript">
	      	
            var pageSizeinfo = 10;
	  		var pageBlockSizeinquiry = 5;
	  		
	         $(document).ready(function(){
	        	  fOutgoingList();
	         })
	         
	         //반품지시서 조회
	         function fOutgoingList(currentPage) {
	        	 
				currentPage = currentPage || 1;
				
				console.log("currentPage : " + currentPage);
				
				var param = {
					currentPage : currentPage,
					pageSize : pageSizeinfo
				}
				
				var resultCallback = function(data) {
					fOutgoingListResult(data, currentPage);
				};
				
				callAjax("/scm/scmOutgoingList.do", "post", "text", true, param, resultCallback);
			 }
	         
	         // 검색조건 기준 조회
	         function fSearchOrderList(currentPage){
	        	 
	        	 currentPage = currentPage || 1;
	        	 
	        	 var param = $('#outgoingListForm').serialize();
	        	 
	        	 param += "&currentPage="+currentPage;
	        	 param += "&pageSize="+pageSizeinfo;
	        	 
	        	 console.log("form에서 넘어온 값 : " + param)
	        	 
	        	 var startDate = $('#startDate').val();
                 var endDate = $('#endDate').val();

                 // 날짜가 올바르지 않거나 널값인 경우 랜딩
                 if(startDate > endDate){
                	 swal("\n 시작 날짜가 종료날짜보다 클 수 없습니다. \n 다시 입력해주세요.").then(function (){
                         window.location.reload();
                   })
                 }
	        	 
	        	 var resultCallback =  function(data){
	        		 fOutgoingListResult(data, currentPage);
	        	 }
	        	 
	        	 callAjax("/scm/scmOutgoingList.do", "post", "text", true, param, resultCallback);
	         }
	         
	         // 배송지시서 콜백 함수
	         function fOutgoingListResult(data, currentPage) {
	        	 
	        	    console.log("콜백함수 data : " + data)

	        	 
	        	    // 기존 목록 삭제, 신규 데이터 삽입
	        	    $('#outgoingList').empty().append(data);
	        	    
	        	    // 총 개수 추출
	        	    var totCnt = $("#totCnt").val();
	        	    
	        	    // 페이지 네비게이션 생성
	        	    var paginationHtml = getPaginationHtml(currentPage, totCnt, pageSizeinfo, pageBlockSizeinquiry, 'fSearchOrderList');
	        	   // 현재 페이지 설정
	        	    $("#listInfPagination").empty().append(paginationHtml);
        	  }
	         
	         
             /* 배송지시서 상세 조회*/
             function fOutgoingDetailList(ship_list_no) {
                 
               var param = {
            		   ship_list_no : ship_list_no,
               }
             
               var resultCallback = function(data) {
            	   fOutgoingDetailResult(data);
               };
             
               callAjax("/scm/scmOutgoingDetailList.do", "post", "text", true, param, resultCallback);
             }
             
             
             // 배송지시서 상세조회 콜백 함수 
             function fOutgoingDetailResult(data) {
                 //console.log(data);
             
                 // 기존 목록 삭제
                 $('#outgoingDetailList').empty();
                 
                 var $data = $($(data).html());
                 // topList
                 var $outgoingDetailList = $data.find("#outgoingDetailList");
                 $("#outgoingDetailList").append($outgoingDetailList.children());
             }
	      </script>
	</head>
	<body>
		<input type="hidden" id="currentPage" value="1">
		<div id="mask"></div>
		<div id="wrap_area">
			<div id="container">
				<ul>
					<li class="lnb">
					    <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
					</li>
					<li class="contents">
						<h3 class="hidden">contents 영역</h3>
						<div class="content" style="min-bottom: 20px;">
							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 
								<a href="../scm/scmReturnMain.do" class="btn_nav">작업지시서</a>
								<span class="btn_nav bold">배송지시서</span>
								<a href="../dashboard/dashboard.do" class="btn_set refresh">새로고침</a>
							</p>
							<form id="outgoingListForm">
								<p class="conTitle" style="display:flex; justify-content: space-between; align-items: center;">
									<span>배송지시서</span> 
									<span style="width: 750px;">
										<select name="searchBox" style="width: 90px; margin-right:10px;">
											<option value="all">전체</option>
											<option value="J">기업고객명</option>
											<option value="E">SCM관리자</option>
										</select>
										<input type="text" id="searchInfo" name="searchInfo" placeholder="검색" style="width:200px; height: 28px; margin-right:10px;">
										<input type="date" id="startDate" name="startDate" style="width: 130px; height: 28px;">
			                            <span>~</span>
			                            <input type="date" id="endDate" name="endDate" style="width: 130px; height: 28px; margin-right:10px;">
			                            <span>* 제출일자기준</span>
			                            <a id="searchEnter" 
			                                  class="btn btnTypeBox" 
			                                  href="javascript:fSearchOrderList()"
			                                  style="border:1px solid #adb0b5;">검색</a>
									</span> 
								</p>
							</form>
							<table class="col">
								<colgroup>
								    <col width="10%">
								    <col width="15%">
								</colgroup>
								<thead>
									<tr>
									<th scope="col">지시서번호</th>
									<th scope="col">주문코드</th>
									<th scope="col">기업고객명</th>
									<th scope="col">SCM관리자</th>
									<th scope="col">주문접수일자</th>
									<th scope="col">제출일자</th>
									</tr>
								</thead>
								<tbody id="outgoingList"></tbody>
							</table>
						<div class="paging_area" id="listInfPagination"></div>
						</div>
						<div class="content">
				            <p class="conTitle">
                                <span>상세페이지</span>
                            </p>
                            <table class="col">
                                <colgroup>
                                    <col width="10%">
                                    <col width="20%">
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="20%">
                                </colgroup>
						        <thead>
						            <tr>
						                <th scope="col">품목명</th>
						                <th scope="col">제품명</th>
						                <th scope="col">공급처명</th>
						                <th scope="col">수량</th>
						                <th scope="col">창고명</th>
						                <th scope="col">희망납품일자</th>
						                <th scope="col">주문일자</th>
						                <th scope="col">적요</th>
						            </tr>
						        </thead>
						        <tbody id="outgoingDetailList">
						           <tr>
	                                 <td colspan="8">지시서번호를 선택해 주세요.</td>
	                               </tr>
						        </tbody>
                            </table>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</body>
</html>