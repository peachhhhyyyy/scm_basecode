<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<style type="text/css">

/*

.ddd{
display:flex;
justify-content: space-around;
}

*/

.btnType{
	float:right;
}

.aaa{
	 margin-bottom:5px;
}

.bbb li{
	float:left;
	margin-right: 30px;
		
}

#CartModal{
	display: none;
}

input[type=number]::-webkit-inner-spin-button, 
input[type=number]::-webkit-outer-spin-button {  
   opacity: 1;

}


</style>

<title>장바구니</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

		/*장바구니 페이징 설정*/

		var pageSizeCart= 10;
		var pageBlockSizeCart = 5;


		/** OnLoad event */ 

		$(document).ready(function() {
	
			
			fListCart(); // 장바구니 신청건 조회
		
		});

		/** 장바구니 조회 */
		function fListCart(currentPage) {
			
			currentPage = currentPage || 1;
			
			console.log("currentPage : " + currentPage);
			
			var param = {
						currentPage : currentPage
					,	pageSize    : pageSizeCart
			}
			
			var resultCallback = function(data) {
				fCartResult(data, currentPage);
			};
			
			callAjax("/ctm/listCart.do", "post", "text", true, param, resultCallback);
		}
		
		/** 그룹코드 조회 콜백 함수 */
		function fCartResult(data, currentPage) {
			
			//alert(data);
			console.log(data);
			
			// 기존 목록 삭제
			$('#listCart').empty();
			
			// 신규 목록 생성
			$("#listCart").append(data);
			
			// 총 개수 추출
			var totalCntCart = $("#totalCntCart").val();
			
			// 페이지 네비게이션 생성
			var paginationHtml = getPaginationHtml(currentPage, totalCntCart, pageSizeCart, pageBlockSizeCart, 'fListCart');
			console.log("paginationHtml : " + paginationHtml);
			//alert(paginationHtml);
			$("#CartPagination").empty().append( paginationHtml );
			
			// 현재 페이지 설정
			$("#currentPageCart").val(currentPage);
			console.log("totalCntCart:: " + totalCntCart);
		}
		
		function fPopModalCart(){
			gfModalPop('#layer1');
		}

		function fEmpModalShow(){
			document.getElementById("CartModal").style.display = "block";
		}
		
		
		
</script>

</head>
<body>

	<input type="hidden" id="currentPageCart" value="1">
	<input type="hidden" id="tmpCart" value="">
	<input type="hidden" id="tmpCartNm" value="">
	<input type="hidden" name="action" id="action" value="">
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--//  영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> <a href="#"
								class="btn_nav">주문</a> <span class="btn_nav bold">
								장바구니</span> <a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>장바구니</span> <span class="fr">
							  <br/>
							</span>
						</p>						
						
					<div class="divDvList">
						<table class="col">
							<caption>caption</caption>
								<colgroup>
									<col width="40%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">제품명</th>
										<th scope="col">품목명</th>
										<th scope="col">제조사명</th>
										<th scope="col">제품코드</th>
										<th scope="col">수량</th>
										<th scope="col">결제금액</th>
										<th scope="col">주문관리</th>
									</tr>
								</thead>
							<tbody id="listCart"></tbody>
						</table>
						<center>
							<br>
								<a class="btnType4 color1"><span>주문하기</span></a>
							<br>
							<br>
						</center>
					</div>
	
					  
					<div id ="CartModal" href="javascript:fCartModal()">
						<form>
						
						아이디<input type = "text" id = "loginID" disabled>
						계정대분류명<select name = "account_cd">
								<option value = "A100">온라인매출</option>
								<option value = "B200">영업매출</option>
								<option value = "C300">급여</option>
								<option	value = "D400">복리후생비</option>
								<option value = "E500">접대비</option>
								<option	value = "F600">통신비</option>
						</select>
						상세코드명<select name="detail_account_cd" id = "detail_account_cd">
								<option value="101">장비구매액</option>
								<option value="102">단가</option>
								<option value="103">부가세</option>
								<option value="104">공급가액</option>
						</select>
						거래처명<input type = "text" id = "loginID">
 						신청일자<input type = "date" id = "dv_app_date" disabled>
 						사용일자<input type = "date" id = "dv_use_date">
 						지출금액<input type = "text" id = "dv_amt">
						<label for = "att_file">첨부파일</label>
						<input type = "file" id = "att_file"/>
						비고<textarea cols="30" rows="10" ></textarea>
						</form>
						<button type = "submit">신청</button>
						<button>닫기</button>
					</div>	
	<!-- 
					<div class="paging_area"  id="dvListPagination">  -->
										
							
					</div>
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

</body>
</html>