<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${totalCount eq 0 }">
  <tr>
    <td colspan="11">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<c:if test="${totalCount > 0 }">
  <c:set var="nRow" value="${pageSize*(currentPage-1)}" />
  <c:forEach items="${listPcsOrderingOrderModel}" var="list">
    <tr>
      <td><a href="javascript:fListComnDtlCod(1, '${list.purch_list_no}')">${list.purch_list_no}</a></td>
      <td>${list.supply_nm}</td>
      <td>${list.prod_nm}</td>
      <td>${list.l_ct_cd}</td>
      <td>${list.purch_qty}</td>
      <td>${list.purch_total_amt}</td>
      <td>${list.desired_delivery_date}</td>
      <td>${list.warehouse_nm}</td>
      <td>${list.purch_mng_id}</td>
      <td><a class="btnType3 color1" href="javascript:fPopModalComnGrpCod('${list.purch_list_no}','${list.supply_nm}','${list.prod_nm}','${list.l_ct_cd}','${list.purch_qty}','${list.purch_total_amt}','${list.desired_delivery_date}','${list.warehouse_nm}','${list.purch_mng_id}');"><span>발주</span></a></td>
    </tr>
    <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
<input type="hidden" id="totalCount" name="totalCount" value="${totalCount}" />