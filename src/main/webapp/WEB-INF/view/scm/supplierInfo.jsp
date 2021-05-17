<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="kr.happyjob.study.scm.model.SupplierInfoModel"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공급처 관리</title>
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
  //공급처정보 페이징 처리
  var userPageSize = 5; //공급처정보 페이지 사이즈
  var userPageBlock = 5; //공급처정보 페이지 블록 갯수
  
  //제품정보 페이징 처리 
  var pageSizeProduct = 5; //제품정보 페이지 사이즈
  var pageBlockSizeProduct = 5; //제품정보 페이지 블록 갯수
  
  //OnLoad event
  $(document).ready(function() {
    //공급처 목록 조회
    selectSupplierList();
    
    //제품정보 목록 조회
    selectSupplierProList();
    
    // 버튼 이벤트 등록
    fButtonClickEvent();
  });
  
  /*버튼 이벤트 등록*/
  function fButtonClickEvent() {
    $('a[name=btn]').click(function(e) {
      e.preventDefault();
      var btnId = $(this).attr('id');
      switch (btnId) {
      case 'btnSaveSupplier':
        fSaveSupplier(); // save 안에 저장,수정  
        break;
      case 'btnDeleteSupplier':
        fDeleteSupplier(); // 만들자 
        break;
      case 'btnClose':
        gfCloseModal(); // 모달닫기 
        break;
      case 'searchBtn':
        board_search(); // 검색하기
        break;
      }
    });
  }
  

  /*공급처 조회*/
  function selectSupplierList(currentPage) {
    
    currentPage = currentPage || 1;
    var sname = $('#sname');
    var searchKey = document.getElementById("searchKey");
    var oname = searchKey.options[searchKey.selectedIndex].value;
    
    var param = {
        sname : sname.val(),
        oname : oname,
        currentPage : currentPage,
        pageSize : userPageSize
    }
    var resultCallback = function(data) {
      supplierListResult(data, currentPage);
    };
    callAjax("/scm/supplierList.do", "post", "text", true, param, resultCallback);
  }
  
  
  /*공급처 조회 콜백 함수*/
  function supplierListResult(data, currentPage) {
    
    console.log("data : " + data);
    //기존 목록 삭제
    $("#supplierList").empty();
    $("#supplierList").append(data);
    // 총 개수 추출
    var totalCnt = $("#totalCountSupplier").val();
    //페이지 네비게이션 생성
    var paginationHtml = getPaginationHtml(currentPage, totalCnt, userPageSize, userPageBlock, 'selectSupplierList');
    $("#paginationHtml").empty().append(paginationHtml);
    //현재 페이지 설정
    $("#currentPage").val(currentPage);
    console.log("totalCnt : ", totalCnt);
  }
  
  
  
  
  

  /* 공급처 폼 초기화 */
  function fInitFormSupplier(object) {
    $("#supply_cd").focus();
    
    if (object == "" || object == null || object == undefined) {
      $("#supply_cd").val("");
      $("#supply_nm").val("");
      $("#supply_mng_nm").val("");    
      $("#tel").val("");
      $("#mng_tel").val("");
      $("#email").val("");
      $("#warehouse_cd").val("");
      $("#warehouse_nm").val("");
      
      $("#supply_cd").attr("readonly", false);
      $("#supply_cd").css("background", "#FFFFFF");
      $("#supply_nm").attr("readonly", false);
      $("#supply_nm").css("background", "#FFFFFF");
    } else{
      $("#supply_cd").val(object.supply_cd);
      $("#supply_cd").attr("readonly", true);
      $("#supply_cd").css("background", "#F5F5F5");
      $("#supply_nm").val(object.supply_nm);
      $("#supply_nm").attr("readonly", true);
      $("#supply_nm").css("background", "#F5F5F5");
      $("#supply_mng_nm").val(object.supply_mng_nm);
      $("#tel").val(object.tel);
      $("#mng_tel").val(object.mng_tel);
      $("#email").val(object.email);
      $("#warehouse_cd").val(object.warehouse_cd);
      $("#warehouse_nm").val(object.warehouse_nm);
    } 
  } 
  
  /* 공급처 모달 실행 */
  function fPopModalSupplier(supply_cd) {
    //신규 저장
    if (supply_cd == null || supply_cd == "") {
      $("#action").val("I");
      fInitFormSupplier();
      gfModalPop("#layer1");
    } else {
      $("#action").val("U");
      fSelectSupplierDetail(supply_cd);
    }
  }
  
  /* 공급처 단건 조회*/
  function fSelectSupplierDetail(supply_cd) {
    var param = {
        supply_cd : supply_cd
    };
    var resultCallback = function(data) {
      fSelectSupplierDetailResult(data);
    };
    callAjax("/scm/selectSupplierDetail.do", "post", "json", true, param,
        resultCallback);
  }
  
  // 공급처 단건 조회 콜백 함수
  function fSelectSupplierDetailResult(data) {
    if (data.result == "SUCCESS") {
      gfModalPop("#layer1")
      fInitFormSupplier(data.supplierInfoModel);
    } else {
      alert(data.resultMsg);
    }
  }
  
  
  
  
  
  /* 공급처 저장 validation*/
  function fValidateSupplier() {
    var chk = checkNotEmpty([ 
            [ "supply_cd", "공급처코드를 입력하세요." ],
            [ "supply_nm", "공급처명 입력하세요." ],
            [ "supply_mng_nm", "담당자명을 입력하세요." ],
            [ "tel", "연락처를 입력하세요." ],
            [ "email", "이메일 입력하세요." ], 
            [ "warehouse_cd", "창고코드를 입력하세요." ],
            [ "mng_tel", "담당자 연락처를 입력하세요." ]
            /* [ "warehouse_nm", "창고명을 입력하세요." ] */
          ]);
    if (!chk) {
      return;
      
    }
    return true;
  }
  
  //공급처 저장
  function fSaveSupplier() {
    //validation 체크
    if (!fValidateSupplier()) {
      return;
    }
    var resultCallback = function(data) {
       console.log(data);
       fSaveSupplierResult(data);
       /* console.log(data.result);
       console.log(data.resultMsg); */
       
       /* gfCloseModal();
       fInitFormSupplier();
       
       var status = $("#action").val();
       var cur = $("#currentPage").val();
       
       if (status == 'U') {
         selectSupplierList(cur);
       } else {
         selectSupplierList();
       }
       
       return; */
    };
    callAjax("/scm/saveSupplier.do", "post", "json", true, $("#myForm")
        .serialize(), resultCallback);
  }
  
  //공급처 저장 콜백 함수
  function fSaveSupplierResult(data) {
    var currentPage = "1";
    if ($("#action").val() != "I") {
      currentPage = $("#currentPage").val();
    }
    if (data.result == "SUCCESS") {
      alert(data.resultMsg);
      gfCloseModal();
      selectSupplierList(currentPage);
    } else {
      alert(data.resultMsg);
    }
    fInitFormSupplier();
  }
  
  //공급처 삭제
    function fDeleteSupplier(deli_no){
    var con = confirm("삭제하시겠습니까 ?");
    var currentPage = "1";
    if (con){
      var resultCallback = function(data) {
      fSaveSupplierResult(data);
    }
    $("#action").val("D");
    callAjax("/scm/saveSupplier.do", "post", "json", true, $("#myForm").serialize(), resultCallback );
    } else {
      gfCloseModal();
      selectSupplierList(currentPage);
      fInitFormSupplier();
    }
  } 
  
  
  
  /*제품 목록 조회*/
  function selectSupplierProList(currentPage, supply_nm, supply_cd) {
    //공급처명 매개변수 설정
    currentPage = currentPage || 1;
    $("#tmpsupply_nm").val(supply_nm);
    $("#tmpsupply_cd").val(supply_cd);
    var param = {
        supply_nm : supply_nm
      , supply_cd : supply_cd //공급처 코드 변수설정
      , currentPage : currentPage
      , pageSize : pageSizeProduct
    }

    console.log("supply_cd : " + supply_cd);
    var resultCallback = function(data) {
      supplierProListResult(data, currentPage);
    };
    callAjax("/scm/supplierProList.do", "post", "text", true, param, resultCallback);
  }
  /*제품목록 조회 콜백 함수*/
  function supplierProListResult(data, currentPage) {
    console.log("data : " + data);
    //기존 목록 삭제
    $('#supplierProList').empty();
    // 신규 목록 생성
    $("#supplierProList").append(data);
    //$("#listProduct").append($listProduct.children());  
    // 총 개수 추출
    var totalProduct = $("#totalCountPro").val();
    //페이지 네비게이션 생성
    var supply_nm = $("#supply_nm").val();
    var supply_cd = $("#supply_cd").val();
    
    var paginationHtml = getPaginationHtml(currentPage, totalProduct, 
        pageSizeProduct, pageBlockSizeProduct, 'selectSupplierProList',[supply_nm, supply_cd]);
    $("#productPagination").empty().append(paginationHtml);
    // 현재 페이지 설정
    $("#currentPage").val(currentPage);
  }
  
  /* 검색 기능*/
  function board_search(currentPage) {
    $('#supplierProList').empty();
    currentPage = currentPage || 1;
    var sname = $('#sname');
    var searchKey = document.getElementById("searchKey");
    var oname = searchKey.options[searchKey.selectedIndex].value;
    
    var param = {
      sname : sname.val(),
      oname : oname,
      currentPage : currentPage,
      pageSize : userPageSize,
    }
    
    
    var resultCallback = function(data) {
      supplierListResult(data, currentPage);
    };
    callAjax("/scm/supplierList.do", "post", "text", true, param,
        resultCallback);
  }
  
  
  
  
  
  
</script>
</head>
<body>
<form id="myForm" action="" method="">
    <input type="hidden" id="currentPage" value="1">
    <input type="hidden" id="currentPage" value="1"> 
    <input type="hidden" id="tmpsupply_nm" value="">  
    <input type="hidden" id="tmpsupply_cd" value="">
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
                                 <a class="btn_nav">기준 정보</a>
                                  <span class="btn_nav bold">공급처 정보</span> 
                                 <a href="" class="btn_set refresh">새로고침</a>
                            </p>
                            
                            <p class="conTitle">
                                 <span>공급처 정보</span>
                                 <span class="fr"> 
                                 <a href="javascript:fPopModalSupplier()" class="btnType blue" name="modal"  style="float: right;">
                                      <span>신규등록</span>
                                      </a>
                    
                  
                                      
                                 </span>
                            </p>  
                            
                    <div class="SupplierList">
                    <div class="conTitle" style="margin: 0 25px 10px 0; float: left;">
                           <select id="searchKey" name="searchKey" style="width: 100px;" v-model="searchKey">
                           <option value="supply_cd" selected="selected">공급처명</option>
                           <option value="supply_mng_nm">담당자명</option>
                        </select>
                        <input type="text" style="width: 300px; height: 30px;" id="sname" name="sname">
                            <a href="" class="btnType blue" id="searchBtn" name="btn"> 
                            <span>검 색</span>
                            </a> 
                    </div>
                         <table class="col">
                                <caption>caption</caption>
                                    <colgroup>
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="17%">
                                    <col width="10%">
                                    <col width="17%">
                                    <col width="16%">
                                    <col width="10%">
                                    <col width="10%">
                                </colgroup> 
                                
                                <thead>
                                    <tr>
                                        <th scope="col">공급처코드</th>
                                        <th scope="col">공급처명</th>
                                        <th scope="col">연락처</th>
                                        <th scope="col">담당자명</th>
                                        <th scope="col">담당자 연락처</th>
                                        <th scope="col">이메일</th>
                                        <th scope="col">창고명</th>   
                                        <th scope="col">비고</th>  
                                    </tr>
                                </thead> 
                                <tbody id="supplierList"></tbody>                      
                         </table>  
                   </div>
                       
                   <div class="paging_area" id="paginationHtml"></div>
                   
                   
                   
                   
                   <p class="conTitle mt50">
                      <span>공급 제품정보</span>
                   </p>
                   
                   <div class="supplierProList">
                        <table class="col">
                             <caption>caption</caption>
                             <colgroup>
                                 <col width="15%">
                                 <col width="15%">
                                 <col width="15%">
                                 <col width="15%">
                                 <col width="15%">
                                 <col width="15%">
                             </colgroup>
                        <thead>
                             <tr>
                                <th scope="col">공급처명</th>
                                <th scope="col">제품코드</th>
                                <th scope="col">제품명</th>
                                <th scope="col">모델명</th>
                                <th scope="col">재고현황(개)</th>
                                <th scope="col">제품단가(원)</th>
                             </tr>
                        </thead>
                        <tbody id="supplierProList">
                             <tr>
                                <td colspan="6">공급처를 선택해 주세요.</td>
                             </tr>
                        </tbody>
                        </table>
                   </div>
                         
                   <div class="paging_area" id="productPagination"></div>
                   
                   
              </div>
                  
                       <h3 class="hidden">풋터 영역</h3> 
                        <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
                  </li>
              </ul>
          </div>     
    </div>
    
    <!-- 모달 -->
    
    <div id="layer1" class="layerPop layerType2" style="width: 600px;"> 
      <dl>
        <dt>
          <strong>공급처 관리</strong>
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
                <th scope="row">공급처명 <span class="font_red">*</span></th>
                 <td colspan=3><input type="text" class="inputTxt p100"
                  name="supply_nm" id="supply_nm" /></td>
              </tr>
              <tr>
                <th scope="row">공급처코드 <span class="font_red">*</span></th>
                 <td><input type="text" class="inputTxt p100"
                  name="supply_cd" id="supply_cd" /></td>
                <th scope="row">연락처<span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100" name="tel"
                  id="tel" /></td>
              </tr>
              <tr>
                <th scope="row">담당자명 <span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100"
                  name="supply_mng_nm" id="supply_mng_nm" /></td>  
                                  
                <th scope="row">담당자 연락처<span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100" 
                name="mng_tel" id="mng_tel" /></td>
              
              </tr>
              
              <tr>
                <th scope="row">이메일 <span class="font_red">*</span></th>
                <td colspan=3><input type="text" class="inputTxt p100"
                  name="email" id="email" /></td>           
              </tr>
              <tr>
                <th scope="row">창고코드 <span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100"
                  name="warehouse_cd" id="warehouse_cd" /></td>
                <th scope="row">창고명</th>
                <td><input type="text" class="inputTxt p100"
                  name="warehouse_nm" id="warehouse_nm" /></td>
              </tr>
            </tbody>
          </table>
          
          
          <div class="btn_areaC mt30">
            <a href="" class="btnType blue" id="btnSaveSupplier" name="btn"><span>저장</span></a>
            <a href="" class="btnType blue" id="btnDeleteSupplier" name="btn"><span>삭제</span></a>  
            <a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
            
          </div>
        
       
        </dd>
      </dl>
      <a href="" class="closePop" id="btnClose" name="btn"><span class="hidden">닫기</span></a>
    </div>
</form>
</body>
</html>