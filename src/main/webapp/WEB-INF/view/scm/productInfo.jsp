<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 데이터가 존재하지 않는 경우 -->
<c:if test="${empty productInfo}">
	<h1>데이터가 존재하지 않습니다.</h1>
</c:if>
<c:if test="${!empty productInfo}">
	<form name="purchaseDirectionInfo" id="purchaseDirectionInfo">
		<input type="hidden" name="orderCode" value="${productInfo.orderCode}">
		<input type="hidden" name="submitDate" value="${productInfo.submitDate}">
		<input type="hidden" name="productCode" value="${productInfo.productCode}">
		<input type="hidden" name="supplyCode" value="${productInfo.supplyCode}">
		<input type="hidden" name="purchaseCount" value="">
		<input type="hidden" name="purchasePrice" value="${productInfo.purchasePrice}">
		<input type="hidden" name="totalAmount" value="">
		<input type="hidden" name="STTcd" value="9">
	</form>
	<h1>발주 지시서</h1>
	<div class="prodInfoContainer">
		<div>
			<span>SCM관리자 : </span><span>${productInfo.scmManager}</span>
		</div>
		<div>
			<span>주문 번호 : </span><span>${productInfo.orderCode}</span>
		</div>
		<div>
	        <c:set var="orderDate" value="${productInfo.orderDate}"/>
			<span>주문 일자 : </span><span>${fn:substring(orderDate, 0, 11)}</span>
		</div>
		<div>
			<c:set var="submitDate" value="${productInfo.submitDate}"/>
			<span>제출 일자 : </span><span>${fn:substring(submitDate, 0, 11)}</span>
		</div>
		<div>
			<span>제품명 : </span><span>${productInfo.productName}</span>
		</div>
		<div>
			<span>상호명 : </span><span>${productInfo.middleCategory}</span>
		</div>
		<div>
			<span>공급처명 : </span><span>${productInfo.supplyName}</span>
		</div>
		<div>
			<span>총 재고 개수 : </span><span>${productInfo.productCount}</span>
		</div>
		<div>
			<span>고객 주문 개수 : </span><span>${productInfo.orderCount}</span>
		</div>
		<div>
			<span>제품 단가 : </span>
			<span id="purchasePrice">
				<input type="hidden" name="hidden_purchasePrice" value="${productInfo.purchasePrice}"/>
				<fmt:formatNumber value="${productInfo.purchasePrice}" pattern="#,###"/> 원
			</span>
		</div>
		<div>
			<span>수량 : </span>
			<span><input id="purchaseCount" 
					 	 type="number" 
					 	 oninput="javascript:purchaseMultiply()" 
					 	 value="${productInfo.orderCount - productInfo.productCount}" 
					 	 min="${productInfo.orderCount - productInfo.productCount}" 
					 	 max="9999999"/> EA
	 	    </span>
		</div>
		<div class="bar"></div>
		<div >
			<span id="sumAmt" style="float: right;"></span>
			<br>
			<span id="sumAmt-han" style="float: right;">&nbsp</span>
		</div>		
	</div>
</c:if>
