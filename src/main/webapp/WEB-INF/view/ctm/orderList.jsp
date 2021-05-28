<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>주문이력 조회</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
  //주문이력 화면 페이징 처리
  var pageSizeProduct = 5; //주문이력 화면 페이지 사이즈
  var pageBlockSizeProduct = 5; //주문이력 화면 페이지 블록 갯수
  
  //OnLoad event
  $(document).ready(function() {
    //주문이력조회
    fOrderHisList();
    //버튼 이벤트 등록
    fRegisterButtonClickEvent();
  });
  
  /*버튼 이벤트 등록*/
  function fRegisterButtonClickEvent() {
    $('a[name=btn]').click(function(e) {
      e.preventDefault();
      var btnId = $(this).attr('id');
      switch (btnId) {
      case 'searchBtn':
        board_search(); // 검색하기
        break;
      case 'btnSaveProduct':
        fSaveProduct(); // save 안에 저장,수정  
        break;
      case 'btnDeleteProduct'://삭제하기
        fDeleteProduct();
        break;
      case 'btnCloseProduct':
        gfCloseModal(); // 모달닫기 
        break;
      }
    });
  }
  

  /*주문이력 조회*/
  function fOrderHisList(currentPage) {
    currentPage = currentPage || 1;
    var searchKey = document.getElementById("searchKey");
    
    var param = {
        currentPage : currentPage,
        pageSize : pageSizeProduct
    }
    var resultCallback = function(data) {
      forderHisListResult(data, currentPage);
    };
    callAjax("/ctm/orderHisList.do", "post", "text", true, param, resultCallback);
  }
  
  
  /*주문이력 조회 콜백 함수*/
  function forderHisListResult(data, currentPage) {
    
    console.log("data : " + data);
    //기존 목록 삭제
    $("#orderHisList").empty();
    $("#orderHisList").append(data);
    // 총 개수 추출
    var totalOrder = $("#totalOrder").val();
    //페이지 네비게이션 생성
    var paginationHtml = getPaginationHtml(currentPage, totalOrder, pageSizeProduct, pageBlockSizeProduct, 'fOrderHisList');
    $("#productPagination").empty().append(paginationHtml);
    //현재 페이지 설정
    $("#currentPageProduct").val(currentPage);
  }  
  
  /* 검색 기능*/
  function board_search(currentPage) {
    currentPage = currentPage || 1;
    var searchKey = document.getElementById("searchKey");
    
    var param = {
      currentPage : currentPage,
      pageSize : pageSizeProduct
    }
    
    
    var resultCallback = function(data) {
      forderHisListResult(data, currentPage);
    };
    callAjax("/ctm/orderHisList.do", "post", "text", true, param, resultCallback);
  }
  
</script>
</head>
<body>
<form id="myForm" action="" method="">
    <input type="hidden" id="currentPageProduct" value="1">
    <input type="hidden" id="currentPageProduct" value="1"> 
    <input type="hidden" name="action" id="action" value="">
    <div id="mask"></div>
    <div id="wrap_area">
    
        <h2 class="hidden">header 영역</h2>
          <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
          <h2 class="hidden">컨텐츠 영역</h2>
          <div id="container">
          <ul>
                  <li class="lnb">
                  <!-- lnb 영역 --> <jsp:include
                       page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
          </li>
          
                  <li class="contents">
                       <!-- contents -->
                       <h3 class="hidden">contents 영역</h3> <!-- content -->
                       <div class="content">
                       
                            <p class="Location">
                                 <a href="/system/notice.do" class="btn_set home">메인으로</a> 
                                 <a class="btn_nav">주문</a>
                                  <span class="btn_nav bold">주문이력 조회</span> 
                                 <a href="" class="btn_set refresh">새로고침</a>
                            </p>
                            
                            <p class="conTitle">
                                 <span>주문이력 조회</span>
                            </p>  
                            
                    <div class="ProductList">
                    <div class="conTitle" style="margin: 0 25px 10px 0; float: left; width: 100%">
                            <a href="" class="btnType blue" id="searchBtn" name="btn"> 
                            <span>검 색</span>
                            </a> 
                    </div>
                         <table class="col">
                                <caption>caption</caption>
                                    <colgroup>
                                    <col width="12%">
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="5%">
                                    <col width="5%">
                                    <col width="10%">
                                    <col width="13%">
                                    <col width="13%">
                                    <col width="7%">
                                    <col width="5%">
                                    <col width="5%">
                                    <col width="5%">
                                </colgroup> 
                                
                                 <thead>
                                    <tr>
                                        <th scope="col">제품명</th>
                                        <th scope="col">제품코드</th>
                                        <th scope="col">품목명</th>
                                        <th scope="col">주문번호</th>
                                        <th scope="col">주문수량</th>
                                        <th scope="col">결제금액</th>
                                        <th scope="col">구매일자</th>   
                                        <th scope="col">배송희망날짜</th>
                                        <th scope="col">배송상태</th>
                                        <th scope="col">입금</th>
                                        <th scope="col">반품</th>
                                        <th scope="col">수취확인</th>
                                    </tr>
                                </thead>  
                                <tbody id="orderHisList"></tbody>                      
                         </table>  
                   </div>
                       
                   <div class="paging_area" id="productPagination"></div>
                  </li>
              </ul>
          </div>     
    </div>
</form>
</body>
</html>