<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>기업고객관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">

	var pageSizeInfo = 10;
	var pageBlockSize = 5;

	/*OnLoad event*/
	$(document).ready(function(){
	  fCusList();
	}) 

	/* 기업고객 조회 */
	function fCusList(currentPage) {
		currentPage = currentPage || 1;

		console.log("currentPage : " + currentPage);

		var param = {
			currentPage : currentPage,
			pageSize : pageSizeInfo
		}
		var resultCallback = function(data) {
			fCusListResult(data, currentPage);
		}
		callAjax("/scm/cusListInfo.do", "post", "text", true, param,
				resultCallback);
	}
	
	/* 검색 조건 리스트 함수 */
	function fSearchCusList(currentPage) {
                    
        currentPage = currentPage || 1;
        
        var param = $('#searchForm').serialize();
        
        param += "&currentPage="+currentPage;
        param += "&pageSize="+pageSizeinfo;
        
        console.log("검색조건에 대한 param : " + param);
        console.log("currentPage : " + currentPage);
        
        //Ajax실행 방식
        //callAjax("Url",type,return,async or sync방식,넘겨준 값,Callback함수 이름)
        callAjax("/dlv/outgoingList.do", "post", "text", true, param, resultCallback);
    }
	/* 창고 조회 콜백 함수 */
	function fCusListResult(data, currentPage) {

		// console.log(data);
		
		//기존 목록 삭제 및 신규 목록 삽입
		$('#cusListInfo').empty().append(data);

		// 총 개수 추출
		var totCnt = $("#totCnt").val();

		//페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totCnt,
				pageSizeInfo, pageBlockSize, 'fSearchCusList');
		$("#Pagination").empty().append(paginationHtml);

		//현재 페이지 설정
		$("#currentPage").val(currentPage);
	}
</script>
</head>
<body>
	<input type="hidden" id="currentPage" value="1">
	<div id="mask"></div>
	<div id="wrap_area">
		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
					<!--// lnb 영역 -->
				</li>
				<li class="contents">
					<h3 class="hidden">contents 영역</h3> 
					<div class="content" style="margin-bottom: 20px;">
						<p class="Location">
							<a href="/system/notice.do" class="btn_set home">메인으로</a>
							<a class="btn_nav">기준정보</a>
							<span class="btn_nav bold">기업고객관리</span>
							<a href="" class="btn_set refresh">새로고침</a>
						</p>
						<form id="searchForm">
							<p class="conTitle" style="display:flex; align-items: left;">
								<select name="searchKey" style="width: 100px; height:31px;" >
									<option value="all" selected="selected">전체</option>
									<option value="company_nm">회사명</option>
									<option value="company_mng_nm">담당자명</option>
								</select>
								<input type="text" style="width: 300px; height:29px;" name="searchInfo">
								<a href="javascript:fSearchCusList()"class="btnType blue" id="searchBtn">
								    <span>검색 </span>
								</a>
								<input type="checkbox" id="active">
								<span> 비활성화 보기</span>
							</p>
						</form>
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="12%">
									<col width="12%">
									<col width="12%">
									<col width="12%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">회사명</th>
										<th scope="col">담당자명</th>
										<th scope="col">연락처</th>
										<th scope="col">활성화여부</th>
									</tr>
								</thead>
								<tbody id="cusListInfo"></tbody>
							</table>
						<div class="paging_area" id="Pagination"></div>
					</div>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>