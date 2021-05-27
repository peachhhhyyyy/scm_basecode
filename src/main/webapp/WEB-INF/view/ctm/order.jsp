<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공급처 관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
  //공급처정보 페이징 처리
  var pageSizeProduct = 5; //공급처정보 페이지 사이즈
  var pageBlockSizeProduct = 5; //공급처정보 페이지 블록 갯수
  
  //OnLoad event
  $(document).ready(function() {
    //공급처 목록 조회
    fListProduct();
    //버튼 이벤트 등록
    fRegisterButtonClickEvent();
    //엔터눌렀을때 창고정보 검색되게하기
    $("#sname").keypress(function (e) {
          if (e.which == 13){
                    board_search();  // 실행할 이벤트
          }
    });
    //창고명 조회 콤보박스
    selectComCombo("wh", "warehouse_nm", "sel", "");   
    // 조회 종류   부서 : dept  acc : 회계계정 cli 거래처  pro:싱품 whp: 창고담당자 wh: 창고, Combo Name, Option("all" : 전체     "sel" : 선택 , NULL)       
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
  

  /*공급처 조회*/
  function fListProduct(currentPage) {
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
      flistProductResult(data, currentPage);
    };
    callAjax("/ctm/listProduct.do", "post", "text", true, param, resultCallback);
  }
  
  
  /*공급처 조회 콜백 함수*/
  function flistProductResult(data, currentPage) {
    
    console.log("data : " + data);
    //기존 목록 삭제
    $("#listProduct").empty();
    $("#listProduct").append(data);
    // 총 개수 추출
    var totalProduct = $("#totalProduct").val();
    //페이지 네비게이션 생성
    var paginationHtml = getPaginationHtml(currentPage, totalProduct, pageSizeProduct, pageBlockSizeProduct, 'fListProduct');
    $("#productPagination").empty().append(paginationHtml);
    //현재 페이지 설정
    $("#currentPageProduct").val(currentPage);
  }

  
  /* 공급처 모달 실행 */
  function fPopModalProduct(supply_cd) {
    //신규 저장
    if (supply_cd == null || supply_cd == "") {
      $("#action").val("I");
      fInitFormProduct();
      gfModalPop("#layer1");
    } else {
      $("#action").val("U");
      fSelectProduct(supply_cd);
    }
  }
  

  /* 공급처 단건 조회*/
  function fSelectProduct(supply_cd) {
    var param = {
        supply_cd : supply_cd
    };
    var resultCallback = function(data) {
      fSelectProductResult(data);
    };
    callAjax("/ctm/selectProduct.do", "post", "json", true, param,
        resultCallback);
  }
  
  // 공급처 단건 조회 콜백 함수
  function fSelectProductResult(data) {
    if (data.result == "SUCCESS") {
      gfModalPop("#layer1")
      fInitFormProduct(data.productInfoModel);
    } else {
      alert(data.resultMsg);
    }
  }
  

  /* 공급처 폼 초기화 */
  function fInitFormProduct(object) {
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
      $("#warehouse_cd").attr("readonly", true);
      $("#warehouse_cd").css("background", "#F5F5F5");
      
      $("#btnDeleteProduct").hide();
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
      $("#warehouse_nm").val(object.warehouse_cd);
      
      $("#warehouse_cd").attr("readonly", true);
      $("#warehouse_cd").css("background", "#F5F5F5");
      
      
      $("#btnDeleteProduct").show();
    } 
  } 
  

  /* 공급처 저장 validation*/
  function fValidateProduct() {
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
  function fSaveProduct() {
    //validation 체크
    if (!fValidateProduct()) {
      return;
    }
    var resultCallback = function(data) {
       console.log(data);
       fSaveProductResult(data);
    };
    callAjax("/ctm/saveProduct.do", "post", "json", true, $("#myForm")
        .serialize(), resultCallback);
  }
  
  //공급처 저장 콜백 함수
  function fSaveProductResult(data) {
    var currentPage = "1";
    if ($("#action").val() != "I") {
      currentPage = $("#currentPageProduct").val();
    }
    if (data.result == "SUCCESS") {
      alert(data.resultMsg);
      gfCloseModal();
      fListProduct(currentPage);
    } else {
      alert(data.resultMsg);
    }
    fInitFormProduct();
  }
  
  //공급처 삭제
    function fDeleteProduct(supply_cd){
    var con = confirm("삭제하시겠습니까 ?");
    var currentPage = "1";
    if (con){
      var resultCallback = function(data) {
      fSaveProductResult(data);
    }
    $("#action").val("D");
    callAjax("/ctm/saveProduct.do", "post", "json", true, $("#myForm").serialize(), resultCallback );
    } else {
      gfCloseModal();
      fListProduct(currentPage);
      fInitFormProduct();
    }
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
      flistProductResult(data, currentPage);
    };
    callAjax("/ctm/listProduct.do", "post", "text", true, param,
        resultCallback);
  }
  
  //창고명 검색 콤보박스
  function selectwarehouse() {
    
    var selwh = $("#warehouse_nm").val();
    
    //alert("selectwarehouse : " + $("#warehouse_nm").val());
    
    $("#warehouse_cd").val(selwh);
    
    
    
  }
  
  
  
  
</script>
</head>
<body>
<form id="myForm" action="" method="">
    <input type="hidden" id="currentPageProduct" value="1">
    <input type="hidden" id="currentPageProduct" value="1"> 
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
                                 <a href="javascript:fPopModalProduct()" class="btnType blue" name="modal"  style="float: right;">
                                      <span>신규등록</span>
                                      </a>
                    
                  
                                      
                                 </span>
                            </p>  
                            
                    <div class="ProductList">
                    <div class="conTitle" style="margin: 0 25px 10px 0; float: left;">
                           <select id="searchKey" name="searchKey" style="width: 100px;" v-model="searchKey">
                           <option value="all" selected="selected">전체</option>
                           <option value="product_l_ct">상호명</option>
                           <option value="product_nm">제품명</option>
                           <option value="product_cd">제품코드</option>
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
                                <tbody id="listProduct"></tbody>                      
                         </table>  
                   </div>
                       
                   <div class="paging_area" id="productPagination"></div>
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
                <td><select id="warehouse_nm" name="warehouse_nm" onChange="javascript:selectwarehouse()"></select></td>
              </tr>
            </tbody>
          </table>
          
          
          <div class="btn_areaC mt30">
            <a href="" class="btnType blue" id="btnSaveProduct" name="btn"><span>저장</span></a>
            <a href="" class="btnType blue" id="btnDeleteProduct" name="btn"><span>삭제</span></a>  
            <a href="" class="btnType gray" id="btnCloseProduct" name="btn"><span>닫기</span></a>
            
          </div>
        
       
        </dd>
      </dl>
      <a href="" class="closePop" id="btnClose" name="btn"><span class="hidden">닫기</span></a>
    </div>
</form>
</body>
</html>