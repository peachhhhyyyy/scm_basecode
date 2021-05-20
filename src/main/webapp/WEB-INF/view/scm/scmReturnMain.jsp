<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>반품계획서</title>
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
	         
	         // 반품지시서 상세페이지 
	         /* function fReturnDetailList(){
	        	 
	         } */
	        
				
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
							<p class="conTitle" style="display:flex; justify-content: space-between; align-items: center;">
								<span>반품지시서</span> 
								<span style="width: 665px;">
									<select id="searchBox" style="width: 85px; margin-right:10px;">
										<option value="all">전체</option>
										<option value="prod_nm">제품명</option>
										<option value="cus_nm">고객명</option>
										<option value="scm_nm">scm관리자</option>
									</select>
									<input type="text" name="searchInfo" id="searchInfo" value="검색" style="width:200px; height: 28px; margin-right:10px;">
									<input type="date" name="startDate" id="startDate" style="width: 130px; height: 28px;">
		                            <span>~</span>
		                            <input type="date" name="endDate" id="endDate" style="width: 130px; height: 28px; margin-right:10px;">
		                            <a id="searchEnter" class="btn btnTypeBox" href="javascript:fSearchOrderList()">검색</a>
								</span> 
							</p>
							<table class="col">
								<thead>
									<tr>
									<th scope="col">번호</th>
									<th scope="col">기업고객명</th>
									<th scope="col">품목명</th>
									<th scope="col">제품명</th>
									<th scope="col">발주개수</th>
									<th scope="col">scm관리자</th>
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