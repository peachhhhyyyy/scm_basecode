<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/tingle/tingle.css" />]
<link rel="stylesheet" href="${CTX_PATH}/css/view/ctm/cartList.css">

<style type="text/css">

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
		
		/* 장바구니 부분 선택 구매 */
		var selectedCartItem = document.getElementsByName("selectCartItem");
		
		/** OnLoad event */ 

		$(document).ready(function() {
			fListCart(); // 장바구니 목록 조회

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
		
		/** 장바구니 목록 콜백 함수 */
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
		
		// 장바구니 삭제하기 클릭시 모달창
		var deleteModal = new tingle.modal({
		    footer: true,
		    stickyFooter: false,
		    closeMethods: ['overlay', 'button', 'escape'],
		    closeLabel: "Close",
		    cssClass: ['custom-class-1', 'custom-class-2'],
		    onOpen: function() {
		        console.log('modal open');
		    },
		    onClose: function() {
		        console.log('modal closed');
		    },
		    beforeClose: function() {
		        // here's goes some logic
		        // e.g. save content before closing the modal
		        return true; // close the modal
		        return false; // nothing happens
		    }
		});

		// set content
		deleteModal.setContent('<h1>정말 삭제하시겠습니까?</h1>');

		// add a button
		deleteModal.addFooterBtn('삭제', 'tingle-btn tingle-btn--primary', function() {
			
		    console.log("========== myform : "+$("#myForm").serialize());
		    
			var resultCallback = function(data) {
				fDeleteCartItemResult(data);
		    };
		    
		    callAjax("/ctm/deleteCartItem.do", "post", "json", true, $("#myForm").serialize(), resultCallback);    
		   
		});
		
		function fDeleteCartItemResult(data) {
		    
		    var currentPage = $("#currentPageCart").val();
		    
		    if (data.result == "SUCCESS") {
		      
		      // 모달 닫기
		      deleteModal.close();
		      
		      // 장바구니 목록 조회
		      fListCart(currentPage);
		      
		    } else {
		      swal(data.resultMsg);
		    } 
		  }

		// add another button
		deleteModal.addFooterBtn('취소', 'tingle-btn tingle-btn--danger', function() {
		    deleteModal.close();
		});
		
		function fDeleteModal() {
			console.log(deleteModal);
			deleteModal.open();
		}
		
		// 장바구니 주문하기 클릭시 모달창
		var orderModal = new tingle.modal({
		    footer: true,
		    stickyFooter: false,
		    closeMethods: ['overlay', 'button', 'escape'],
		    closeLabel: "Close",
		    cssClass: ['custom-class-1', 'custom-class-2'],
		    onOpen: function() {
		        console.log('modal open');
		    },
		    onClose: function() {
		        console.log('modal closed');
		    },
		    beforeClose: function() {
		        // here's goes some logic
		        // e.g. save content before closing the modal
		        return true; // close the modal
		        return false; // nothing happens
		    }
		});
		
		// set content
		orderModal.setContent('<h1>주문하시겠습니까?</h1>');
		
		// add a button
		orderModal.addFooterBtn('주문', 'tingle-btn tingle-btn--primary', function() {
			orderModal.close();
		});

		// add another button
		orderModal.addFooterBtn('취소', 'tingle-btn tingle-btn--danger', function() {
			orderModal.close();
		});
		
		function fOrderModal() {
			console.log(orderModal);
			orderModal.open();
		};
		
</script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/tingle/tingle.js"></script>
</head>
<body>
<form id="myForm" action=""  method="">
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
								장바구니</span> <a href="javascript:fListCart();" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" style="margin-bottom: 1%; display: flex; justify-content: center; align-items: space-between;">
							<span>장바구니</span>
						</p>						
						
					<div class="CartListFrame">
						<table class="col">
							<caption>caption</caption>
								<colgroup>
									<col width="5%">
									<col width="35%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">선택</th>
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
								<td>						
									<a class="btnType3 color2" href="javascript:fOrderModal();"><span>주문하기</span></a>
								</td>
							<br>
							<br>
						</center>
					</div>

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	</form>
</body>
</html>