<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 갯수가 0인 경우  -->
<c:if test="${purchaseListCnt eq 0 }">
  <tr>
    <td colspan="13">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<!-- 갯수가 있는 경우  -->
<c:if test="${purchaseListCnt > 0 }">
  <c:set var="nRow" value="${pageSize*(currentPage-1)}" />
  <c:set var="nRow" value="${nRow + 1}" />
  <c:forEach items="${purchaseList}" var="list">
    <tr>
      <!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
      <td>${list.supplyCode}</td>
      <td>${list.supplyName}</td>
      <td>${list.productName}</td>
      <td>${list.purchaseQty}</td>
      <td>${list.purchaseTotalAmount}</td>
      <td>${list.scmManager}</td>
      <c:set var="date" value="${list.directionDate}"/>
      <td>${fn:substring(date, 0, 11)}</td>
      <c:if test="${list.sttCode eq 9}">
	  	<td><a class="btnType3 color2" href="javascript:allowPurchase('${list.orderCode}');">승인</a></td>
      </c:if>
      <c:if test="${list.sttCode eq 10}">
	  	<td>승인완료</td>
      </c:if>
    </tr>
  </c:forEach>
</c:if>
<!-- 이거 중간에 있으면 table 안먹힘  -->
<input type="hidden" id="totcnt" name="totcnt" value="${purchaseListCnt}" />
