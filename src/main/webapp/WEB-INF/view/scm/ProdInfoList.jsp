_<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${totalCntProdInfo eq 0 }">
  <tr>
    <td colspan="7">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<c:if test="${totalCntProdInfo > 0 }">
  <c:set var="nRow" value="${pageSize*(currentPage-1)}" />
  <c:forEach items="${listProdInfoModel}" var="list">
    <tr>
      <td>${list.product_cd}</td>
      <!-- 제품코드 -->
      <td>${list.prod_nm}</td>
      <!-- 제품명 -->
      <td>${list.m_ct_nm}</td>
      <!-- 품목명(중분류명) -->
      <td>${list.supply_nm}</td>
      <!-- 공급처명 -->
      <td>${list.warehouse_nm}</td>
      <!-- 창고명 -->
      <td>${list.purchase_price}</td>
      <!-- 장비구매액 -->
      <td>${list.price}</td>
      <!-- 단가 -->
    </tr>
    <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
<input type="hidden" id="totalCntProdInfo" name="totalCntProdInfo" values="${totalCntProdInfo}" />