<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>          
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
              <c:if test="${totalCount eq 0 }">
                <tr>
                  <td colspan="9">데이터가 존재하지 않습니다.</td>
                </tr>
              </c:if>
              <c:if test="${totalCount > 0 }">
                <c:set var="nRow" value="${pageSize*(currentPage - 1)}" />
                <c:forEach items="${refundList}" var="refund">
                  <tr>
                    
                    <td>
                      <input type="hidden" id="return_price" value="${refund.return_price}">
                      ${refund.purch_list_no}
                    </td>
                    <td><a href="javascript:fadeInModal('${refund.purch_list_no}')">${refund.order_cd}</a></td>
                    <td>${refund.supply_nm}</td>
                    <td>${refund.supply_cd}</td>
                    <td>${refund.prod_nm}</td>
                    <td>${refund.m_ct_nm}</td>
                    <td>${refund.return_qty}</td>
                    <c:if test="${ refund.return_date eq null}">
                      <td></td>
                    </c:if>
                    <c:if test="${ refund.return_date ne null}">
                      <td>${refund.return_date}</td>
                    </c:if>
                    <c:if  test="${ refund.return_date eq null}">
                      <td>
                        <a class="btnType3 color2" href="javascript:insertReturnDate('${refund.purch_list_no}', '${currentPage}', '${refund.order_cd}', '${refund.supply_cd}')"><span>반품완료</span></a>
                      </td>
                    </c:if>
                    <c:if  test="${ refund.return_date ne null}">
                      <td>
                        <p><span>반품완료</span></p>
                      </td>
                    </c:if>
                  </tr>
                  <c:set var="nRow" value="${nRow + 1}" />
                </c:forEach>
              </c:if>
              <input type="hidden" id="totalCount" name="totalCount" value ="${totalCount}"/>