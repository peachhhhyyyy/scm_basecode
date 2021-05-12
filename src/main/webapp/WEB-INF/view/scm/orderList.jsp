<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수주내역 조회 || ChainMaker</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<style>
.filter {
	margin-top: 1%;
}

.filter input {
	margin-left: 10px;
}

.date_container {
	margin-top: 10px;
}

#container ul li.contents .content {
	min-height: 800px;
}
</style>
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
							<span class="btn_nav bold">거래내역</span> 
							<span class="btn_nav bold">수주내역 조회</span> 
							<a href="../scm/scmOrderList.do" class="btn_set refresh"></a>
						</p>
						<p class="conTitle" style="margin-bottom: 1%; display: flex; justify-content: center; align-items: space-between;">
							<span>수주내역 조회</span>
						</p>
						<div>
							<div class="filter filter-customer">
								<strong>고객</strong> 
								<input type="checkbox" id="customer_check_1" name="customer_check_1" value="입금대기"> 
								<label for="customer_check_1">입금대기</label> 
								<input type="checkbox" id="customer_check_2" name="customer_check_2" value="입금완료"> 
								<label for="customer_check_2">입금완료</label> 
								<input type="checkbox" id="customer_check_3" name="customer_check_3" value="반품대기"> 
								<label for="customer_check_3">반품대기</label> 
								<input type="checkbox" id="customer_check_4" name="customer_check_4" value="반품승인대기"> 
								<label for="customer_check_4">승인대기(반품)</label> 
								<input type="checkbox" id="customer_check_5" name="customer_check_5" value="반품승인완료"> 
								<label for="customer_check_5">승인완료(반품)</label> 
								<input type="checkbox" id="customer_check_6" name="customer_check_6" value="반품진행중"> 
								<label for="customer_check_6">반품진행중</label> 
								<input type="checkbox" id="customer_check_7" name="customer_check_7" value="반품완료"> 
								<label for="customer_check_7">반품완료</label> 
								<input type="checkbox" id="customer_check_8" name="customer_check_8" value="구매확정"> 
								<label for="customer_check_8">구매확정</label>
							</div>
							<div class="filter filter-perchase">
								<strong>구매</strong> 
								<input type="checkbox" id="perchase_check_1" name="perchase_check_1" value="승인대기(발주)"> 
								<label for="perchase_check_1">승인대기(발주)</label> 
								<input type="checkbox" id="perchase_check_2" name="perchase_check_2" value="승인완료(발주)"> 
								<label for="perchase_check_2">승인완료(발주)</label> 
								<input type="checkbox" id="perchase_check_3" name="perchase_check_3" value="입고대기"> 
								<label for="perchase_check_3">입고대기</label> 
								<input type="checkbox" id="perchase_check_4" name="perchase_check_4" value="입고완료"> 
								<label for="perchase_check_4">입고완료</label>
							</div>
							<div class="filter filter-devliver">
								<strong>배송</strong> 
								<input type="checkbox" id="deliver_check_1" name="deliver_check_1" value="배송준비"> 
								<label for="deliver_check_1">배송준비</label> 
								<input type="checkbox" id="deliver_check_2" name="deliver_check_2" value="배송중"> 
								<label for="deliver_check_2">배송중</label> 
								<input type="checkbox" id="deliver_check_3" name="deliver_check_3" value="배송완료"> 
								<label for="deliver_check_3">배송완료</label>
							</div>
						</div>
						<!-- Excel 출력 아이콘 -->
						<img src='/images/excel/excel.png' style="height: 28px; width: 28px; margin-right: 10px; float: right;" onclick="fExcelDownload('dailyOrderTable', '일별 수주 내역');">
						<!-- 날짜 필터링 -->
						<div class="date_container">
							<input type="date" name="date" id="startDate"> 
							<span>~</span> 
							<input type="date" name="date" id="endDate">
						</div>
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
	<script src="${CTX_PATH}/js/view/scm/orderListHistory/orderList.js"></script>
</body>
</html>