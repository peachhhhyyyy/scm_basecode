<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<c:choose>
    <c:when test="${!empty retrunSearchList}">
        <c:if test="${returnSearchCnt eq 0 }">
            <tr>
                <td colspan="9">데이터가 존재하지 않습니다.</td>
            </tr>
        </c:if>
        <c:if test="${returnSearchCnt > 0 }">
            <c:forEach items="${retrunSearchList}" var="list">
		        <tr>
		            <td><a href="javascript:fReturnDetailList('${list.refund_list_no}');">${list.refund_list_no}</a></td>
		            <td>${list.cus_name}</td>
		            <td>${list.m_ct_nm}</td>
		            <td>${list.prod_nm}</td>
		            <td>${list.refund_cnt}</td>
		            <td><fmt:formatNumber value="${list.refund_amt}" pattern="#,###"/></td>
		            <td>${list.warehouse_nm}</td>
		            <td>${list.refund_date}</td>
		            <td>${list.state}</td>
		        </tr>
	        </c:forEach>
	   </c:if>
	   <input type="hidden" id="totCnt" name="totCnt" value="${returnSearchCnt}" />
    </c:when>
    <c:otherwise>
	    <c:if test="${returnlistCnt eq 0 }">
		    <tr>
		        <td colspan="9">데이터가 존재하지 않습니다.</td>
		    </tr>
	    </c:if>
	    <c:if test="${returnlistCnt > 0 }">
		    <c:forEach items="${returnList}" var="list">
		        <tr>
		            <td><a href="javascript:fReturnDetailList('${list.refund_list_no}');">${list.refund_list_no}</a></td>
		            <td>${list.cus_name}</td>
		            <td>${list.m_ct_nm}</td>
		            <td>${list.prod_nm}</td>
		            <td>${list.refund_cnt}</td>
                    <td><fmt:formatNumber value="${list.refund_amt}" pattern="#,###"/></td>
		            <td>${list.warehouse_nm}</td>
		            <td>${list.refund_date}</td>
		            <td>${list.state}</td>
		        </tr>
		    </c:forEach>
	    </c:if>
	    <input type="hidden" id="totCnt" name="totCnt" value="${returnlistCnt}" />
    </c:otherwise>
</c:choose>
