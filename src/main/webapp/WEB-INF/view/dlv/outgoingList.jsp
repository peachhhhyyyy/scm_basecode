<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 갯수가 0인 경우  -->
<c:if test="${outgoingCnt eq 0 }">
  <tr>
    <td colspan="4">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<!-- 갯수가 있는 경우  -->
<c:if test="${outgoingCnt > 0 }">
  <c:forEach items="${outgoingList}" var="list">
    <tr>
      <!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
      <td>${list.order_date}</td>
      <td>${list.arr_date}</td>
      <td>${list.arr_prev_date}</td>
      <td><a href="javascript:fOrderDetailList('${list.order_cd}');">${list.order_cd}</a></td>
      <td>${list.name_delivery}</td>
      <td>${list.warehouse_nm}</td>
      <td>${list.state}</td>
    </tr>
  </c:forEach>
</c:if>
<!-- 이거 중간에 있으면 table 안먹힘  -->
<input type="hidden" id="totcnt" name="totcnt" value="${outgoingCnt}" />
