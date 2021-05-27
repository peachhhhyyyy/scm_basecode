<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${totalWarehouse eq 0 }">
  <tr>
    <td colspan="8">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<c:if test="${totalWarehouse > 0}">
  <c:set var="nRow" value="${pageSize*(currentPageWarehouse-1)}" />
  <c:forEach items="${listWarehouseModel}" var="list">
    <tr>
      <td>${list.warehouse_cd }</td>
      <td><a href="javascript:callfListProduct('${list.warehouse_nm}','${list.warehouse_cd}')">${list.warehouse_nm}</a></td>
      <td>${list.wh_mng_nm}</td>
      <td>${list.tel}</td>
      <td>${list.email}</td>
      <td>${list.zip_cd}</td>
      <td>${list.addr} <br> ${list.addr_detail}</td>
      <td><a href="javascript:fPopModalWarehouse('${list.warehouse_cd}');" class="btnType3 color1"><span>수정</span></a></td>
    </tr>
    <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
<input type="hidden" id="totalWarehouse" name="totalWarehouse" value="${totalWarehouse}" />
