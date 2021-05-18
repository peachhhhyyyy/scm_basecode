<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 데이터가 없는 경우 -->
<c:if test="${empty refundDetail}">
	<h1>데이터가 존재하지 않습니다.</h1>
</c:if>
<!-- 데이터가 있는 경우  -->
<c:if test="${!empty refundDetail}">
	<h1>반품 지시서</h1>
	<ul>
		<li>${refundDetail.scmManager}</li>
		<li>${refundDetail.refundDirectionDate}</li>
		<li>${refundDetail.productCode}</li>
		<li>${refundDetail.orderDate}</li>
		<li>${refundDetail.productName}</li>
		<li>${refundDetail.middleCategory}</li>
		<li>${refundDetail.supplyName}</li>
		<li>${refundDetail.refundDate}</li>
		<li>${refundDetail.warehouseName}</li>
		<li>${refundDetail.refundCount}</li>
		<li>${refundDetail.refundAmount}</li>
	</ul>
</c:if>
<!-- 이거 중간에 있으면 table 안먹힘  -->
<input type="hidden" id="" name="" value="" />
