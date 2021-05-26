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
  <c:set var="nRow" value="${nRow + 1}" />
  <c:forEach items="${refundList}" var="list">
    <tr>
      <!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
      <td>${list.customerCode}</td>
      <td>${list.customerName}</td>
      <td>${list.productName}</td>
      <td>${list.refundQty}</td>
      <td><fmt:formatNumber value="${list.refundAmount}" pattern="#,###"/></td>
      <td><fmt:formatNumber value="${list.refundTax}" pattern="#,###"/></td>
      <td><fmt:formatNumber value="${list.totalRefundAmount}" pattern="#,###"/></td>
      <td>${list.scmManager}</td>     
      <c:set var="date" value="${list.submitDate}"/>
      <td>${fn:substring(date, 0, 11)}</td>
      <c:if test="${list.sttCode eq 4}">
	  	<td><a class="btnType3 color2" href="javascript:allowRefund('${list.orderCode}');">승인</a></td>
      </c:if>
      <c:if test="${list.sttCode ne 4}">
	  	<td>승인완료</td>
      </c:if>
    </tr>
  </c:forEach>
</c:if>
<!-- 이거 중간에 있으면 table 안먹힘  -->
<input type="hidden" id="totcnt" name="totcnt" value="${refundListCnt}" />
