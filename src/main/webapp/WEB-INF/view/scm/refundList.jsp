<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>반품신청 목록 :: ChainMaker</title>
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
							<span class="btn_nav bold">거래내역</span> 
							<span class="btn_nav bold">수주내역 조회</span> 
							<a href="../scm/refundList.do" class="btn_set refresh"></a>
						</p>
						<p class="conTitle" style="margin-bottom: 1%;">
							<span>반품신청 목록</span>
						</p>
						<!-- 날짜 필터링 -->
						<div class="date_container">
							<input type="date" name="startDate" id="startDate"> 
							<span>~</span> 
							<input type="date" name="endDate" id="endDate">
							<a class="btnType3 color2" id="refundListSearchBtn">검색</a>
						</div>
						
						<!-- Excel 출력 아이콘 -->
						<img id="excelExport" src='/images/excel/excel.png' onclick="fExcelDownload('dailyOrderTable', '일별 수주 내역');">

						<br>
						<!-- 프로젝트 조회 -->
						<div class="divListProject">
							<table class="col" id="refundListTable">
								<caption>caption</caption>
								<thead>
									<tr>
										<th scope="col">주문코드</th>
										<th scope="col">기업고객명</th>
										<th scope="col">제품명</th>
										<th scope="col">품목명</th>
										<th scope="col">반품신청날짜</th>
										<th scope="col">반품수량</th>
										<th scope="col">반품금액</th>
										<th scope="col">상태</th>
									</tr>
								</thead>
								<tbody id="refundListHistory"></tbody>
							</table>
						</div>
						<div class="paging_area" id="refundListPagination"></div>
						<div id="detailRefund"></div>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<script src="${CTX_PATH}/js/view/scm/orderListHistory/refundList.js"></script>
</body>
</html>