<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="divEmpty">
	<div class="hiddenData"></div>
	<table class="col">
		<thead>
			<tr>
				<th scope="col">배송코드</th>
				<th scope="col">주문코드</th>
				<th scope="col">품목명</th>
				<th scope="col">제품명</th>
				<th scope="col">수량</th>
				<th scope="col">고객명</th>
				<th scope="col">고객연락처</th>
				<th scope="col">주소</th>
				<th scope="col">SCM담당자명</th>
				<th scope="col">배송사원</th>
				<th scope="col">배송사원 연락처</th>
				<th scope="col">창고명</th>
				<th scope="col">도착예정일자</th>
				<th scope="col">배송상태</th>
			</tr>
		</thead>
		<tbody id="outgoingDetailList">
			<c:forEach items="${outgoingDetailList}" var="list">
				<tr>
					<td>${list.ship_list_no}</td>
					<td>${list.order_cd}</td>
					<td>${list.m_ct_nm}</td>
					<td>${list.prod_nm}</td>
					<td>${list.order_cnt}</td>
					<td>${list.name_customer}</td>
					<td>${list.tel_customer}</td>
					<td>${list.addr}</td>
					<td>${list.name_scm}</td>
					<!-- 배송사원설정 -->
					<td>
						<c:if test="${!empty dlvStaffNameCombo}">
							<select style="width: 75px;">
								<c:forEach items="${dlvStaffNameCombo}" var="list">
								    <option value="${list.dlv_staff_name}">${list.dlv_staff_name}</option>
								</c:forEach>
							</select>
					   </c:if>
				    </td>
					<td>${list.tel_delivery}</td>
					<td>${list.warehouse_nm}</td>
					<!-- 도착예정일자 -->
					<td><input type="date" name="arrPrevDate" id="arrPrevDate" style="width: 110px; height: 28px;"></td>
					<!-- 주문상태변경 -->
					<td>
						<select style="width: 75px;">
							<option value="dlving">배송중</option>
							<option value="comdlv">배송완료</option>
						</select>
                    </td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>