<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${totalCount eq 0}">
  <tr>
    <td colspan="4">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>

<c:if test="${totalCount > 0}">
  <c:set var="nRow" value="${pageSize*(currentPage - 1)}" />
  <c:forEach items="${noticeList}" var="notice">
    <tr>
      <td>${notice.notice_id}</td>
      <td><a href="javascript:fadeInModal('r','${notice.notice_id}')">${notice.title}</a></td>
      <td>${notice.date}</td>
      <td>${notice.view_cnt}</td>
      <!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
    </tr>
    <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
<input type="hidden" id="totalCount" name="totalCount" value="${totalCount}" />
