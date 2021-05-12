<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
              
              <c:if test="${totalProduct eq 0 }">
                <tr>
                  <td colspan="5">데이터가 존재하지 않습니다.</td>
                </tr>
              </c:if>

              <c:if test="${totalProduct > 0 }">
              <c:set var="nRow" value="${pageSize*(currentPageProduct-1)}" /> 
              <c:forEach items="${listProductModel}" var="list">
                  <tr>
                    <td>${list.product_cd}</td>
                    <td>${list.product_nm}</td>
                    <td>${list.l_ct_nm}</td>
                    <td>${list.stock}</td>
                    <td>${list.price}</td>
              
                    <!-- <td><fmt:formatNumber value="${list.pro_deli_price}" pattern="#,###"/>원</td> -->
                  </tr>
                <c:set var="nRow" value="${nRow + 1}" />
                </c:forEach>
              </c:if>
                      
              <input type="hidden" id="totalProduct" name="totalProduct" value ="${totalProduct}"/>