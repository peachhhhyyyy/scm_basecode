<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
    <c:when test="${!empty outgoingSearchList}">
		<c:if test="${outgoingSearchCnt eq 0 }">
		    <tr>
		      <td colspan="7">데이터가 존재하지 않습니다.</td>
		    </tr>
		</c:if>
		<c:if test="${outgoingSearchCnt > 0 }">
		    <c:forEach items="${outgoingSearchList}" var="list">
		        <tr>
		            <td><a href="javascript:fOrderDetailList('${list.order_cd}');">${list.order_cd}</a></td>
		            <td>${list.order_date}</td>
		            <td>${list.arr_prev_date}</td>
		            <td>${list.arr_date}</td>
		            <td>${list.name_delivery}</td>
		            <td>${list.warehouse_nm}</td>
		            <td>${list.state}</td>
		        </tr>
		    </c:forEach>
		</c:if>
		<input type="hidden" id="totcnt" value="${outgoingSearchCnt}" />
	</c:when>
	<c:otherwise>
		<c:if test="${outgoingCnt eq 0 }">
			<tr>
			  <td colspan="7">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:if test="${outgoingCnt > 0 }">
			<c:forEach items="${outgoingList}" var="list">
				<tr>
					<td><a href="javascript:fOrderDetailList('${list.order_cd}');">${list.order_cd}</a></td>
					<td>${list.order_date}</td>
					<td>${list.arr_prev_date}</td>
					<td>${list.arr_date}</td>
					<td>${list.name_delivery}</td>
					<td>${list.warehouse_nm}</td>
					<td>${list.state}</td>
				</tr>
			</c:forEach>
		</c:if>
		<input type="hidden" id="totcnt" value="${outgoingCnt}" />
	</c:otherwise>
</c:choose>