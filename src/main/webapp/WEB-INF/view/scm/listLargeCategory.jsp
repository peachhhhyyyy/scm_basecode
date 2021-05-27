<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${totalLargeCategory eq 0 }">
  <tr>
    <td colspan="8">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<c:if test="${totalLargeCategory > 0}">
  <c:set var="nRow" value="${pageSize*(currentPageLargeCategory-1)}" />
  <c:forEach items="${listLargeCategoryModel}" var="list">
    <tr>
      <td>${list.l_ct_cd}</td>
      <td><a href="javascript:callfListMiddleCategory('${list.l_ct_nm}','${list.l_ct_cd}');">${list.l_ct_nm}</a></td>
      <td><a href="javascript:fPopModalLargeCategory('${list.l_ct_cd}');" class="btnType3 color1"><span>수정</span></a></td>
    </tr>
    <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
<input type="hidden" id="totalLargeCategory" name="totalLargeCategory" value="${totalLargeCategory}" />