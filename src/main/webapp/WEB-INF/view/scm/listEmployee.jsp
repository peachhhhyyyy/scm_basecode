<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${totalCount eq 0 }">
  <tr>
    <td colspan="5">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<c:if test="${totalCount > 0 }">
  <c:forEach items="${employeeInfoModel}" var="list">
    <tr>
      <td>${list.loginID}</td>
      <td><a href="javascript:fPopEmployeeInfo('${list.loginID}','${list.name}','${list.tel}','${list.mail}','${list.detail_name}','${list.zip_code}','${list.addr}','${list.addr_detail}','${list.use_yn}','${list.entry_date}');">${list.name}</a></td>
      <td>${list.detail_name}</td>
      <td>${list.tel}</td>
      <td>${list.use_yn}</td>
    </tr>
  </c:forEach>
</c:if>
<input type="hidden" id="totalCount" name="totalCount" value="${totalCount}" />