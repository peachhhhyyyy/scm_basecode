<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>주문</title>

<script type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
  
  // 주문화면 페이징 설정
  var pageSizeProductList = 5; // 페이지 네비게이션에 표시할 페이지 수
  var pageBlockSizeProductList = 5; // 그리드에 출력할 목록의 개수
  
  /* Onload event */
  
  $(document).ready(function() {
	  
	  // 제품 조회
	  fListProductList();
	  
	  // 버튼 이벤트 등록
	  fRegisterButtonClickEvent();
	  
  });
  
  function fListProductList(currentPage){
	  
	  // 현재 페이지
	  currentPage = currentPage || 1;
	  
	  console.log("currentPage : " + currentPage);
	  
	  // controller로 전달한 파라미터
	  var param = {
			 	  currentPage : currentPage
			  ,	  pageSize	  : pageSizeProductList	
			  
	  }
	  
	  var resultCallback = function(data) {
		  flistProductListResult(data, currentPage);
	  }
	  
	  // Ajax실행 방식
	  // callAjax("Url", type, return, async or sync방식, 넘겨준거, 값, Callback 함수 이름)
	  callAjax("/ctm/listProductList.do", "post", "text", true, param, resultCallback);
	  
  }
  
  
  
</script>
</head>
<body>
		<ul>
			<li><a href="/order/order.do">주문페이지</a></li>
		</ul>
</body>
</html>