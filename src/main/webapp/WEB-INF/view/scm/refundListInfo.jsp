<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 갯수가 0인 경우  -->
<c:if test="${refundListCnt eq 0 }">
  <tr>
    <td colspan="13">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<!-- 갯수가 있는 경우  -->
<c:if test="${refundListCnt > 0 }">
  <c:set var="nRow" value="${pageSize*(currentPage-1)}" />
  <c:forEach items="${refundList}" var="list">
    <tr>
      <!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
      <td><a href="javascript:getRefundDetail('${list.orderCode}')">${list.orderCode}</a></td>
      <td>${list.customerName}</td>
      <td>${list.productName}</td>
      <td>${list.middleCategory}</td>
      <c:set var="date" value="${list.refundDate}"/>
      <td>${fn:substring(date, 0, 11)}</td>
      <td>${list.refundCount}</td>
      <td><fmt:formatNumber value="${list.refundAmount}" pattern="#,###"/></td>
      <c:set var="state" value="${list.state}"/>
      <td>${fn:substring(state, 0, 4)}</td>
    </tr>
    <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
<!-- 이거 중간에 있으면 table 안먹힘  -->
<input type="hidden" id="totcnt" name="totcnt" value="${refundListCnt}" />
