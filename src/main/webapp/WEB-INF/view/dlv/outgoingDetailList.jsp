<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="divEmpty">
	<div class="hiddenData"></div>
	<table class="col">
		<thead>
			<tr>
				<th scope="col">배송코드</th>
				<th scope="col">주문코드</th>
				<th scope="col">품목명</th>
				<th scope="col">제품명</th>
				<th scope="col">수량</th>
				<th scope="col">고객명</th>
				<th scope="col">고객연락처</th>
				<th scope="col">주소</th>
				<th scope="col">SCM담당자명</th>
				<th scope="col">배송사원</th>
				<th scope="col">배송사원 연락처</th>
				<th scope="col">창고명</th>
				<th scope="col">도착예정일자</th>
				<th scope="col">배송상태</th>
			</tr>
		</thead>
		<tbody id="outgoingDetailList">
			<c:forEach items="${outgoingDetailList}" var="list">
				<tr>
					<td>${list.ship_list_no}</td>
					<td>${list.order_cd}</td>
					<td>${list.m_ct_nm}</td>
					<td>${list.prod_nm}</td>
					<td>${list.order_cnt}</td>
					<td>${list.name_customer}</td>
					<td>${list.tel_customer}</td>
					<td>${list.addr}</td>
					<td>${list.name_scm}</td>
					<td>${list.name_delivery}</td>
					<td>${list.tel_delivery}</td>
					<td>${list.warehouse_nm}</td>
					<td>${list.arr_prev_date}</td>
					<td>${list.state}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>