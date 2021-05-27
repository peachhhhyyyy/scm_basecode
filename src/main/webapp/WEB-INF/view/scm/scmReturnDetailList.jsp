<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<div class="divEmpty">
    <div class="hiddenData"></div>
	<table>
	    <thead>
	        <tr>
	            <th scope="col">SCM관리자</th>
	            <th scope="col">품목명</th>
	            <th scope="col">제품명</th>
	            <th scope="col">수량</th>
	            <th scope="col">창고명</th>
	            <th scope="col">공급처명</th>
	            <th scope="col">반품신청날짜</th>
	            <th scope="col">반품금액</th>
	            <th scope="col">주문일자</th>
	            <th scope="col">제출일자</th>
	            <th scope="col">승인자명</th>
	        </tr>
	    </thead>
	    <tbody id="returnDetailList">
			<c:forEach items="${returnDetailList}" var="list">
				<tr>
				    <td>${list.scm_nm}</td>
				    <td>${list.l_ct_nm}</td>
					<td>${list.prod_nm}</td>
					<td>${list.refund_cnt}</td>
					<td>${list.warehouse_nm}</td>
					<td>${list.supply_nm}</td>
					<td>${list.refund_date}</td>
					<td><fmt:formatNumber value="${list.refund_amt}" pattern="#,###"/></td>
					<td>${list.order_date}</td>
					<td>${list.submit_date}</td>
					<td>${list.approve_nm}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
