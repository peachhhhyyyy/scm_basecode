<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${totalSupplier eq 0 }">
  <tr>
    <td colspan="8">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<c:if test="${totalSupplier > 0}">
  <c:set var="nRow" value="${pageSize*(currentPageSupplier-1)}" />
  <c:forEach items="${listSupplierModel}" var="list">
    <tr>
      <td>${list.supply_cd}</td>
      <td><a href="javascript:callfListProduct('${list.supply_nm}','${list.supply_cd}');">${list.supply_nm}</a></td>
      <td>${list.tel}</td>
      <td>${list.supply_mng_nm}</td>
      <td>${list.mng_tel}</td>
      <td>${list.email}</td>
      <td>${list.warehouse_nm}</td>
      <td><a href="javascript:fPopModalSupplier('${list.supply_cd}');" class="btnType3 color1"><span>수정</span></a></td>
    </tr>
    <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
<input type="hidden" id="totalSupplier" name="totalSupplier" value="${totalSupplier}" />