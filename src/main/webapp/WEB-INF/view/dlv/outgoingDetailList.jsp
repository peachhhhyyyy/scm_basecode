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
			</tr>
		</thead>
			<tbody id="outgoingDetailListTop">
	            <c:forEach items="${outgoingDetailList}" var="topList">
	                <tr>
	                    <td><input type="hidden" name="ship_list_no" value="${topList.ship_list_no}"/>${topList.ship_list_no}</td>
	                    <td><input type="hidden" name="order_cd" value="${topList.order_cd}"/>${topList.order_cd}</td>
	                    <td>${topList.m_ct_nm}</td>
	                    <td>${topList.prod_nm}</td>
	                    <td>${topList.order_cnt}</td>
	                    <td>${topList.name_customer}</td>
	                    <td>${topList.tel_customer}</td>
	                    <td>${topList.addr}</td>
	                </tr>
	            </c:forEach>
	        </tbody>
        </table>
       <table class="col">
		<thead>
			<tr>
				<th scope="col">SCM담당자명</th>
				<th scope="col">배송사원</th>
				<th scope="col">배송사원 연락처</th>
				<th scope="col">창고명</th>
				<th scope="col">도착예정일자</th>
				<th scope="col">배송상태</th>
				<th scope="col" colspan="2">요구사항</th>
			</tr>
		</thead>
		<tbody id="outgoingDetailListBottom">
			<c:forEach items="${outgoingDetailList}" var="bottomList">
				<tr>
					<td>${bottomList.name_scm}</td>
					<!-- 배송사원설정 -->
					<td>
						<c:if test="${!empty dlvStaffNameCombo}">
							<select style="width: 75px;" id="getDlvStaffName" name="dlvStaffName" onchange="javascript:fSelectDlvStaffTel();">
							    <option>선택</option>
								<c:forEach items="${dlvStaffNameCombo}" var="listDlvStaffCombo">
								    <!-- 진수형 -> 약간의 꼼수로 DB에서 받아온 name과 ID를 긴 스트링으로 submit함. -->
								    <option value="${listDlvStaffCombo.dlv_staff_name} ${listDlvStaffCombo.loginID}">${listDlvStaffCombo.dlv_staff_name}</option>
								</c:forEach>
							</select>
					   </c:if>
				    </td>
			        <td id="dlvStaffTel"></td>			   
					<td>${bottomList.warehouse_nm}</td>
					<!-- 도착예정일자 -->
					<td>
					   <input 
					       type="date" 
					       name="arrPrevDate" 
					       id="arrPrevDate" 
					       min="${bottomList.arr_date}" 
					       style="width: 130px; 
					               height: 28px; 
					               ">
	               </td>
					<!-- 주문상태변경 -->
					<td>
						<select name="state" style="width: 75px;">
							<option value="14">배송중</option>
							<option value="15">배송완료</option>
						</select>
                    </td>
					<td colspan="2">${bottomList.request}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>