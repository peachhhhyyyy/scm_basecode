<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${cusListCnt eq 0 }">
    <tr>
      <td colspan="7">데이터가 존재하지 않습니다.</td>
    </tr>
</c:if>
<c:if test="${cusListCnt > 0 }">
    <c:forEach items="${cusList}" var="list">
        <tr>
            <td><a href="javascript:fOrderDetailList('${list.company_nm}');">${list.company_nm}</a></td>
            <td>${list.company_mng_nm}</td>
            <td>${list.mng_tel}</td>
            <td>${list.active}</td>
        </tr>
    </c:forEach>
</c:if>
<input type="hidden" id="totCnt" value="${cusListCnt}" />
