<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>창고정보 관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- 우편번호 조회 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/popFindZipCode.js"></script>
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
    //비활성화된 정보 표시 체크 클릭
    checkClickEvent();
    //엔터눌렀을때 창고정보 검색되게하기
    $("#sname").keypress(function (e) {
          if (e.which == 13){
                    board_search();  // 실행할 이벤트
          }
    });
    //콤보박스
    selectComCombo("wh_mng", "wh_mng_nm", "sel", "");
  });
  /** 버튼 이벤트 등록 */
  function fRegisterButtonClickEvent() {
    $('a[name=btn]').click(function(e) {
      e.preventDefault();
      var btnId = $(this).attr('id');
      //alert("btnId : " + btnId);
      switch (btnId) {
      case 'searchBtn':
        board_search(); // 창고정보 검색하기
        break;
      case 'btnSaveWarehouse'://저장하기
        fSaveWarehouse();
        break;
      case 'btnDeactivateWarehouse'://비활성화하기
        fDeactivateWarehouse();
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
    pageSize : pageSizeWarehouse
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
    //기존 목록 비활성화
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
    //기존 목록 비활성화
    $("#listWarehouseProduct").empty();
    // 신규 목록 생성
    $("#listWarehouseProduct").append(data);
    // 총 개수 추출
    var totalProduct = $("#totalProduct").val();
    //페이지 네비게이션 생성
    var warehouse_nm = $("#tmpwarehouse_nm").val();
    var warehouse_cd = $("#tmpwarehouse_cd").val();
    var paginationHtml = getPaginationHtml(currentPage, totalProduct,
        pageSizeProduct, pageBlockSizeProduct, 'fListProduct', [ warehouse_nm, warehouse_cd ]);
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
      $("#wh_mng_nm").val("");
      $("#zip_cd").val("");
      $("#addr").val("");
      $("#addr_detail").val("");
      $("#btnDeactivateWarehouse").hide();
      
      $("#warehouse_cd").attr("readonly", false);
      $("#warehouse_cd").css("background", "#FFFFFF");
      $("#warehouse_nm").attr("readonly", false);
      $("#warehouse_nm").css("background", "#FFFFFF");
      $("#wh_mng_id").attr("readonly", true);
      $("#wh_mng_id").css("background", "#F5F5F5");
      $("#zip_cd").attr("readonly", true);
      $("#zip_cd").css("background", "#F5F5F5");      
    } else{
      $("#warehouse_cd").val(object.warehouse_cd);
      $("#warehouse_nm").val(object.warehouse_nm);
      $("#wh_mng_id").val(object.wh_mng_id);
      $("#wh_mng_nm").val(object.wh_mng_id);
      $("#zip_cd").val(object.zip_cd);
      $("#addr").val(object.addr);
      $("#addr_detail").val(object.addr_detail);
      $("#btnDeactivateWarehouse").show();
      
      $("#warehouse_cd").attr("readonly", true);
      $("#warehouse_cd").css("background", "#F5F5F5");
      $("#warehouse_nm").attr("readonly", true);
      $("#warehouse_nm").css("background", "#F5F5F5");
      $("#wh_mng_id").attr("readonly", true);
      $("#wh_mng_id").css("background", "#F5F5F5");
      $("#zip_cd").attr("readonly", true);
      $("#zip_cd").css("background", "#F5F5F5");
    } 
  }

  /** 창고 저장 validation */
  function fValidateWarehouse() {
    var chk = checkNotEmpty([ 
            [ "warehouse_cd", "창고코드를 입력하세요." ],
            [ "warehouse_nm", "창고명 입력하세요." ],
            [ "wh_mng_id", "담당자ID를 입력하세요." ],
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
  
  //창고 비활성화
  function fDeactivateWarehouse(warehouse_cd){
    var con = confirm("비활성화하시겠습니까 ?");
    var currentPage = "1";
    if (con){
      var resultCallback = function(data) {
      fSaveWarehouseResult(data);
    }
    $("#action").val("D");
    callAjax("/scm/saveWarehouse.do", "post", "json", true, $("#myForm").serialize(), resultCallback );
    } else {
      gfCloseModal();
      fListWarehouse(currentPage);
      fInitFormWarehouse();
    }
  }
  
  //비활성화 정보 표시 체크
  function checkClickEvent(currentPage) {
    currentPage = currentPage || 1;
    
    $("#delcheck").change(
        function() {
          
          if ($("#delcheck").is(":checked")) {
            $("#sname").val("");
            var use_yn = "N";
            var param = {
              currentPage : currentPage,
              pageSize : pageSizeWarehouse,
              use_yn : use_yn
            }
            var resultCallback = function(data) {
              flistWarehouseResult(data, currentPage);
            };
            callAjax("/scm/listWarehouse.do", "post", "text", true,
                param, resultCallback);
          } else {
            $("#sname").val("");
            var use_yn = "Y";
            var param = {
              currentPage : currentPage,
              pageSize : pageSizeWarehouse,
              use_yn : use_yn
            }
            var resultCallback = function(data) {
              flistWarehouseResult(data, currentPage);
            };
            callAjax("/scm/listWarehouse.do", "post", "text", true,
                param, resultCallback);
          }
        });
  }
  
  //창고정보 검색 기능
  function board_search(currentPage) {
    $('#listWarehouseProduct').empty();
    currentPage = currentPage || 1;
    var sname = $('#sname');
    var searchKey = document.getElementById("searchKey");
    var oname = searchKey.options[searchKey.selectedIndex].value;
    
    var param = {
      sname : sname.val(),
      oname : oname,
      currentPage : currentPage,
      pageSize : pageSizeWarehouse
    }
    
    var resultCallback = function(data) {
      flistWarehouseResult(data, currentPage);
    };
    callAjax("/scm/listWarehouse.do", "post", "text", true, param,
        resultCallback);
  }
  
  //우편번호 api
  function execDaumPostcode(q) {
    new daum.Postcode({
      oncomplete : function(data) {
        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
        var addr = ''; // 주소 변수
        var extraAddr = ''; // 참고항목 변수

        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
          addr = data.roadAddress;
        } else { // 사용자가 지번 주소를 선택했을 경우(J)
          addr = data.jibunAddress;
        }

        // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
        if (data.userSelectedType === 'R') {
          // 법정동명이 있을 경우 추가한다. (법정리는 제외)
          // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
          if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
            extraAddr += data.bname;
          }
          // 건물명이 있고, 공동주택일 경우 추가한다.
          if (data.buildingName !== '' && data.apartment === 'Y') {
            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
          }
        }

        // 우편번호와 주소 정보를 해당 필드에 넣는다.
        document.getElementById('zip_cd').value = data.zonecode;
        document.getElementById("addr").value = addr;
        // 커서를 상세주소 필드로 이동한다.
        document.getElementById("addr_detail").focus();
      }
    }).open({
      q : q
    });
  }
  
  
  //창고담당자 이름 콤보박스
  function selectWarehouseMng() {

    var selwhmng = $("#wh_mng_nm").val();

    /* alert("selectWarehouseMng : " + $("#wh_mng_nm").val()); */

    $("#wh_mng_id").val(selwhmng);

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
                  <label>
                    <input type="checkbox" id="delcheck" name="delcheck" value="del"> 
                                        비활성화된 정보 표시
                 </label>
                           <select id="searchKey" name="searchKey" style="width: 100px;" v-model="searchKey">
                            <option value="all" selected="selected">전체</option>
                           <option value="warehouse_nm">창고명</option>
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
                      <th scope="col">품목명</th>
                      <th scope="col">공급처명</th>
                      <th scope="col">재고수량(EA)</th>
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
                <th scope="row">창고코드<span class="font_red">*</span></th>
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
                <th scope="row">담당자명</th>
                <td><select id="wh_mng_nm" name="wh_mng_nm" onChange="javascript:selectWarehouseMng()"></select></td>
              </tr>
              <tr>
                <th scope="row">우편번호 <span class="font_red">*</span></th>
                <td colspan="2"><input type="text" class="inputTxt p100" name="zip_cd" id="zip_cd" /></td>
                <td><input type="button" value="우편번호 찾기" onclick="execDaumPostcode()" style="width: 130px; height: 20px;" /></td>
              </tr>
              <tr>
                <th scope="row">주소 <span class="font_red">*</span></th>
                <td colspan="3"><input type="text" class="inputTxt p100"
                  name="addr" id="addr" /></td>
              </tr>
              <tr>
                <th scope="row">상세주소 <span class="font_red">*</span></th>
                <td colspan="3"><input type="text" class="inputTxt p100"
                  name="addr_detail" id="addr_detail" /></td>
              </tr>

            </tbody>
          </table>


          <div class="btn_areaC mt30">
            <a href="" class="btnType blue" id="btnSaveWarehouse" name="btn"><span>저장</span></a>
            <a href="" class="btnType blue" id="btnDeactivateWarehouse" name="btn"><span>비활성화</span></a>  
            <a href="" class="btnType gray" id="btnCloseWarehouse" name="btn"><span>취소</span></a>
          </div>
        </dd>
      </dl>
      <a href="" class="closePop"><span class="hidden">닫기</span></a>
    </div>
  </form>
</body>
</html>