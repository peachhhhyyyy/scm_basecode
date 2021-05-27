<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${totalCntCart eq 0 }">
	<tr>
		<td colspan="11">장바구니에 담긴 상품이 없습니다.</td>
	</tr>
</c:if>

<c:if test="${totalCntCart > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPageCart-1)}" />
	<c:forEach items="${listCartModel}" var="list">
		<tr>
			<td><input id="selectCartItem_${list.product_cd}" type="checkbox" name="selectCartItem"  checked="checked" value="${list.price * list.shopping_cart_qty * 1.1}" class="checkSelect"></td>
			<!-- 제품이미지 -->
			<td><img style="height: 200px;"
				src="http://img.danawa.com/prod_img/500000/135/584/img/12584135_1.jpg?shrink=360:360&_v=20201030144612" />
				<!-- 제품명 -->
				<div><input type="hidden" name="listprodnm" value="${list.prod_nm}" />${list.prod_nm}</div> <br>
				<!-- 제품상세설명 -->
				<div>${list.detail}</div> <br></td>
			<!-- 품목명 -->
			<td>${list.l_ct_nm}</td>
			<!-- 상호명 -->
			<td>${list.m_ct_nm}</td>
			<!-- 제품코드 -->
			<td>${list.product_cd}</td>
			<!-- 수량 -->
			<td><input id="${list.product_cd}" type="number" name="qtyCount"
				min="1" value="${list.shopping_cart_qty}"
				style="width: 50px; text-align: right;" /></td>
			<!-- 제품당 총 금액 -->
			<td id="${list.product_cd}amount">
			   <input name="listprice" type="hidden" value="${list.price * list.shopping_cart_qty * 1.1}">
				 <fmt:formatNumber type="number" minFractionDigits="0" value="${list.price * list.shopping_cart_qty * 1.1}" /><!-- 가격 -->
			</td>
			<!-- 삭제버튼 -->
			<td><a class="btnType3 color1" href="javascript:fDeleteModal();"><span>삭제하기</span></a>
			</td>
			<!-- 신청취소 버튼 -->
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
		<input type="hidden" id="product_cd" name="product_cd" value="${list.product_cd}" />
	</c:forEach>
</c:if>

<input type="hidden" id="totalCntCart" name="totalCntCart" value="${totalCntCart}" />