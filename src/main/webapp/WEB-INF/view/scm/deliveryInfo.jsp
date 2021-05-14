<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 데이터가 존재하지 않는 경우 -->
<c:if test="${empty deliveryInfo}">
	<h1>데이터가 존재하지 않습니다.</h1>
</c:if>
<c:if test="${!empty deliveryInfo}">

	<input type="hidden" id="currentPage" value="1">
	<h1>배송 지시서</h1>
	<div class="prodInfoContainer">
		<div>
			<span>SCM관리자 : </span><span>${deliveryInfo.scmManager}</span>
		</div>
		<div>
			<span>주문 번호 : </span><span>${deliveryInfo.orderCode}</span>
		</div>
		<div>
			<c:set var="submitDate" value="${deliveryInfo.submitDate}"/>
			<span>제출 일자 : </span><span>${fn:substring(submitDate, 0, 11)}</span>
		</div>
		<div>
	        <c:set var="orderDate" value="${deliveryInfo.orderDate}"/>
			<span>주문 일자 : </span><span>${fn:substring(orderDate, 0, 11)}</span>
		</div>
		<div>
			<c:set var="wantReceiveDate" value="${deliveryInfo.wantReceiveDate}"/>
			<span>희망납품 일자 : </span><span>${fn:substring(wantReceiveDate, 0, 11)}</span>
		</div>
		<div>
			<span>기업고객명 : </span><span>${deliveryInfo.customerName}</span>
		</div>
		<div>
			<span>제품명 : </span><span>${deliveryInfo.productName}</span>
		</div>
		<div>
			<span>품목명 : </span><span>${deliveryInfo.middleCategory}</span>
		</div>
		<div>
			<span>공급처명 : </span><span>${deliveryInfo.supplyName}</span>
		</div>
		<div>
			<span>주문 수량 : </span><span>${deliveryInfo.orderCount}</span>
		</div>
		<div>
			<span>요구 사항</span><div id="customerRequest">${deliveryInfo.customerRequest}</div>
		</div>
	</div>
</c:if>
