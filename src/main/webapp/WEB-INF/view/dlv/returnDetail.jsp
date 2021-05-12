<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="divEmpty">
	<div class="hiddenData"></div>
	<table class="col">
		<thead>
			<tr>
				<th scope="col">주문코드</th>
				<th scope="col">제품명</th>
				<th scope="col">배송코드</th>
				<th scope="col">수량</th>
				<th scope="col">품목명</th>
				<th scope="col">고객명</th>
				<th scope="col">고객연락처</th>
				<th scope="col">담당자명</th>
				<th scope="col">주소</th>
				<th scope="col">배송사원</th>
				<th scope="col">배송사원 연락처</th>
				<th scope="col">창고명</th>
				<th scope="col">반품 상태</th>
				
			</tr>
		</thead>
		<tbody id="returnDetailList">
			<c:forEach items="${returnDetailList}" var="list">
				<tr>
					<td>${list.order_cd}</td>
					<td>${list.refund_list_no}</td>
					<td>${list.prod_nm}</td>
					<td>${list.m_ct_nm}</td>
					<td>${list.refund_cnt}</td>
					<td>${list.cus_name}</td>
					<td>${list.cus_tel}</td>
					<td>${list.emp_name}</td>
					<td>${list.emp_addr}</td>
					<td>${list.dlv_name}</td>
					<td>${list.dlv_tel}</td>
					<td>${list.warehouse_nm}</td>
					<td>${list.state}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>