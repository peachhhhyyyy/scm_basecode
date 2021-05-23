<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="divEmpty">
    <div class="hiddenData"></div>
	<table>
	    <thead>
	        <tr>
	            <th scope="col">품목명</th>
	            <th scope="col">제품명</th>
	            <th scope="col">공급처명</th>
	            <th scope="col">수량</th>
	            <th scope="col">창고명</th>
	            <th scope="col">희망납품일자</th>
	            <th scope="col">주문일자</th>
	            <th scope="col">적요</th>
	        </tr>
	    </thead>
	    <tbody id="outgoingDetailList">
			<c:forEach items="${outgoingSearchList}" var="list">
				<tr>
				    <td>${list.l_ct_cd}</td>
					<td>${list.prod_nm}</td>
					<td>${list.supply_nm}</td>
					<td>${list.order_cnt}</td>
					<td>${list.warehouse_nm}</td>
					<td>${list.want_receive_date}</td>
					<td>${list.order_date}</td>
					<td>${list.request}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
