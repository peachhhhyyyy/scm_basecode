<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 갯수가 0개인 경우 -->
<c:if test="${totalCount eq 0 } }">
  <tr>
    <td colspan="5">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>

<!-- 갯수가 있는 경우 -->
<c:if test="${totalCount > 0 }">
  <c:set var="nRow" value="${pageSize*(currentPage-1) }" />
  <c:forEach items="${supplierInfoModelList}" var="List">
    <tr>
      <td>${list.supply_nm}</td>
      <!-- 공급처명 -->
      <td>${list.supply_mng_nm}</td>
      <!-- 담당자명 -->
      <td>${list.tel}</td>
      <!-- 담당자 연락처 -->
      <td>${list.email}</td>
      <!-- 이메일 -->
      <td>${list.warehouse_nm}</td>
      <!-- 창고명 -->
    </tr>
    <c:set var="nRow" value="${nRow + 1 }" />
  </c:forEach>  
</c:if>
<input type="hidden" id="totalCount" value="${totalCount}" />