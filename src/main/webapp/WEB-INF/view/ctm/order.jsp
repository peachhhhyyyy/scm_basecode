<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>주문</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
  //주문 화면 페이징 처리
  var pageSizeProduct = 5; //주문 화면 페이지 사이즈
  var pageBlockSizeProduct = 5; //주문 화면 페이지 블록 갯수
  
  //OnLoad event
  $(document).ready(function() {
    //상품 목록 조회
    fProductList();
    //버튼 이벤트 등록
    fRegisterButtonClickEvent();
    //엔터눌렀을때 창고정보 검색되게하기
    $("#sname").keypress(function (e) {
          if (e.which == 13){
                    board_search();  // 실행할 이벤트
          }
    });       
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
  

  /*제품 목록 조회*/
  function fProductList(currentPage) {
    currentPage = currentPage || 1;
    var sname = $('#sname');
    var searchKey = document.getElementById("searchKey");
    var oname = searchKey.options[searchKey.selectedIndex].value;
    
    var param = {
        sname : sname.val(),
        oname : oname,
        currentPage : currentPage,
        pageSize : pageSizeProduct
    }
    var resultCallback = function(data) {
      fproductListResult(data, currentPage);
    };
    callAjax("/ctm/productList.do", "post", "text", true, param, resultCallback);
  }
  
  
  /*공급처 조회 콜백 함수*/
  function fproductListResult(data, currentPage) {
    
    console.log("data : " + data);
    //기존 목록 삭제
    $("#productList").empty();
    $("#productList").append(data);
    // 총 개수 추출
    var totalProduct = $("#totalProduct").val();
    //페이지 네비게이션 생성
    var paginationHtml = getPaginationHtml(currentPage, totalProduct, pageSizeProduct, pageBlockSizeProduct, 'fProductList');
    $("#productPagination").empty().append(paginationHtml);
    //현재 페이지 설정
    $("#currentPageProduct").val(currentPage);
  }  
  
  /* 검색 기능*/
  function board_search(currentPage) {
    currentPage = currentPage || 1;
    var sname = $('#sname');
    var searchKey = document.getElementById("searchKey");
    var oname = searchKey.options[searchKey.selectedIndex].value;
    
    var param = {
      sname : sname.val(),
      oname : oname,
      currentPage : currentPage,
      pageSize : pageSizeProduct
    }
    
    
    var resultCallback = function(data) {
      fproductListResult(data, currentPage);
    };
    callAjax("/ctm/productList.do", "post", "text", true, param,
        resultCallback);
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
                                  <span class="btn_nav bold">주문</span> 
                                 <a href="" class="btn_set refresh">새로고침</a>
                            </p>
                            
                            <p class="conTitle">
                                 <span>주문</span>
                            </p>  
                            
                    <div class="ProductList">
                    <div class="conTitle" style="margin: 0 25px 10px 0; float: left; width: 100%">
                           <select id="searchKey" name="searchKey" style="width: 10%;" v-model="searchKey">
                           <option value="all" selected="selected">전체</option>
                           <option value="product_l_ct">상호명</option>
                           <option value="product_nm">제품명</option>
                           <option value="product_cd">제품코드</option>
                        </select>
                        <input type="text" style="width: 75%; height: 30px;" id="sname" name="sname">
                            <a href="" class="btnType blue" id="searchBtn" name="btn"> 
                            <span>검 색</span>
                            </a> 
                    </div>
                         <table class="col">
                                <caption>caption</caption>
                                    <colgroup>
                                    <col width="5%">
                                    <col width="30%">
                                    <col width="65%">
                                </colgroup> 
                                
                                <thead>
                                    <tr>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead> 
                                <tbody id="productList"></tbody>                      
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