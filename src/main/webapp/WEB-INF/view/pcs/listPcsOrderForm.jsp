<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${totalCount eq 0 }">
  <tr>
    <td colspan="12">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<c:if test="${totalCount > 0 }">
  <c:set var="nRow" value="${pageSize*(currentPage-1)}" />
  <c:forEach items="${listPcsOrderFormModel}" var="list">
    <tr>
      <td>${list.purch_list_no}</td>
      <td><a href="javascript:fPopPcsOrderForm('${list.purch_list_no}', '${list.order_cd}', '${list.supply_nm}', '${list.prod_nm}', '${list.m_ct_cd}', '${list.warehouse_nm}', '${list.purch_qty}', '${list.purchase_price}', '${list.purch_mng_id}', '${list.direction_date}', '${list.desired_delivery_date}', '${list.supply_cd}', '${list.product_cd}', '${list.detail_name}');">${list.order_cd}</a></td>
      <td>${list.supply_nm}</td>
      <td>${list.prod_nm}</td>
      <td>${list.m_ct_cd}</td>
      <td>${list.purch_qty}</td>
      <td>${list.warehouse_nm}</td>
      <td><fmt:formatDate value="${list.direction_date}" pattern="yyyy-MM-dd" /></td>
      <td><fmt:formatDate value="${list.desired_delivery_date}" pattern="yyyy-MM-dd" /></td>
      <td>${list.detail_name}</td>
      <c:if test="${list.STTcd eq 2}">
      <td><a class="btnType3 color2" href="javascript:void(0);"><span>입고완료</span></a></td>
      <td><a class="btnType3 color1" href="javascript:void(0);"><span>반품</span></a></td>
      </c:if>
      <c:if test="${list.STTcd eq 1}">
      <td><a class="btnType3 color1" href="javascript:void(0);"><span>입고완료</span></a></td>
      <td><a class="btnType3 color2 btn-action" href="javascript:void(0);"><span>반품</span></a></td>
      </c:if>
    </tr>
    <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
<input type="hidden" id="totalCount" name="totalCount" value="${totalCount}" />