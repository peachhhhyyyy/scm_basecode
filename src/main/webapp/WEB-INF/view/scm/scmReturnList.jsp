<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 갯수가 0인 경우  -->
<c:if test="${scmReturnCnt eq 0 }">
  <tr>
    <td colspan="4">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<!-- 갯수가 있는 경우  -->
<c:if test="${scmReturnCnt > 0 }">
  <c:set var="nRow" value="${pageSize*(currentPage-1)}" />
  <c:forEach items="${returnList}" var="list">
    <tr>
      <td><a href="javascript:fReturnDetailList('${list.refund_list_no}');">${list.refund_list_no}</a></td>
      <td>${list.cus_name}</td>
      <td>${list.m_ct_nm}</td>
      <td>${list.prod_nm}</td>
      <td>${list.m_ct_cd}</td>
      <td>${list.return_qty}</td>
      <td>${list.scm_id}</td>
      <td>${list.submit_date}</td>
      <!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
    </tr>
    <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
<!-- 이거 중간에 있으면 table 안먹힘  -->
<input type="hidden" id="scmReturnCnt" name="scmReturnCnt" value="${scmReturnCnt}" />