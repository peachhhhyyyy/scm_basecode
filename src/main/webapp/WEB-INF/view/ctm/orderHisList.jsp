<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
              
<c:if test="${totalOrder eq 0 }">
  <tr>
    <td colspan="6">구매하신 내역이 없습니다.</td>
  </tr>
</c:if>

<c:if test="${totalOrder > 0 }">
  <c:set var="nRow" value="${pageSize*(currentPageProduct-1)}" /> 
  <c:forEach items="${orderHisListModel}" var="list">
    <tr>
      <td>${list.prod_nm}</td>
      <td>${list.product_cd}</td>
      <td>${list.l_ct_nm}</td>
      <td>${list.order_cd}</td>
      <td>${list.order_cnt}</a></td>
      <td>${list.amount + list.tax}</td>
      <td>${list.order_date}</td>
      <td>${list.want_receive_date}</td>
      <td>${list.state}</td>
      <td><a href="" class="btnType3 color1"><span>입금</span></a></td>
      <td><a href="" class="btnType3 color1"><span>반품</span></a></td>
      <td><a href="" class="btnType3 color1"><span>확인</span></a></td>
    </tr>
  <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
        
<input type="hidden" id="totalOrder" name="totalOrder" value ="${totalOrder}"/>