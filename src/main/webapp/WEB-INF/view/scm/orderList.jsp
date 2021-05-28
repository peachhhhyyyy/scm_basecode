<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수주내역 조회 :: ChainMaker</title>
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
					<!-- lnb 영역 --> <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3>
					<div class="content" style="margin-bottom: 20px;">
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home"></a> 
							<span class="btn_nav">거래내역</span> 
							<span class="btn_nav bold">수주내역 조회</span> 
							<a href="../scm/scmOrderList.do" class="btn_set refresh"></a>
						</p>
						<p class="conTitle" style="margin-bottom: 1%;">
							<span>수주내역 조회</span>
						</p>
						<form id="orderListForm">
							<div class="filter filter-customer">
								<strong>고객</strong> 
								<input type="checkbox" id="check_1" name="check_1" value="1"> 
									<label for="check_1">입금대기</label> 
								<input type="checkbox" id="check_2" name="check_2" value="2"> 
									<label for="check_2">입금완료</label> 
								<input type="checkbox" id="check_3" name="check_3" value="3"> 
									<label for="check_3">반품대기</label> 
								<input type="checkbox" id="check_4" name="check_4" value="4"> 
									<label for="check_4">승인대기(반품)</label> 
								<input type="checkbox" id="check_5" name="check_5" value="5"> 
									<label for="check_5">승인완료(반품)</label> 
								<input type="checkbox" id="check_6" name="check_6" value="6"> 
									<label for="check_6">반품진행중</label> 
								<input type="checkbox" id="check_7" name="check_7" value="7"> 
									<label for="check_7">반품완료</label> 
								<input type="checkbox" id="check_8" name="check_8" value="8"> 
									<label for="check_8">구매확정</label>
							</div>
							<div class="filter filter-perchase">
								<strong>구매</strong> 
								<input type="checkbox" id="check_9" name="check_9" value="9"> 
									<label for="check_9">승인대기(발주)</label> 
								<input type="checkbox" id="check_10" name="check_10" value="10"> 
									<label for="check_10">승인완료(발주)</label> 
								<input type="checkbox" id="check_11" name="check_11" value="11"> 
									<label for="check_11">입고전</label> 
								<input type="checkbox" id="check_12" name="check_12" value="12"> 
									<label for="check_12">입고완료</label>
							</div>
							<div class="filter filter-devliver">
								<strong>배송</strong> 
								<input type="checkbox" id="check_13" name="check_13" value="13"> 
									<label for="check_13">배송준비</label> 
								<input type="checkbox" id="check_14" name="check_14" value="14"> 
									<label for="check_14">배송중</label> 
								<input type="checkbox" id="check_15" name="check_15" value="15"> 
									<label for="check_15">배송완료</label>
							</div>
							<!-- 날짜 필터링 -->
							<div class="date-excel-container">
								<div class="orderlist date_container">
									<input type="date" name="startDate" id="startDate" min="2000-01-01" max="9999-12-31"> 
									<span>~</span> 
									<input type="date" name="endDate" id="endDate" min="2000-01-01" max="9999-12-31">
									<a class="btnType3 color2" id="orderListSearchBtn" href="javascript:searchOrderList();">검색</a>
								</div>
								<!-- Excel 출력 아이콘 -->
								<img id="excelExport" src='/images/excel/excel.png' onclick="fExcelDownload('dailyOrderTable', '일별 수주 내역');">
							</div>
						</form>
						

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
										<th scope="col">단가(원)</th>
										<th scope="col">주문 개수</th>
										<th scope="col">금액 합계(원)</th>
										<th scope="col">부가세(원)</th>
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
	<script src="${CTX_PATH}/js/view/scm/orderListHistory/orderList.js"></script>
</body>
</html>