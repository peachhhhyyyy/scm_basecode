<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
              
<c:if test="${totalMiddleCategory eq 0 }">
  <tr>
    <td colspan="6">품목을 선택해 주세요.</td>
  </tr>
</c:if>

<c:if test="${totalMiddleCategory > 0 }">
  <c:set var="nRow" value="${pageSize*(currentPageMiddleCategory-1)}" /> 
  <c:forEach items="${listMiddleCategoryModel}" var="list">
    <tr>
      <td>${list.m_ct_cd}</td>
      <td>${list.m_ct_nm}</td>
      <td><a href="javascript:fPopModalMiddleCategory('${list.m_ct_cd}');" class="btnType3 color1"><span>수정</span></a></td>
    </tr>
  <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
        
<input type="hidden" id="totalMiddleCategory" name="totalMiddleCategory" value ="${totalMiddleCategory}"/>