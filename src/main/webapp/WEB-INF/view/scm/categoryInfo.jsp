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
    productCombo("l", "l_ct_cd2", "sel", "");
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
      case 'btnSaveMiddleCategory':
        fSaveMiddleCategory(); // save 안에 저장,수정  
        break;
      case 'btnDeleteMiddleCategory'://삭제하기
        fDeleteMiddleCategory();
        break;
      case 'btnCloseCategory':
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
  /*상호 조회 콜백 함수*/
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
  
  /* 품목 모달 실행 */
  function fPopModalLargeCategory(l_ct_cd) {
    //신규 저장
    if (l_ct_cd == null || l_ct_cd == "") {
      $("#action").val("I");
      fInitFormLargeCategory();
      gfModalPop("#largeCategory");
    } else {
      $("#action").val("U");
      fSelectLargeCategory(l_ct_cd);
    }
  }
  
  /* 품목 단건 조회*/
  function fSelectLargeCategory(l_ct_cd) {
    var param = {
        l_ct_cd : l_ct_cd
    };
    var resultCallback = function(data) {
      fSelectLargeCategoryResult(data);
    };
    callAjax("/scm/selectLargeCategory.do", "post", "json", true, param,
        resultCallback);
  }
  
  // 품목 단건 조회 콜백 함수
  function fSelectLargeCategoryResult(data) {
    if (data.result == "SUCCESS") {
      gfModalPop("#largeCategory")
      fInitFormLargeCategory(data.categoryInfoModel);
    } else {
      alert(data.resultMsg);
    }
  }
  
  /* 품목 폼 초기화 */
  function fInitFormLargeCategory(object) {
    $("#l_ct_cd").focus();
    
    if (object == "" || object == null || object == undefined) {
      $("#l_ct_cd").val("");
      $("#l_ct_nm").val("");
      
      $("#l_ct_cd").attr("readonly", false);
      $("#l_ct_cd").css("background", "#FFFFFF");
      $("#l_ct_nm").attr("readonly", false);
      $("#l_ct_nm").css("background", "#FFFFF");
      
      $("#btnDeleteLargeCategory").hide();
    } else{
      $("#l_ct_cd").val(object.l_ct_cd);
      $("#l_ct_nm").val(object.l_ct_nm);
 
      $("#l_ct_cd").attr("readonly", true);
      $("#l_ct_cd").css("background", "#F5F5F5");
      $("#l_ct_nm").attr("readonly", false);
      $("#l_ct_nm").css("background", "#FFFFFF");
      
      $("#btnDeleteLargeCategory").show();
    } 
  } 
  

  /* 품목 저장 validation*/
  function fValidateLargeCategory() {
    var chk = checkNotEmpty([ [ "l_ct_cd", "품목코드를 입력하세요." ], [ "l_ct_nm", "품목명을 입력하세요." ], ]);
    if (!chk) {
      return;

    }
    return true;
  }
  
  //품목 저장
  function fSaveLargeCategory() {
    //validation 체크
    if (!fValidateLargeCategory()) {
      return;
    }
    var resultCallback = function(data) {
       console.log(data);
       fSaveLargeCategoryResult(data);
    };
    callAjax("/scm/saveLargeCategory.do", "post", "json", true, $("#myForm")
        .serialize(), resultCallback);
  }
  
  //품목 저장 콜백 함수
  function fSaveLargeCategoryResult(data) {
    var currentPage = "1";
    if ($("#action").val() != "I") {
      currentPage = $("#currentPageLargeCategory").val();
    }
    if (data.result == "SUCCESS") {
      alert(data.resultMsg);
      gfCloseModal();
      fListLargeCategory(currentPage);
    } else {
      alert(data.resultMsg);
    }
  }
  
  //품목 삭제
  function fDeleteLargeCategory(l_ct_cd){
  var con = confirm("삭제하시겠습니까 ?");
  var currentPage = "1";
  if (con){
    var resultCallback = function(data) {
    fSaveLargeCategoryResult(data);
  }
  $("#action").val("D");
  callAjax("/scm/saveLargeCategory.do", "post", "json", true, $("#myForm").serialize(), resultCallback );
  } else {
    gfCloseModal();
  }
} 

  /* 상호 모달 실행 */
  function fPopModalMiddleCategory(m_ct_cd) {
    //신규 저장
    if (m_ct_cd == null || m_ct_cd == "") {
/*       if ($("#tmpl_ct_cd").val() == "") {
        swal("품목을 선택해 주세요.");
        return;
      } */

      $("#Maction").val("I");
      fInitFormMiddleCategory();
      gfModalPop("#middleCategory");
    } else {
      $("#Maction").val("U");
      fSelectMiddleCategory(m_ct_cd);
    }
  }

  /* 상호 단건 조회*/
  function fSelectMiddleCategory(m_ct_cd) {
    var param = {
      m_ct_cd : m_ct_cd
    };
    var resultCallback = function(data) {
      fSelectMiddleCategoryResult(data);
    };
    callAjax("/scm/selectMiddleCategory.do", "post", "json", true, param, resultCallback);
  }

  // 상호 단건 조회 콜백 함수
  function fSelectMiddleCategoryResult(data) {
    if (data.result == "SUCCESS") {
      gfModalPop("#middleCategory")
      fInitFormMiddleCategory(data.categoryInfoModel);
    } else {
      alert(data.resultMsg);
    }
  }

  /* 상호 폼 초기화 */
  function fInitFormMiddleCategory(object) {
    $("#m_ct_cd2").focus();

    if (object == "" || object == null || object == undefined) {
      $("#l_ct_cd2").val("");
      $("#l_ct_nm2").val("");
      $("#m_ct_cd2").val("");
      $("#m_ct_nm2").val("");

      $("#l_ct_cd2").attr("readonly", true);
      $("#l_ct_cd2").css("background", "#F5F5F5");
      $("#l_ct_nm2").attr("readonly", true);
      $("#l_ct_nm2").css("background", "#F5F5F5");
      $("#m_ct_cd2").attr("readonly", false);
      $("#m_ct_cd2").css("background", "#FFFFFF");
      $("#m_ct_nm2").attr("readonly", false);
      $("#m_ct_nm2").css("background", "#FFFFFF");

      $("#btnDeleteMiddleCategory").hide();
    } else {
      $("#l_ct_cd2").val(object.l_ct_cd);
      $("#l_ct_nm2").val(object.l_ct_cd);
      $("#m_ct_cd2").val(object.m_ct_cd);
      $("#m_ct_nm2").val(object.m_ct_nm);

      $("#l_ct_cd2").attr("readonly", true);
      $("#l_ct_cd2").css("background", "#F5F5F5");
      $("#l_ct_nm2").attr("readonly", true);
      $("#l_ct_nm2").css("background", "#F5F5F5");
      $("#m_ct_cd2").attr("readonly", true);
      $("#m_ct_cd2").css("background", "#F5F5F5");
      $("#m_ct_nm2").attr("readonly", false);
      $("#m_ct_nm2").css("background", "#FFFFFF");

      $("#btnDeleteMiddleCategory").show();
    }
  }
  
  /* 상호 저장 validation*/
  function fValidateMiddleCategory() {
    var chk = checkNotEmpty([ [ "l_ct_cd2", "품목을 선택하세요." ], [ "m_ct_cd2", "상호코드를 입력하세요." ], [ "m_ct_nm2", "상호명을 입력하세요." ]]);
    if (!chk) {
      return;

    }
    return true;
  }
  
  //상호 저장
  function fSaveMiddleCategory() {
    //validation 체크
    if (!fValidateMiddleCategory()) {
      return;
    }
    var resultCallback = function(data) {
       console.log(data);
       fSaveMiddleCategoryResult(data);
    };
    callAjax("/scm/saveMiddleCategory.do", "post", "json", true, $("#myForm")
        .serialize(), resultCallback);
  }
  
  //상호 저장 콜백 함수
  function fSaveMiddleCategoryResult(data) {
    var currentPage = "1";
    if ($("#Maction").val() != "I") {
      currentPage = $("#currentPageMiddleCategory").val();
    }
    if (data.result == "SUCCESS") {
      alert(data.resultMsg);
      gfCloseModal();
      fListMiddleCategory(currentPage);
    } else {
      alert(data.resultMsg);
    }
  }
  
  //상호 삭제
  function fDeleteMiddleCategory(l_ct_cd){
  var con = confirm("삭제하시겠습니까 ?");
  var currentPage = "1";
  if (con){
    var resultCallback = function(data) {
    fSaveMiddleCategoryResult(data);
  }
  $("#Maction").val("D");
  callAjax("/scm/saveMiddleCategory.do", "post", "json", true, $("#myForm").serialize(), resultCallback );
  } else {
    gfCloseModal();
  }
} 
  
  //품목명 콤보박스
  function selectLargeCategoryName() {

    var selLC = $("#l_ct_cd2").val();

    /* alert("selectLargeCategoryCode : " + $("#l_ct_cd2").val()); */

    $("#l_ct_cd2").val(selLC);

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
    <input type="hidden" name="Maction" id="Maction" value="">
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
                    <col width="45%">
                    <col width="45%">
                    <col width="10%">
                  </colgroup>
                  <thead>
                    <tr>
                      <th scope="col">품목코드</th>
                      <th scope="col">품목명</th>
                      <th scope="col">비고</th>
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
                                 <col width="45%">
                                 <col width="45%">
                                 <col width="10%">
                             </colgroup>
                        <thead>
                             <tr>
                                <th scope="col">상호코드</th>
                                <th scope="col">상호명</th>
                                <th scope="col">비고</th>
                             </tr>
                        </thead>
                        <tbody id="listMiddleCategory">
                             <tr>
                                <td colspan="6">품목을 선택해 주세요.</td>
                             </tr>
                        </tbody>
                        </table>
                   </div>
                         
                     <div class="paging_area" id="middleCategoryPagination"></div>
            </div>
            <h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
          </li>
        </ul>
      </div>
    </div>
    
    <!-- 품목 모달 -->
    <div id="largeCategory" class="layerPop layerType2" style="width: 600px;"> 
      <dl>
        <dt>
          <strong>품목 관리</strong>
        </dt>
        <dd class="content">
          <table class="row">
            <caption>caption</caption>
            <colgroup>
              <col width="120px">
              <col width="*">
              <col width="120px">
              <col width="*">
            </colgroup>
            <tbody>
              <tr>
                <th scope="row">품목코드 <span class="font_red">*</span></th>
                 <td colspan=3><input type="text" class="inputTxt p100"
                  name="l_ct_cd" id="l_ct_cd" maxlength="100"/></td>
              </tr>
              <tr>
                <th scope="row">품목명 <span class="font_red">*</span></th>
                 <td><input type="text" class="inputTxt p100"
                  name="l_ct_nm" id="l_ct_nm" maxlength="20"/></td>
              </tr>
            </tbody>
          </table>
          
          
          <div class="btn_areaC mt30">
            <a href="" class="btnType blue" id="btnSaveLargeCategory" name="btn"><span>저장</span></a>
            <a href="" class="btnType blue" id="btnDeleteLargeCategory" name="btn"><span>삭제</span></a>  
            <a href="" class="btnType gray" id="btnCloseCategory" name="btn"><span>닫기</span></a>
            
          </div>
        
       
        </dd>
      </dl>
      <a href="" class="closePop" id="btnClose" name="btn"><span class="hidden">닫기</span></a>
    </div>
    
    <!-- 상호 모달 -->
    <div id="middleCategory" class="layerPop layerType2" style="width: 600px;"> 
      <dl>
        <dt>
          <strong>상호 관리</strong>
        </dt>
        <dd class="content">
          <table class="row">
            <caption>caption</caption>
            <colgroup>
              <col width="120px">
              <col width="*">
              <col width="120px">
              <col width="*">
            </colgroup>
            <tbody>
              <tr>
                <!-- <th scope="row">품목코드 <span class="font_red">*</span></th>
                 <td><input type="text" class="inputTxt p100"
                  name="l_ct_nm2" id="l_ct_nm2" maxlength="100"/></td> -->
                <th scope="row">품목명 <span class="font_red">*</span></th>
                 <td><!-- <input type="text" class="inputTxt p100"
                  name="l_ct_nm2" id="l_ct_nm2" maxlength="20"/> -->
                  <input type="hidden" 
                  name="l_ct_nm2" id="l_ct_nm2" maxlength="100"/>
                  <select id="l_ct_cd2" name="l_ct_cd2" onChange="javascript:selectLargeCategoryName()"></select></td>
              </tr>
              <tr>
                <th scope="row">상호코드 <span class="font_red">*</span></th>
                 <td colspan=3><input type="text" class="inputTxt p100"
                  name="m_ct_cd2" id="m_ct_cd2" maxlength="100"/></td>
              </tr>
              <tr>
                <th scope="row">상호명 <span class="font_red">*</span></th>
                 <td colspan=3><input type="text" class="inputTxt p100"
                  name="m_ct_nm2" id="m_ct_nm2" maxlength="100"/></td>
              </tr>
            </tbody>
          </table>
          
          
          <div class="btn_areaC mt30">
            <a href="" class="btnType blue" id="btnSaveMiddleCategory" name="btn"><span>저장</span></a>
            <a href="" class="btnType blue" id="btnDeleteMiddleCategory" name="btn"><span>삭제</span></a>  
            <a href="" class="btnType gray" id="btnCloseCategory" name="btn"><span>닫기</span></a>
            
          </div>
        
       
        </dd>
      </dl>
      <a href="" class="closePop" id="btnClose" name="btn"><span class="hidden">닫기</span></a>
    </div>
  </form>
</body>
</html>