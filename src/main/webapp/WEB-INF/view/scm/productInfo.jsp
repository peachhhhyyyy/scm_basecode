<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 데이터가 존재하지 않는 경우 -->
<c:if test="${empty productInfo}">
	<h1>데이터가 존재하지 않습니다.</h1>
</c:if>
<c:if test="${!empty productInfo}">
	<h1>발주 지시서</h1>
	<div>
		<div>
			<span>SCM관리자 : </span><span>${productInfo.scmManager}</span>
		</div>
		<div>
			<span>주문 번호 : </span><span>${productInfo.orderCode}</span>
		</div>
		<div>
	        <c:set var="orderDate" value="${productInfo.orderDate}"/>
			<span>주문 일자 : </span><span>${fn:substring(orderDate, 0, 19)}</span>
		</div>
		<div>
			<c:set var="submitDate" value="${productInfo.submitDate}"/>
			<span>제출 일자 : </span><span>${fn:substring(submitDate, 0, 19)}</span>
		</div>
		<div>
			<span>제품명 : </span><span>${productInfo.productName}</span>
		</div>
		<div>
			<span>품목명 : </span><span>${productInfo.middleCategory}</span>
		</div>
		<div>
			<span>총 재고 개수 : </span><span>${productInfo.productCount}</span>
		</div>
		<div>
			<span>고객 주문 개수 : </span><span>${productInfo.orderCount}</span>
		</div>
		<div>
			<span>제품 단가 : </span><span id="purchasePrice">${productInfo.purchasePrice}</span>
		</div>
		<div>
			<span>수량 : </span><span><input id="purchaseCount" type="number" oninput="javascript:multiply()" value="0"/> EA</span>
		</div>
		<div class="bar"></div>
		<div style="float: right;">
			<span>합계 (원) : </span><span id="sumAmt"></span>
			<br>
			<span id="sumAmt-han" style="float: right;"></span>
		</div>		
	</div>
</c:if>
