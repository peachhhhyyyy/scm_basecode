<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${scmOutgoingListCnt eq 0 }">
	<tr>
	  <td colspan="5">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>
<c:if test="${scmOutgoingListCnt > 0 }">
	<c:forEach items="${outgoingList}" var="list">
		<tr>
		    <td><a href="javascript:fOutgoingDetailList('${list.ship_list_no}');">${list.ship_list_no}</a></td>
		    <td>${list.order_cd}</td>
			<td>${list.cus_nm}</td>
			<td>${list.scm_nm}</td>
			<td>${list.order_date}</td>
			<td>${list.submit_date}</td>
		</tr>
	</c:forEach>
</c:if>
<input type="hidden" id="totCnt" name="totCnt" value="${scmOutgoingListCnt}" />
