<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 갯수가 0인 경우  -->
<c:if test="${orderListCnt eq 0 }">
  <tr>
    <td>데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<!-- 갯수가 있는 경우  -->
<c:if test="${orderListCnt > 0 }">
  <c:forEach items="${orderList}" var="list">
    <tr>
      <!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
      <td>${list.orderCode}</td>
      <td>${list.orderDate}</td>
      <td>${list.customerName}</td>
      <td>${list.productName}</td>
      <td>${list.productCount}</td>
      <td>${list.productPrice}</td>
      <td>${list.orderCount}</td>
      <td>${list.orderAmount}</td>
      <td>${list.orderTax}</td>
      <td>${list.depositState}</td>
      <td>${list.state}</td>
      <td><button class="btn btn-primary">배송</button></td>
      <td><button class="btn btn-info">발주</button></td>
    </tr>
  </c:forEach>
</c:if>
<!-- 이거 중간에 있으면 table 안먹힘  -->
<input type="hidden" id="totcnt" name="totcnt" value="${orderListCnt}" />