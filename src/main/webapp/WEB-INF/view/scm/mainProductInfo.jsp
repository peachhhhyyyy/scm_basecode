<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>제품정보 관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/popFindZipCode.js"></script>
<script type="text/javascript">
 /*제품정보 페이징 처리*/
 var pageSizeMainProduct = 10;
 var pageBlockSizeMainProduct = 5;
 
 /*OnLoad event*/
 $(document).ready(function() {
   //제품 목록 조회
   fListMainProduct();
   //버튼 이벤트 등록
   fRegisterButtonClickEvent();
   //엔터눌렀을때 창고정보 검색되게하기
   $("#sname").keypress(function (e) {
         if (e.which == 13){
                   board_search();  // 실행할 이벤트
         }
   });
 });
 
 /** 버튼 이벤트 등록 */
 function fRegisterButtonClickEvent() {
   $('a[name=btn]').click(function(e) {
     e.preventDefault();
     var btnId = $(this).attr('id');
     //alert("btnId : " + btnId);
     switch (btnId) {
     case 'searchBtn':
       board_search(); //  검색하기
       break;
     case 'btnSaveMainProduct'://저장하기
       fSaveMainProduct();
       break;
     case 'btnDeactivateMainProduct'://비활성화하기
       fDeactivateMainProduct();
       break;
     case 'btnCloseMainProduct': //닫기
       gfCloseModal();
       break;
     }
   });
 }
 
 /*제품 조회*/
 function fListMainProduct(currentPage) {
   currentPage = currentPage || 1;
   var sname = $('#sname');
   var searchKey = document.getElementById("searchKey");
   var oname = searchKey.options[searchKey.selectedIndex].value;

   console.log("currentPage : " + currentPage);

   var param = {
   sname : sname.val(),
   oname : oname,
   currentPage : currentPage,
   pageSize : pageSizeMainProduct,
   }
   var resultCallback = function(data) {
     flistMainProductResult(data, currentPage);
   }
   callAjax("/scm/listMainProduct.do", "post", "text", true, param, resultCallback);
 }
 /*제품 조회 콜백 함수*/
 function flistMainProductResult(data, currentPage) {
   //alert(data);
   console.log(data);
   //기존 목록 비활성화
   $('#listMainProduct').empty();
   $("#listMainProduct").append(data);
   // 총 개수 추출
   var totalMainProduct = $("#totalMainProduct").val();
   //페이지 네비게이션 생성
   var paginationHtml = getPaginationHtml(currentPage, totalMainProduct, pageSizeMainProduct, pageBlockSizeMainProduct, 'fListMainProduct');
   $("#mainProductPagination").empty().append(paginationHtml);
   //현재 페이지 설정
   console.log("totalMainProduct: " + totalMainProduct);
   $("#currentPageMainProduct").val(currentPage);
 }

</script>
</head>
<body>
<form id="myForm" action="" method="">
    <input type="hidden" id="currentPageMainProduct" value="1">
    <input type="hidden" name="action" id="action" value="">
    <div id="mask"></div>
    <div id="wrap_area">
      <h2 class="hidden">header 영역</h2>
      <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
      <h2 class="hidden">컨텐츠 영역</h2>
      <div id="container">
        <ul>
          <li class="lnb">
            <!-- lnb 영역 --> <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
          </li>
          <li class="contents">
            <!-- contents -->
            <h3 class="hidden">contents 영역</h3> <!-- content -->
            <div class="content">
              <p class="Location">
                <a href="/system/notice.do" class="btn_set home">메인으로</a> <a class="btn_nav">기준 정보</a> <span class="btn_nav bold">제품정보 관리</span> <a href="" class="btn_set refresh">새로고침</a>
              </p>
              <p class="conTitle">
                <span>제품정보</span> <span class="fr"> <a href="javascript:fPopModalMainProduct()" class="btnType blue" name="modal"> <span>신규등록</span>
                </a>
                </span>
              </p>
              <div class="MainProductList">
                <div class="conTitle" style="margin: 0 25px 10px 0; float: left;">
                           <select id="searchKey" name="searchKey" style="width: 100px;" v-model="searchKey">
                            <option value="all" selected="selected">전체</option>
                           <option value="prod_nm">제품명</option>
                        </select>
                        <input type="text" style="width: 300px; height: 30px;" id="sname" name="sname">
                            <a href="" class="btnType blue" id="searchBtn" name="btn"> 
                            <span>검 색</span>
                            </a> 
                    </div>
                <table class="col">
                  <caption>caption</caption>
                  <colgroup>
                    <col width="12%">
                    <col width="12%">
                    <col width="12%">
                    <col width="12%">
                    <col width="12%">
                    <col width="12%">
                    <col width="12%">
                    <%-- <col width="12%"> --%>
                  </colgroup>
                  <thead>
                    <tr>
                      <th scope="col">제품코드</th>
                      <th scope="col">제품명</th>
                      <th scope="col">모델명</th>
                      <th scope="col">공급처명</th>
                      <th scope="col">창고명</th>
                      <th scope="col">장비구매액(원)</th>
                      <th scopt="col">단가(원)</th>
                      <!-- <th scopt="col">비고</th> -->
                    </tr>
                  </thead>
                  <tbody id="listMainProduct"></tbody>
                </table>
              </div>
              <div class="paging_area" id="mainProductPagination"></div>
            </div> <!--// content -->
            <h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
          </li>
        </ul>
      </div>
    </div>
    
  </form>
</body>
</html>