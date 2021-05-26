<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${totalMainProduct eq 0 }">
  <tr>
    <td colspan="7">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<c:if test="${totalMainProduct > 0}">
  <c:set var="nRow" value="${pageSize*(currentPageMainProduct-1)}" />
  <c:forEach items="${listMainProductModel}" var="list">
    <tr>
      <td>${list.product_cd }</td>
      <td><a href="javascript:fPopModalMainProductModal('${list.product_cd}');">${list.prod_nm}</a></td>
      <td>${list.l_ct_nm}</td>
      <td>${list.m_ct_nm}</td>
      <td>${list.warehouse_nm}</td>
      <td><fmt:formatNumber value="${list.purchase_price}" pattern="#,###"/></td>
      <td><fmt:formatNumber value="${list.price}" pattern="#,###"/></td>
      <td><a href="javascript:fPopModalMainProduct('${list.product_cd}');" class="btnType3 color1"><span>수정</span></a></td>
    </tr>
    <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
<input type="hidden" id="totalMainProduct" name="totalMainProduct" value="${totalMainProduct}" />
