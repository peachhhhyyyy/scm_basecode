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
                <c:forEach items="${refundList}" var="list">
                  <tr>
                    <!--  <td><a href="javascript:fListComnDtlCod(1, '${list.refund_list_no}', '${list.refund_list_no}')">${list.order_cd}</a></td>-->
                    <td><a href="javascript:fadeInModal(null, '${list.refund_list_no}')">${list.refund_list_no}</a></td>
                    <td>${list.order_cd}</td>
                    <td>${list.supply_nm}</td>
                    <td>${list.supply_cd}</td>
                    <td>${list.prod_nm}</td>
                    <td>${list.m_ct_cd}</td>
                    <td>${list.refund_cnt}</td>
                    <c:if test="${ list.refund_date eq null}">
                      <td><fmt:formatDate value="${list.submit_date}" pattern="yyyy-MM-dd" /></td>
                    </c:if>
                    <c:if test="${ list.refund_date ne null}">
                      <td><fmt:formatDate value="${list.refund_date}" pattern="yyyy-MM-dd" /></td>
                    </c:if>
                    <c:if  test="${ list.refund_date eq null}">
                      <td>
                        <a class="btnType3 color2" href="javascript:fPopModalComnGrpCod('${list.refund_list_no}');"><span>반품완료</span></a>
                      </td>
                    </c:if>
                    <c:if  test="${ list.refund_date ne null}">
                      <td>
                        <a class="btnType3 color1");"><span>반품완료</span></a>
                      </td>
                    </c:if>
                  </tr>
                  <c:set var="nRow" value="${nRow + 1}" />
                </c:forEach>
              </c:if>
              
              <input type="hidden" id="totalCntComnGrpCod" name="totalCntComnGrpCod" value ="${totalCount}"/>