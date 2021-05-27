<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:if test="${totalCount eq 0 }">
  <tr>
    <td colspan="5">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<c:if test="${totalCount > 0 }">
  <c:forEach items="${employeeInfoModel}" var="list">
    <tr>
      <td>${list.loginId}</td>
      <td><a href="javascript:fPopScmPcsOrderingOrder('${list.scm_id}', '${list.direction_date}', '${list.prod_nm}', '${list.purch_qty}', '${list.m_ct_cd}', '${list.purchase_price}', '${list.supply_nm}', '${list.price}', '${list.approve_id}');">${list.prod_nm}</a></td>
      <td>${list.user_type}</td>
      <td>${list.tel}</td>
      <td>${list.scm_id}</td>
    </tr>
  </c:forEach>
</c:if>
<input type="hidden" id="totalCount" name="totalCount" value="${totalCount}" />