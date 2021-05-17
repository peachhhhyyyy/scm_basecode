<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
              
<c:if test="${totalCountPro eq 0 }">
  <tr>
    <td colspan="6">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>

<c:if test="${totalCountPro > 0 }">
  <c:set var="nRow" value="${pageSize*(currentPage-1)}" /> 
  <c:forEach items="${supplierProModelList}" var="list">
    <tr>
    
      <td>${list.supply_nm}</td>
      <td>${list.product_cd}</td>
      <td>${list.prod_nm}</td>
      <td>${list.l_ct_nm}</td>
      <td>${list.stock}</td>
      <td>${list.price}</td>
    </tr>
  <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
        
<input type="hidden" id="totalCountPro" name="totalCountPro" value ="${totalCountPro}"/>