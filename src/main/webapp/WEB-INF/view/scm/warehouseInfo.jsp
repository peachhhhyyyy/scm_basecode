<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>WarehouseInfo</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
  /*창고 페이징 처리*/
  var pageSizeWarehouse = 5;
  var pageBlockSizeWarehouse = 5;
  
  /*제품정보 페이징 처리*/
  var pageSizeProduct = 5;
  var pageBlockSizeProduct = 5;
  
  /*OnLoad event*/
  $(function() {
    //창고 목록 조회
    fListWarehouse();
    //제품 정보 목록 조회
    fListProduct();
    //버튼 이벤트 등록
    fRegisterButtonClickEvent();
  });
  /** 버튼 이벤트 등록 */
  function fRegisterButtonClickEvent() {
    $('a[name=btn]').click(function(e) {
      e.preventDefault();
      var btnId = $(this).attr('id');
      //alert("btnId : " + btnId);
      switch (btnId) {
      case 'searchBtn':
        board_search(); // 검색하기
        break;
      case 'btnSaveWarehouse'://저장하기
        fSaveWarehouse();
        break;
      case 'btnDeleteWarehouse'://삭제하기
        fDeleteWarehouse();
        break;
      case 'btnCloseWarehouse': //닫기
        gfCloseModal();
        break;
      }
    });
  }

  /*창고  조회*/
  function fListWarehouse(currentPage) {
    currentPage = currentPage || 1;
    var sname = $('#sname');
    var searchKey = document.getElementById("searchKey");
    var oname = searchKey.options[searchKey.selectedIndex].value;

    console.log("currentPage : " + currentPage);

    var param = {
    sname : sname.val(),
    oname : oname,
    currentPage : currentPage,
    pageSize : pageSizeWarehouse,
    }
    var resultCallback = function(data) {
      flistWarehouseResult(data, currentPage);
    }
    callAjax("/scm/listWarehouse.do", "post", "text", true, param, resultCallback);
  }
  /*창고 조회 콜백 함수*/
  function flistWarehouseResult(data, currentPage) {
    //alert(data);
    console.log(data);
    //기존 목록 삭제
    $('#listWarehouse').empty();
    $("#listWarehouse").append(data);
    // 총 개수 추출
    var totalWarehouse = $("#totalWarehouse").val();
    //페이지 네비게이션 생성
    var paginationHtml = getPaginationHtml(currentPage, totalWarehouse, pageSizeWarehouse, pageBlockSizeWarehouse, 'fListWarehouse');
    $("#warehousePagination").empty().append(paginationHtml);
    //현재 페이지 설정
    console.log("totalWarehouse: " + totalWarehouse);
    $("#currentPageWarehouse").val(currentPage);
  }
  
  /*제품 목록 조회*/
  function fListProduct(currentPage, warehouse_nm, warehouse_cd) {
    //창고코드 매개변수 설정
    currentPage = currentPage || 1;
    
    $("#tmpwarehouse_nm").val(warehouse_nm);
    $("#tmpwarehouse_cd").val(warehouse_cd);
    
    var param = {
        warehouse_nm : warehouse_nm
      , warehouse_cd : warehouse_cd
      , currentPage : currentPage
      , pageSize : pageSizeProduct
    }
    
    console.log("warehouse_cd : " + warehouse_cd);
    var resultCallback = function(data) {
      flistProductResult(data, currentPage);
    };
    callAjax("/scm/listWarehouseProduct.do", "post", "text", true, param,
        resultCallback);
  }
  
  /*제품목록 조회 콜백 함수*/
  function flistProductResult(data, currentPage) {
    //기존 목록 삭제
    $("#listWarehouseProduct").empty();
    // 신규 목록 생성
    $("#listWarehouseProduct").append(data);
    // 총 개수 추출
    var totalProduct = $("#totalProduct").val();
    //페이지 네비게이션 생성
    var warehouse_nm = $("#tmpwarehouse_nm").val();
    var warehouse_cd = $("#tmpwarehouse_cd").val();
    var paginationHtml = getPaginationHtml(currentPage, totalProduct,
        pageSizeProduct, pageBlockSizeProduct, 'fListProduct', [
        warehouse_nm, warehouse_cd ]);
    console.log("paginationHtml : " + paginationHtml);
    $("#productPagination").empty().append(paginationHtml);
    console.log("totalProduct: " + totalProduct);
    // 현재 페이지 설정
    $("#currentPageProduct").val(currentPage);
  }
  
  
  /** 창고정보 모달 실행 */
  function fPopModalWarehouse(warehouse_cd) {
    //신규 저장
    if (warehouse_cd == null || warehouse_cd == "") {
      $("#action").val("I");
      fInitFormWarehouse();
      gfModalPop("#layer1");
    } else {
      $("#action").val("U");
      fSelectWarehouse(warehouse_cd);
    }
  }
  /*창고정보 단건 조회*/
  function fSelectWarehouse(warehouse_cd) {
    var param = {
      warehouse_cd : warehouse_cd
    };
    var resultCallback = function(data) {
      fSelectWarehouseResult(data);
    };
    callAjax("/scm/selectWarehouse.do", "post", "json", true, param,
        resultCallback);
  }
  //창고정보 단건 조회 콜백 함수
  function fSelectWarehouseResult(data) {
    if (data.result == "SUCCESS") {
      gfModalPop("#layer1")
      fInitFormWarehouse(data.warehouseInfoModel);
    } else {
      alert(data.resultMsg);
    }
  }
  /** 창고정보 폼 초기화 */
  function fInitFormWarehouse(object) {
    $("#warehouse_cd").focus();
    
    if (object == "" || object == null || object == undefined) {
      $("#warehouse_cd").val("");
      $("#warehouse_nm").val("");
      $("#wh_mng_id").val("");
      $("#zip_cd").val("");
      $("#addr").val("");
      $("#addr_detail").val("");
      
      $("#warehouse_cd").attr("readonly", false);
      $("#warehouse_cd").css("background", "#FFFFFF");
      $("#warehouse_nm").attr("readonly", false);
      $("#warehouse_nm").css("background", "#FFFFFF");
    } else{
      $("#warehouse_cd").val(object.warehouse_cd);
      $("#warehouse_nm").val(object.warehouse_nm);
      $("#wh_mng_id").val(object.wh_mng_id);
      $("#zip_cd").val(object.zip_cd);
      $("#addr").val(object.addr);
      $("#addr_detail").val(object.addr_detail);
      
      $("#warehouse_cd").attr("readonly", true);
      $("#warehouse_cd").css("background", "#F5F5F5");
      $("#warehouse_nm").attr("readonly", true);
      $("#warehouse_nm").css("background", "#F5F5F5");
    } 
  }

  /** 창고 저장 validation */
  function fValidateWarehouse() {
    var chk = checkNotEmpty([ 
            [ "warehouse_cd", "창고코드를 입력하세요." ],
            [ "warehouse_nm", "창고명 입력하세요." ],
            [ "wh_mng_id", "담당자코드를 입력하세요." ],
            [ "zip_cd", "우편주소를 입력하세요." ],
            [ "addr", "주소를 입력하세요." ], 
            [ "addr_detail", "상세주소를 입력하세요." ] 
        ]);
    if (!chk) {
      return;
    }
    return true;
  }
  
  //창고 저장
  function fSaveWarehouse() {
    //validation 체크
    if (!fValidateWarehouse()) {
      return;
    }
    var resultCallback = function(data) {
      console.log(data);
      fSaveWarehouseResult(data);
    };
    callAjax("/scm/saveWarehouse.do", "post", "json", true, $("#myForm")
        .serialize(), resultCallback);
  }
  //창고 저장 콜백 함수
  function fSaveWarehouseResult(data) {
    var currentPage = "1";
    if ($("#action").val() != "I") {
      currentPage = $("#currentPageWarehouse").val();
    }
    if (data.result == "SUCCESS") {
      alert(data.resultMsg);
      gfCloseModal();
      fListWarehouse(currentPage);
    } else {
      alert(data.resultMsg);
    }
    fInitFormWarehouse();
  }
</script>
</head>
<body>
  <form id="myForm" action="" method="">
    <input type="hidden" id="currentPageWarehouse" value="1"> 
    <input type="hidden" id="currentPageProduct" value="1"> 
    <input type="hidden" id="tmpwarehouse_nm" value=""> 
    <input type="hidden" id="tmpwarehouse_cd" value=""> 
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
                <a href="/system/notice.do" class="btn_set home">메인으로</a> <a class="btn_nav">기준 정보</a> <span class="btn_nav bold">창고정보 관리</span> <a href="" class="btn_set refresh">새로고침</a>
              </p>
              <p class="conTitle">
                <span>창고정보</span> <span class="fr"> <a href="javascript:fPopModalWarehouse()" class="btnType blue" name="modal"> <span>신규등록</span>
                </a>
                </span>
              </p>
              <div class="WarehouseList">
                <div class="conTitle" style="margin: 0 25px 10px 0; float: left;">
                           <select id="searchKey" name="searchKey" style="width: 100px;" v-model="searchKey">
                           <option value="warehouse_nm" selected="selected">창고명</option>
                           <option value="wh_mng_nm">담당자명</option>
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
                    <col width="12%">
                  </colgroup>
                  <thead>
                    <tr>
                      <th scope="col">창고코드</th>
                      <th scope="col">창고명</th>
                      <th scope="col">담당자명</th>
                      <th scope="col">담당자 연락처</th>
                      <th scope="col">담당자 이메일</th>
                      <th scope="col">우편번호</th>
                      <th scopt="col">주소</th>
                      <th scope="col">비고</th>
                    </tr>
                  </thead>
                  <tbody id="listWarehouse"></tbody>
                </table>
              </div>
              <div class="paging_area" id="warehousePagination"></div>
              <p class="conTitle mt50">
                <span>제품정보</span>
              </p>
              
              <div class="ProductList">
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
                      <th scope="col">창고명</th>
                      <th scope="col">제품코드</th>
                      <th scope="col">제품명</th>
                      <th scope="col">모델명</th>
                      <th scope="col">공급처명</th>
                      <th scope="col">재고수량</th>
                    </tr>
                  </thead>
                  <tbody id="listWarehouseProduct">
                    <tr>
                      <td colspan="6">창고를 선택해 주세요.</td>
                    </tr>
                  </tbody>
                </table>
              </div>

              <div class="paging_area" id="productPagination"></div>
              
            </div> <!--// content -->
            <h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
          </li>
        </ul>
      </div>
    </div>
    
    <!-- 모달! -->
    <div id="layer1" class="layerPop layerType2" style="width: 600px;">
      <dl>
        <dt>
          <strong>창고 관리</strong>
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
                <th scope="row">창고 코드<span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100"
                  name="warehouse_cd" id="warehouse_cd" /></td>
                <th scope="row">창고명 <span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100"
                  name="warehouse_nm" id="warehouse_nm" /></td>  
              </tr>
              <tr>
                <th scope="row">담당자ID<span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100" name="wh_mng_id"
                  id="wh_mng_id" /></td>
              </tr>
              <tr>
                <th scope="row">우편번호 <span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100"
                  name="zip_cd" id="zip_cd" /></td>
              </tr>
              <tr>
                <th scope="row">주소 <span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100"
                  name="addr" id="addr" /></td>
              </tr>
              <tr>
                <th scope="row">상세주소 <span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100"
                  name="addr_detail" id="addr_detail" /></td>
              </tr>

            </tbody>
          </table>


          <div class="btn_areaC mt30">
            <a href="" class="btnType blue" id="btnSaveWarehouse" name="btn"><span>저장</span></a>
            <a href="" class="btnType blue" id="btnDeleteWarehouse" name="btn"><span>삭제</span></a>  
            <a href="" class="btnType gray" id="btnCloseWarehouse" name="btn"><span>취소</span></a>
          </div>
        </dd>
      </dl>
      <a href="" class="closePop"><span class="hidden">닫기</span></a>
    </div>
  </form>
</body>
</html>