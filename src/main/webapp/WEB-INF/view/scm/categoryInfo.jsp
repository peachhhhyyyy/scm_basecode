<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>카테고리 관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
  /*품목 페이징 처리*/
  var pageSizeLargeCategory = 5;
  var pageBlockSizeLargeCategory = 5;

  /*상호 페이징 처리 */
  var pageSizeMiddleCategory = 5;
  var pageBlockSizeMiddleCategory = 5;

  //OnLoad event
  $(document).ready(function() {
    //품목 목록 조회
    fListLargeCategory();
    //버튼 이벤트 등록
    fRegisterButtonClickEvent();
  });

  /*버튼 이벤트 등록*/
  function fRegisterButtonClickEvent() {
    $('a[name=btn]').click(function(e) {
      e.preventDefault();
      var btnId = $(this).attr('id');
      switch (btnId) {
      case 'btnSaveLargeCategory':
        fSaveLargeCategory(); // save 안에 저장,수정  
        break;
      case 'btnDeleteLargeCategory'://삭제하기
        fDeleteLargeCategory();
        break;
      case 'btnCloseLargeCategory':
        gfCloseModal(); // 모달닫기 
        break;
      }
    });
  }

  /*품목 조회*/
  function fListLargeCategory(currentPage) {
    currentPage = currentPage || 1;

    var param = {
    currentPage : currentPage,
    pageSize : pageSizeLargeCategory
    }
    var resultCallback = function(data) {
      flistLargeCategoryResult(data, currentPage);
    };
    callAjax("/scm/listLargeCategory.do", "post", "text", true, param, resultCallback);
  }

  /*품목 조회 콜백 함수*/
  function flistLargeCategoryResult(data, currentPage) {

    console.log("data : " + data);
    //기존 목록 삭제
    $("#listLargeCategory").empty();
    $("#listLargeCategory").append(data);
    // 총 개수 추출
    var totalLargeCategory = $("#totalLargeCategory").val();
    //페이지 네비게이션 생성
    var paginationHtml = getPaginationHtml(currentPage, totalLargeCategory, pageSizeLargeCategory, pageBlockSizeLargeCategory, 'fListLargeCategory');
    $("#largeCategoryPagination").empty().append(paginationHtml);
    //현재 페이지 설정
    $("#currentPageLargeCategory").val(currentPage);
  }

  /*상호 조회 이전 페이징 설정*/
  function callfListMiddleCategory(l_ct_nm, l_ct_cd) {
    $("#tmpl_ct_nm").val(l_ct_nm);
    $("#tmpl_ct_cd").val(l_ct_cd);

    fListMiddleCategory();
  }
  
  /*상호 목록 조회*/
  function fListMiddleCategory(currentPage) {
    //품목명 매개변수 설정
    currentPage = currentPage || 1;
    
    var l_ct_nm = $("#tmpl_ct_nm").val();
    var l_ct_cd = $("#tmpl_ct_cd").val();
    
    var param = {
        l_ct_nm : l_ct_nm
      , l_ct_cd : l_ct_cd //공급처 코드 변수설정
      , currentPage : currentPage
      , pageSize : pageSizeMiddleCategory
    }

    console.log("l_ct_cd : " + l_ct_cd);
    var resultCallback = function(data) {
      flistMiddleCategoryResult(data, currentPage);
    };
    callAjax("/scm/listMiddleCategory.do", "post", "text", true, param, resultCallback);
  }
  /*품목 조회 콜백 함수*/
  function flistMiddleCategoryResult(data, currentPage) {
    console.log("data : " + data);
    // 상호 정보 + 품목명
    $('#subTitle').text(" - " + $("#tmpl_ct_nm").val());
    //기존 목록 삭제
    $("#listMiddleCategory").empty();
    // 신규 목록 생성
    $("#listMiddleCategory").append(data); 
    // 총 개수 추출
    var totalMiddleCategory = $("#totalMiddleCategory").val();
    //페이지 네비게이션 생성
    var l_ct_nm = $("#tmpl_ct_nm").val();
    var l_ct_cd = $("#tmpl_ct_cd").val();
    
    var paginationHtml = getPaginationHtml(currentPage, totalMiddleCategory, 
        pageSizeMiddleCategory, pageBlockSizeMiddleCategory, 'fListMiddleCategory',[l_ct_nm, l_ct_cd]);
    $("#middleCategoryPagination").empty().append(paginationHtml);
    // 현재 페이지 설정
    $("#currentPageMiddleCategory").val(currentPage);
  }
</script>
</head>
<body>
  <form id="myForm" action="" method="">
    <input type="hidden" id="currentPageLargeCategory" value="1"> 
    <input type="hidden" id="currentPageMiddleCategory" value="1"> 
    <input type="hidden" id="tmpl_ct_nm" value="">  
    <input type="hidden" id="tmpl_ct_cd" value="">
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
                <a href="/system/notice.do" class="btn_set home">메인으로</a> <a class="btn_nav">기준 정보</a> <span class="btn_nav bold">카테고리 정보</span> <a href="" class="btn_set refresh">새로고침</a>
              </p>
              <p class="conTitle">
                <span>품목 정보</span> <span class="fr"> <a href="javascript:fPopModalLargeCategory()" class="btnType blue" name="modal" style="float: right;"> <span>신규등록</span>
                </a>
                </span>
              </p>
              <div class="LargeCategoryList">
                <table class="col">
                  <caption>caption</caption>
                  <colgroup>
                    <col width="10%">
                    <col width="10%">
                  </colgroup>
                  <thead>
                    <tr>
                      <th scope="col">품목코드</th>
                      <th scope="col">품목명</th>
                    </tr>
                  </thead>
                  <tbody id="listLargeCategory"></tbody>
                </table>
              </div>
              <div class="paging_area" id="largeCategoryPagination"></div>
              
              <p class="conTitle mt50">
                      <span>상호 정보<span id="subTitle"></span></span>
                      <span class="fr"> <a href="javascript:fPopModalMiddleCategory()" class="btnType blue" name="modal" style="float: right;"> <span>신규등록</span>
                </a>
                </span>
                      
                   </p>
                   
                   <div class="MiddleCategoryList">
                        <table class="col">
                             <caption>caption</caption>
                             <colgroup>
                                 <col width="15%">
                                 <col width="15%">
                             </colgroup>
                        <thead>
                             <tr>
                                <th scope="col">상호코드</th>
                                <th scope="col">상호명</th>
                             </tr>
                        </thead>
                        <tbody id="listMiddleCategory">
                             <tr>
                                <td colspan="6">품목을 선택해 주세요.</td>
                             </tr>
                        </tbody>
                        </table>
                   </div>
                         
                   <div class="paging_area" id="productMiddleCategory"></div>
            </div>
            <h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
          </li>
        </ul>
      </div>
    </div>
  </form>
</body>
</html>