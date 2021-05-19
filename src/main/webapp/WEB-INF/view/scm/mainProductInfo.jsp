<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>제품정보 관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/popFindZipCode.js"></script>
<link rel="stylesheet" href="${CTX_PATH}/css/chosen/chosen.css">
<script src="${CTX_PATH}/js/chosen/chosen.jquery.js"></script>
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
    $("#sname").keypress(function(e) {
      if (e.which == 13) {
        board_search(); // 실행할 이벤트
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
      case 'btnDeleteMainProduct'://삭제하기
        fDeleteMainProduct();
        break;
      case 'btnCloseMainProduct': //닫기
        gfCloseModal();
        break;
      }
    });
  }

  /* 제품 조회*/

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
  /* 제품 조회 콜백 함수*/

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

  /* 검색기능*/

  function board_search(currentPage) {
    $('#listMainProduct').empty();
    currentPage = currentPage || 1;
    var sname = $('#sname');
    var searchKey = document.getElementById("searchKey");
    var oname = searchKey.options[searchKey.selectedIndex].value;

    var param = {
    sname : sname.val(),
    oname : oname,
    currentPage : currentPage,
    pageSize : pageSizeMainProduct,
    }

    var resultCallback = function(data) {
      flistMainProductResult(data, currentPage);
    };
    callAjax("/scm/listMainProduct.do", "post", "text", true, param, resultCallback);
  }

  /*제품 상세정보*/
  function fSelectMainProduct(product_cd) {
    var param = {
      product_cd : product_cd
    };

    var resultCallback = function(data) {
      fSelectMainProductResult(data);
    };

    callAjax("/scm/selectMainProduct.do", "post", "json", true, param, resultCallback);
  }
  
  /*제품 상세정보 콜백 함수*/
  function fSelectMainProductResult(data) {
    if (data.result == "SUCCESS") {
      gfModalPop("#layer1")
      fInitFormMainProduct(data.mainProductInfoModel);
    } else {
      alert(data.resultMsg);
    }
  }
  
  /* 제품 상세정보 폼 초기화 */
  function fInitFormMainProduct(object) {
    $("#product_cd").focus();
    
    console.log("object :" + JSON.stringify(object));
    if (object == "" || object == null || object == undefined) {
      $("#product_cd").val("");
      $("#prod_nm").val("");
      $("#l_ct_nm").val("");
      $("#supply_nm").val("");
      $("#purchase_price").val("");
      $("#price").val("");
      $("#warehouse_nm").val("");
      $("#stock").val("");
      $("#detail").val("");
      $("#file_local_path").val("");
    } else{
      $("#product_cd").val(object.product_cd);
      $("#prod_nm").val(object.prod_nm);
      $("#l_ct_nm").val(object.l_ct_nm);
      $("#supply_nm").val(object.supply_nm);
      $("#purchase_price").val(object.purchase_price);
      $("#price").val(object.price);
      $("#warehouse_nm").val(object.warehouse_nm);
      $("#stock").val(object.stock);
      $("#detail").val(object.detail);
      $("#file_local_path").val("object.file_local_path");
    } 
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
                           <option value="prod_nm">제품명</option>
                           <option value="l_ct_nm">모델명</option>
                           <option value="supply_nm">공급처명</option>
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
    <!-- 모달! -->
    <div id="layer1" class="layerPop layerType2" style="width: 1500px;">
      <dl>
        <dt>
          <strong>제품 상세정보</strong>
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
                <th scope="row">제품 이미지 <span class="font_red">*</span></th>
                
                <th scope="row">제품 번호 <span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100"
                  name="product_cd" id="product_cd" /></td>
                <th scope="row">제품명 <span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100"
                  name="prod_nm" id="prod_nm" /></td>
                <th scope="row">모델명<span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100" 
                  name="l_ct_nm" id="l_ct_nm" /></td>
              </tr>
              <tr>
                <td rowspan="3"><img alt="제품 이미지" src="/images/admin/comm/byebye.jpg" width="500" height="300"></td>
                <th scope="row">공급처명 <span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100"
                  name="supply_nm" id="supply_nm" /></td>
                <th scope="row">장비구매액 <span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100"
                  name="purchase_price" id="purchase_price" /></td>
                <th scope="row">단가<span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100" 
                  name="price" id="price" /></td>
              </tr>
              <tr>
                <th scope="row">창고명 <span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100"
                  name="warehouse_nm" id="warehouse_nm" /></td>
                <th scope="row">재고개수<span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100"
                  name="stock" id="stock" /></td>
              </tr>
              <tr>
                <th scope="row">상세정보 <span class="font_red">*</span></th>
                <td colspan = "5"><textarea class = "ui-widget ui-widget-content ui-corner-all" id="detail" maxlength="500" name="detail" 
                                            style="height:130px;outline:none;resize:none;" placeholder="여기에 상세정보를 적어주세요.(500자 이내)"></textarea></td>
              </tr>
            </tbody>
          </table>
        </dd>
      </dl>
      <a href="" class="closePop"><span class="hidden">닫기</span></a>
    </div>
  </form>
</body>
</html>