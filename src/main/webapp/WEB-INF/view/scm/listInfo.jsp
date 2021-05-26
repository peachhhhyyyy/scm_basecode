<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 갯수가 0인 경우  -->
<c:if test="${orderListCnt eq 0 }">
  <tr>
    <td colspan="13">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<!-- 갯수가 있는 경우  -->
<c:if test="${orderListCnt > 0 }">
  <c:set var="nRow" value="${pageSize*(currentPage-1)}" />
  <c:forEach items="${orderList}" var="list">
    <tr>
      <!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
      <td>${list.orderCode}</td>
      <c:set var="date" value="${list.orderDate}"/>
      <td>${fn:substring(date, 0, 11)}</td>
      <td>${list.customerName}</td>
      <td>${list.productName}</td>
      <td>${list.productCount}</td>
      <td><fmt:formatNumber value="${list.productPrice}" pattern="#,###"/></td>
      <td>${list.orderCount}</td>
      <td><fmt:formatNumber value="${list.orderAmount}" pattern="#,###"/></td>
      <td><fmt:formatNumber value="${list.orderTax}" pattern="#,###"/></td>
      <td>${list.depositState}</td>
      <c:choose>
      	<c:when test="${list.state eq '입금대기'}">
      		<td><a class="btnType3 color1" href="javascript:fnotYetDeposit();">배송</a></td>
      		<td><a class="btnType3 color1" href="javascript:fnotYetDeposit();">발주</a></td>
      	</c:when>
      	<c:when test="${list.state eq '입금완료'}">
	      	<c:if test="${list.productCount >= list.orderCount}">
	      		<td><a class="btnType3 color2" href="javascript:deliveryModalOpen('${list.orderCode}');">배송</a></td>
	   			<td><a class="btnType3 color1" href="javascript:fgoToDeliveryBtn();">발주</a></td>
	      	</c:if>
	  	 	<c:if test="${list.productCount < list.orderCount}">
	      		<td><a class="btnType3 color1" href="javascript:fnotEnoughStock();">배송</a></td>
	   			<td><a class="btnType3 color2" href="javascript:purchaseModalOpen('${list.orderCode}');">발주</a></td>
	      	</c:if>
       	</c:when>
		<c:when test="${list.state eq '입고완료'}">
	      		<td><a class="btnType3 color2" href="javascript:deliveryModalOpen('${list.orderCode}');">배송</a></td>
	   			<td><a class="btnType3 color1" href="javascript:fgoToDeliveryBtn();">발주</a></td>
		</c:when>
      	<c:otherwise>
      		<td><a class="btnType3 color4">배송</a></td>
      		<td><a class="btnType3 color4">발주</a></td>      		
      	</c:otherwise>
      </c:choose>
      <td>${list.state}</td>
    </tr>
    <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
<!-- 이거 중간에 있으면 table 안먹힘  -->
<input type="hidden" id="totcnt" name="totcnt" value="${orderListCnt}" />
