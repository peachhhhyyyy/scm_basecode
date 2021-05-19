<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 갯수가 0인 경우  -->
<c:if test="${totalCount eq 0 }">
  <tr>
    <td colspan="7">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<!-- 갯수가 있는 경우  -->
<c:if test="${totalCount > 0 }">
  <c:forEach items="${scmPurchaseOrderingOrderModel}" var="list">
    <tr>
      <td><a href="javascript:fReturnDetailList('${list.purch_list_no}');">${list.purch_list_no}</a></td>
      <td>${list.prod_nm}</td>
      <td>${list.m_ct_cd}</td>
      <td>${list.supply_nm}</td>
      <td>${list.purch_qty}</td>
      <td>${list.scm_id}</td>
      <td><fmt:formatDate value="${list.direction_date}" pattern="yyyy-MM-dd" /></td>
    </tr>
  </c:forEach>
</c:if>
<input type="hidden" id="totalCount" name="totalCount" value="${totalCount}" />