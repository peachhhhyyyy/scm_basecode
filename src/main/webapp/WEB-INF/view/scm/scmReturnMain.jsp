<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>SCM | 반품지시서</title>
	<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
	<link rel="stylesheet" href="${CTX_PATH}/css/view/scm/returnPaper.css">
	<script type="text/javascript">
	      	
            var pageSizeinfo = 10;
	  		var pageBlockSizeinquiry = 5;
	  		
	         $(document).ready(function(){
	         	fReturnList();
	         })
	         
	         //반품지시서 조회
	         function fReturnList(currentPage) {
	        	 
				currentPage = currentPage || 1;
				
				console.log("currentPage : " + currentPage);
				
				var param = {
					currentPage : currentPage,
					pageSize : pageSizeinfo
				}
				
				var resultCallback = function(data) {
					fReturnListResult(data, currentPage);
				};
				
				callAjax("/scm/scmReturnList.do", "post", "text", true, param, resultCallback);
			 }
	         
	         // 반품지시서 콜백 함수
	         function fReturnListResult(data, currentPage) {
	        	    //alert(data);
	        	    // console.log(data);
	        	    
	        	    // 기존 목록 삭제
	        	    $('#returnList').empty();
	        	    // 신규 목록 생성
	        	    $("#returnList").append(data);
	        	    // 총 개수 추출
	        	    var totCnt = $("#totCnt").val();
	        	    // 페이지 네비게이션 생성
	        	    var paginationHtml = getPaginationHtml(currentPage, totCnt, 
	        	    		pageSizeinfo, pageBlockSizeinquiry, 'fReturnList');
	        	   // 현재 페이지 설정
	        	    $("#listInfPagination").empty().append(paginationHtml);
        	  }
	         
	         // 검색조건 기준 조회
             function fSearchReturnList(){
                 
                 var param = $('#returnListForm').serialize();
                 
                 param += "&currentPage="+$('#currentPage').val();
                 param += "&pageSize="+pageSizeinfo
                 
                 console.log("form에서 넘어온 값 : " + param)
                 
                 currentPage = currentPage || 1;
                 
                 var startDate = $('#startDate').val();
                 var endDate = $('#endDate').val();

                 // 날짜가 올바르지 않거나 널값인 경우 랜딩
                 if(startDate > endDate){
                     alert("시작일자는 종료일자보다 클 수가 없습니다.");
                     location.href= "/scm/scmReturnMain.do";
                 }
                 
                 var resultCallback =  function(data){
                     fSearchOrderListResult(data, $('#currentPage').val());
                 }
                 
                 callAjax("/scm/scmReturnList.do", "post", "text", true, param, resultCallback);
             }
             
             // 검색조건 기준 조회 결과 콜백 함수
             function fSearchOrderListResult(data, currentPage) {
            	 
                    // console.log(data);
                    
                    // 기존 목록 삭제 / 신규데이터 삽입
                    $('#returnList').empty().append(data);
                    
                    // 총 개수 추출
                    var totCnt = $("#totCnt").val();
                    // 페이지 네비게이션 생성
                    var paginationHtml = getPaginationHtml(currentPage, totCnt, 
                            pageSizeinfo, pageBlockSizeinquiry, 'fSearchReturnList');
                   // 현재 페이지 설정
                    $("#listInfPagination").empty().append(paginationHtml);
              } fReturnDetailList
              
              /* 배송지시서 상세 조회*/
              function fReturnDetailList(refund_list_no) {
                  
                var param = {
                		refund_list_no : refund_list_no,
                }
              
                var resultCallback = function(data) {
                	fReturnDetailResult(data);
                };
              
                callAjax("/scm/scmReturnDetailList.do", "post", "text", true, param, resultCallback);
              }
              
              
              // 배송지시서 상세조회 콜백 함수 
              function fReturnDetailResult(data) {
                  //console.log(data);
              
                  // 기존 목록 삭제
                  $('#returnDetailList').empty();
                  
                  var $data = $($(data).html());
                  // topList
                  var $outgoingDetailList = $data.find("#returnDetailList");
                  $("#returnDetailList").append($outgoingDetailList.children());
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
								<span class="btn_nav bold">반품지시서</span>
								<a href="../dashboard/dashboard.do" class="btn_set refresh">새로고침</a>
							</p>
							<form id="returnListForm">
								<p class="conTitle" style="display:flex; justify-content: space-between; align-items: center;">
									<span>반품지시서</span> 
									<span style="width: 665px;">
										<select id="searchBox" name="searchBox" style="width: 85px; margin-right:10px;">
											<option value="all">전체</option>
											<option value="prod_nm">제품명</option>
											<option value="cus_nm">기업고객명</option>
											<option value="scm_nm">SCM관리자</option>
										</select>
										<input type="text" name="searchInfo" id="searchInfo" placeholder="검색" style="width:200px; height: 28px; margin-right:10px;">
										<input type="date" name="startDate" id="startDate" style="width: 130px; height: 28px;">
			                            <span>~</span>
			                            <input type="date" name="endDate" id="endDate" style="width: 130px; height: 28px; margin-right:10px;">
			                            <a id="searchEnter" 
			                                  class="btn btnTypeBox" 
			                                  href="javascript:fSearchReturnList()"
			                                  style="border:1px solid #adb0b5;">검색</a>
									</span> 
								</p>
							</form>
							<table class="col">
								<thead>
									<tr>
									<th scope="col">지시서번호</th>
									<th scope="col">기업고객명</th>
									<th scope="col">품목명</th>
									<th scope="col">제품명</th>
									<th scope="col">발주개수</th>
									<th scope="col">SCM관리자</th>
									<th scope="col">제출일자</th>
									</tr>
								</thead>
								<tbody id="returnList"></tbody>
							</table>
						<div class="paging_area" id="listInfPagination"></div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</body>
</html>