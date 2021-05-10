<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

  
      <c:if test="${totalCntComnDtlCod eq 0 }">
        <tr>
          <td colspan="12">데이터가 존재하지 않습니다.</td>
        </tr>
      </c:if>
      <c:if test="${totalCntComnGrpCod > 0 }">
      <c:set var="nRow" value="${pageSize*(currentPageComnDtlCod-1)}" />
      <c:forEach items="${divReturnModel}" var="list">
        <tr>
          <td>${totalCntComnDtlCod - nRow}</td>
          <td>${list.refund_list_no}</td>
          <td>${list.order_cd}</td>
          <td>${list.submit_date}</td>
          <td>${list.approve_id}</td>
          <td>${list.ship_staff_id}</td>
          <td>${list.ship_mng_id}</td>
          <td>${list.refund_date}</td>
          <td><a class="btnType3 color1" href="javascript:fPopModalComnDtlCod('${list.refund_date}','${list.refund_date}');"><span>수정</span></a></td>
        </tr>
        <c:set var="nRow" value="${nRow + 1}" />
      </c:forEach>
      </c:if>
 <input type="hidden" id="totalCntComnGrpCod" name="totalCntComnGrpCod" values="${totalCntComnGrpCod}" />