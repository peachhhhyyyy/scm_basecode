<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>발주 지시서 :: ChainMaker</title>
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
							<span class="btn_nav bold">임원</span> 
							<span class="btn_nav bold">발주 지시서</span> 
							<a href="../scm/scmOrderList.do" class="btn_set refresh"></a>
						</p>
						<p class="conTitle" style="margin-bottom: 1%; display: flex; justify-content: center; align-items: space-between;">
							<span>발주 지시서</span>
						</p>

						<!-- Excel 출력 아이콘 -->
						<img id="excelExport" src='/images/excel/excel.png' onclick="fExcelDownload('dailyOrderTable', '일별 수주 내역');">

						<br>
						<!-- 프로젝트 조회 -->
						<div class="divListProject">
							<table class="col" id="orderListTable">
								<caption>caption</caption>
								<thead>
									<tr>
										<th scope="col">주문코드</th>
										<th scope="col">주문일자</th>
										<th scope="col">기업고객명</th>
										<th scope="col">주문제품명</th>
										<th scope="col">총 재고 개수</th>
										<th scope="col">단가</th>
										<th scope="col">주문 개수</th>
										<th scope="col">금액 합계</th>
										<th scope="col">부가세</th>
										<th scope="col">입금 여부</th>
										<th scope="col">배송지시서</th>
										<th scope="col">발주지시서</th>
										<th scope="col">상태</th>
									</tr>
								</thead>
								<tbody id="orderListHistory"></tbody>
							</table>
						</div>
						<div class="paging_area" id="orderListPagination"></div>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<script src="${CTX_PATH}/js/view/ecv/directionList.js"></script>
</body>
</html>