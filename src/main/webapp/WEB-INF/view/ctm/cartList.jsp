_<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
				
							<c:if test="${totalCntCart eq 0 }">
								<tr>
									<td colspan="11">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCntCart > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPageCart-1)}" />
								<c:forEach items="${listCartModel}" var="list">
									<tr>
										<td>
											<input type="checkbox" name="selectCartItem" value="${list.product_cd}">
										</td>
										<td>
											<img style="height: 200px;" src="http://img.danawa.com/prod_img/500000/135/584/img/12584135_1.jpg?shrink=360:360&_v=20201030144612"/>
											<div>${list.prod_nm}</div>
											<br>
											<div>${list.detail}</div>
											<br>
										</td>		<!-- 제품명 -->
										<td>${list.l_ct_nm}</td>		<!-- 품목명 -->
										<td>${list.m_ct_nm}</td>		<!-- 브랜드명 -->
										<td>${list.product_cd}</td>		<!-- 제품코드 -->
										<td><input id="${list.product_cd}count" 
												   type="number" 
												   min="0" 
												   value="${list.shopping_cart_qty}"
												   style="width: 50px; text-align: right;"/>
						   		        </td>		
						   		       	<td>
						   		       		<fmt:formatNumber value = "${list.price}" pattern = "###,###,###" /> <!-- 가격 --> 
						   		       	</td>	
										<td>						
											<a class="btnType3 color1" href="javascript:fDeleteModal();"><span>삭제하기</span></a>
										</td> <!-- 신청취소 버튼 -->
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
									<input type="hidden" id="product_cd" name="product_cd" value="${list.product_cd}"/>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCntCart" name="totalCntCart" values="${totalCntCart}"/>