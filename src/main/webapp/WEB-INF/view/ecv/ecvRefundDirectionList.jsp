<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>반품 지시서 :: ChainMaker</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link rel="stylesheet" href="${CTX_PATH}/css/view/scm/orderList.css">
</head>
<body>
	<input type="hidden" id="currentPage" value="1">
	<div id="wrap_area">
		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
					<!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3>
					<div class="content" style="margin-bottom: 20px;">
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home"></a> 
							<span class="btn_nav">임원</span> 
							<span class="btn_nav bold">반품 지시서</span> 
							<a href="../ecv/refundDirec.do" class="btn_set refresh"></a>
						</p>
						<p class="conTitle" style="margin-bottom: 1%;">
							<span>반품 지시서</span>
						</p>
						<!-- 검색&날짜 필터링 -->
						<form id="refundDirectionListForm" method="">
							<div class="date_container1">
								<select name="searchType" id="searchType">
									<option value="" selected>전체</option>
									<option value="customerName" <c:if test="${searchType eq 'customerName'}">selected</c:if>>기업고객명</option>
									<option value="productName" <c:if test="${searchType eq 'productName'}">selected</c:if>>제품명</option>
									<option value="scmName" <c:if test="${searchType eq 'scmName'}">selected</c:if>>SCM담당자명</option>
								</select>
								<input type="text" name="keyword" value="${keyword != null ? keyword : ''}"/>
							</div>
							<!-- 날짜 필터링 -->
							<div class="date_container2">
								<input type="date" name="startDate" id="startDate" > 
								<span>~</span> 
								<input type="date" name="endDate" id="endDate">
								<a class="btnType3 color2" id="refundDirectionListSearchBtn" href="javascript:searchRefundDirectionList();">검색</a>
							</div>
						</form>
						<!-- 프로젝트 조회 -->
						<div class="divListProject">
							<table class="col" id="refundDirListTable">
								<caption>caption</caption>
								<thead>
									<tr>
										<th scope="col">기업코드</th>
										<th scope="col">기업고객명</th>
										<th scope="col">제품명</th>
										<th scope="col">제품수량</th>
										<th scope="col">총액(원)</th>
										<th scope="col">세액(원)</th>
										<th scope="col">총 공급가액(원)</th>
										<th scope="col">SCM 담당자</th>
										<th scope="col">신청 일자</th>
										<th scope="col">결제</th>
									</tr>
								</thead>
								<tbody id="refundDirListHistory"></tbody>
							</table>
						</div>
						<div class="paging_area" id="refundDirListPagination"></div>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<script src="${CTX_PATH}/js/view/ecv/refundDirectionList.js"></script>
</body>
</html>