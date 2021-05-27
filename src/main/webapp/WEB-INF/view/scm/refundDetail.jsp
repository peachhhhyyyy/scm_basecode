<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 데이터가 없는 경우 -->
<c:if test="${empty refundDetail}">
	<h1>데이터가 존재하지 않습니다.</h1>
</c:if>
<!-- 데이터가 있는 경우  -->
<c:if test="${!empty refundDetail}">
	<p class="conTitle" style="margin-bottom: 1%;">
		<span>반품지시서</span>
	</p>
	<table class="col">
		<thead>
			<tr>
				<th>SCM 관리자</th>
				<th>반품지시일자</th>
				<th>제품번호</th>
				<th>주문일자</th>
				<th>제품명</th>
				<th>품목명</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${refundDetail.scmManager}</td>
				<c:set var="refundDirectionDate" value="${refundDetail.refundDirectionDate}"/>
				<td>${fn:substring(refundDirectionDate, 0, 11)}</td>
				<td>${refundDetail.productCode}</td>
				<c:set var="orderDate" value="${refundDetail.orderDate}"/>
				<td>${fn:substring(orderDate, 0, 11)}</td>
				<td>${refundDetail.productName}</td>
				<td>${refundDetail.middleCategory}</td>
			</tr>
		</tbody>
		<thead>
			<tr>
				<th>공급처명</th>
				<th>반품일자</th>
				<th>창고명</th>
				<th>반품수량</th>
				<th>반품금액(원)</th>
				<c:choose>
					<c:when test="${refundDetail.STTcd eq 3}">
						<th>승인</th>
					</c:when>
					<c:when test="${refundDetail.STTcd eq 7}">
						<th>승인자</th>
					</c:when>
					<c:otherwise>
						<th>상태</th>
					</c:otherwise>
				</c:choose>

			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${refundDetail.supplyName}</td>
				<c:set var="refundDate" value="${refundDetail.refundDate}"/>
				<td>${fn:substring(refundDate, 0, 11)}</td>
				<td>${refundDetail.warehouseName}</td>
				<td>${refundDetail.refundCount}</td>
				<td><fmt:formatNumber value="${refundDetail.refundAmount}" pattern="#,###"/></td>
				<c:choose>
					<c:when test="${refundDetail.STTcd eq 3}">
						<td style="display: flex; justify-content: space-around; align-items:center;">
							<a class="btnType3 color2" href="javascript:requestApprove();">승인 요청</a>
							<a class="btnType3 color1" href="javascript:closeRefundDetail();">닫기</a>
						</td>
					</c:when>
					<c:when test="${refundDetail.STTcd eq 7}">
						<td>${refundDetail.approver}</td>
					</c:when>
					<c:otherwise>
						<c:set var="state" value="${refundDetail.state}"/>
						<td>${fn:substring(state, 0, 4)}</td>
					</c:otherwise>
				</c:choose>
			</tr>
		</tbody>
	</table>
	<div class="btn-container">

	</div>
</c:if>
<!-- 이거 중간에 있으면 table 안먹힘  -->
<form id="refundForm">
	<input type="hidden" name="orderCode" value="${refundDetail.orderCode}" />
	<input type="hidden" name="refundDirectionDate" value="${refundDetail.refundDirectionDate}" />
	<input type="hidden" name="STTcd" value="${refundDetail.STTcd}"/>
</form>
