<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
              
<c:if test="${totalProduct eq 0 }">
  <tr>
    <td colspan="6">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>

<c:if test="${totalProduct > 0 }">
  <c:set var="nRow" value="${pageSize*(currentPageProduct-1)}" /> 
  <c:forEach items="${listProductModel}" var="list">
    <tr>
      <td><input id="selectProduct" type="checkbox" name="selectProduct" value="${list.product_cd}" class="checkSelect"></td>
      <td><img style="height: 200px;"
        src="http://img.danawa.com/prod_img/500000/135/584/img/12584135_1.jpg?shrink=360:360&_v=20201030144612" />
      <td>${list.prod_nm}</td>
    </tr>
  <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
        
<input type="hidden" id="totalProduct" name="totalProduct" value ="${totalProduct}"/>