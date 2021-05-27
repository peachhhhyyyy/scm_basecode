<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${scmReturnListCnt eq 0 }">
  <tr>
    <td colspan="7">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<c:if test="${scmReturnListCnt > 0 }">
  <c:forEach items="${returnList}" var="list">
    <tr>
      <td><a href="javascript:fReturnDetailList('${list.refund_list_no}');">${list.refund_list_no}</a></td>
      <td>${list.cus_nm}</td>
      <td>${list.l_ct_nm}</td>
      <td>${list.prod_nm}</td>
      <td>${list.return_cnt}</td>
      <td>${list.scm_nm}</td>
      <td>${list.submit_date}</td>
    </tr>
  </c:forEach>
</c:if>
<input type="hidden" id="totCnt" value="${scmReturnListCnt}" />