<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    //공급처명 조회 콤보박스
    selectComCombo("sp", "supply_cd", "sel", "");

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

  /** 제품정보 모달 실행 */
  function fPopModalMainProduct(product_cd) {
    //신규 저장
    if (product_cd == null || product_cd == "") {
      $("#action").val("I");
      fInitFormMainProduct();
      gfModalPop("#layer1");
    } else {
      $("#action").val("U");
      fSelectMainProduct(product_cd);
    }
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

    if (object == "" || object == null || object == undefined) {
      $("#product_cd").val("");
      $("#prod_nm").val("");
      $("#l_ct_nm").val("");
      $("#m_ct_nm").val("");
      $("#supply_cd").val("");
      $("#supply_nm").val("");
      $("#purchase_price").val("");
      $("#price").val("");
      $("#warehouse_cd").val("");
      $("#warehouse_nm").val("");
      $("#stock").val("");
      $("#detail").val("");
      $("#thumbnail").val("");
      $("#tempImg").attr("src", "/images/admin/comm/no_image.png");

      $("#btnSaveMainProduct").show();
      $("#btnDeleteMainProduct").hide();
      $("#product_cd").attr("readonly", false);
      $("#prod_nm").attr("readonly", false);
      $("#l_ct_nm").attr("readonly", false);
      $("#m_ct_nm").attr("readonly", false);
      $("#supply_nm").attr("readonly", false);
      $("#purchase_price").attr("readonly", false);
      $("#price").attr("readonly", false);
      $("#warehouse_cd").attr("readonly", true);
      $("#warehouse_nm").attr("readonly", true);
      $("#stock").attr("readonly", false);
      $("#detail").attr("readonly", false);
      $("#thumbnail").attr("readonly", false);
      $("#tempImg").attr("readonly", false);
      $("#thumbnail").show();
    } else {
      $("#product_cd").val(object.product_cd);
      $("#prod_nm").val(object.prod_nm);
      $("#l_ct_nm").val(object.l_ct_nm);
      $("#m_ct_nm").val(object.m_ct_nm);
      $("#supply_nm").val(object.supply_nm);
      $("#supply_cd").val(object.supply_cd);
      $("#purchase_price").val(object.purchase_price);
      $("#price").val(object.price);
      $("#warehouse_cd").val(object.warehouse_cd);
      $("#warehouse_nm").val(object.warehouse_nm);
      $("#stock").val(object.stock);
      $("#detail").val(object.detail);
      $("#thumbnail").val("");
      $("#tempImg").attr("src", object.file_relative_path);

      $("#btnSaveMainProduct").hide();
      $("#btnDeleteMainProduct").show();
      $("#product_cd").attr("readonly", true);
      $("#prod_nm").attr("readonly", true);
      $("#l_ct_nm").attr("readonly", true);
      $("#m_ct_nm").attr("readonly", true);
      $("#supply_nm").attr("readonly", true);
      $("#purchase_price").attr("readonly", true);
      $("#price").attr("readonly", true);
      $("#warehouse_cd").attr("readonly", true);
      $("#warehouse_nm").attr("readonly", true);
      $("#stock").attr("readonly", true);
      $("#detail").attr("readonly", true);
      $("#thumbnail").hide();
      
      selectSupplierName();

    }
  }

  /** 제품정보 저장 validation */
  function fValidateMainProduct() {
    var chk = checkNotEmpty([ 
                              [ "product_cd", "제품코드를 입력하세요." ],
                              [ "prod_nm", "제품명을 입력하세요." ],
                              [ "supply_cd", "공급처를 입력하세요." ],
                              [ "warehouse_cd", "창고를 입력하세요." ],
                              [ "purchase_price", "장비구매액을 입력하세요." ],
                              [ "price", "단가를 입력하세요." ],
                              [ "stock", "재고개수를 입력하세요." ],
                              [ "detail", "상세정보를 입력하세요." ]
                            ]);
    if (!chk) {
      return;
    }
    return true;
  }

  //제품정보 저장
  function fSaveMainProduct() {
    //validation 체크
    if (!fValidateMainProduct()) {
      return;
    }
    var resultCallback = function(data) {
      console.log(data);
      fSaveMainProductResult(data);
    };
    callAjax("/scm/saveMainProduct.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
  }
  //제품정보 저장 콜백 함수
  function fSaveMainProductResult(data) {
    var currentPage = "1";
    if ($("#action").val() != "I") {
      currentPage = $("#currentPageMainProduct").val();
    }
    if (data.result == "SUCCESS") {
      alert(data.resultMsg);
      gfCloseModal();
      fListMainProduct(currentPage);
    } else {
      alert(data.resultMsg);
    }
    fInitFormMainProduct();
  }
  
  //제품정보 삭제
  function fDeleteMainProduct(product_cd){
    var con = confirm("삭제하시겠습니까 ? 삭제시 복구가 불가능합니다.");
    var currentPage = "1";
    if (con){
      var resultCallback = function(data) {
      fSaveMainProductResult(data);
    }
    $("#action").val("D");
    callAjax("/scm/saveMainProduct.do", "post", "json", true, $("#myForm").serialize(), resultCallback );
    } else {
      gfCloseModal();
      fListMainProduct(currentPage);
      fInitFormMainProduct();
    }
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
    
  
  //공급처명 이름 콤보박스로 창고 코드와 창고명 가져오기
  function selectSupplierName() {

    var selSp = $("#supply_cd").val();

    /* alert("supply_cd : " + $("#supply_cd").val()); */
    $("#supply_cd").val(selSp);

    var param = {
      selSp : selSp
    }

    var resultCallback = function(data) {
      fWarehouseInfoResult(data);
    }

    callAjax("/scm/getWarehouseInfo.do", "post", "json", true, param, resultCallback);
  }
  
  //창고 코드와 창고명 가져오기 콜백함수
  function fWarehouseInfoResult(data) {
    

    $("#warehouse_cd").val(data.warehouseInfo.cd);
    $("#warehouse_nm").val(data.warehouseInfo.name); 
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
                           <option value="all">전체</option>
                           <option value="prod_nm">제품명</option>
                           <option value="l_ct_nm">품목명</option>
                           <option value="m_ct_nm">상호명</option>
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
                      <th scope="col">품목명</th>
                      <th scope="col">상호명</th>
                      <th scope="col">창고명</th>
                      <th scope="col">장비구매액(원)/EA</th>
                      <th scopt="col">단가(원)/EA</th>
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
    <div id="layer1" class="layerPop layerType2" style="width: 1300px;">
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
                
                <th scope="row" width="100px">제품코드 <span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100" name="product_cd" id="product_cd" maxlength="11" placeholder="제품코드"/>  
                  </td>
                <th scope="row" width="100px">제품명 <span class="font_red">*</span></th>
                <td colspan="3"><input type="text" class="inputTxt p100"
                  name="prod_nm" id="prod_nm" maxlength="100" placeholder="제품명"/></td>
        
              </tr>
              <tr>
              
              <td rowspan="4" style="text-align:center; width:300px; hight:300px;">
                  <img id="tempImg" style="object-fit: cover; max-width:100%; max-hight:100%;" src="/images/admin/comm/no_image.png" alt="제품사진미리보기">
                 </td>   
                
                 <th scope="row">품목명<span class="font_red">*</span></th>
                 <td><input type="text" class="inputTxt p100"
                  name="l_ct_nm" id="l_ct_nm" maxlength="100" placeholder="품목명"/></td>

                  
                  <th scope="row">상호명<span class="font_red">*</span></th>
                  <td><input type="text" class="inputTxt p100"
                  name="m_ct_nm" id="m_ct_nm" maxlength="100" placeholder="품목명"/></td>
                  
                <th scope="row">공급처명 <span class="font_red">*</span></th>
                <td>
                  <input type="hidden" name="supply_nm" id="supply_nm">
                  <select id="supply_cd" name="supply_cd" onChange="javascript:selectSupplierName()"></select></td>
                  
                  </tr>
                  <tr>
                <th scope="row">장비구매액(원)/EA <span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100"
                  name="purchase_price" id="purchase_price" maxlength="11" placeholder="장비구매액"/></td>
                <th scope="row">단가(원)/EA<span class="font_red">*</span></th>
                <td colspan="3"><input type="text" class="inputTxt p100" 
                  name="price" id="price" maxlength="11" placeholder="단가"/></td>
              </tr>
              <tr> 
                <th scope="row">창고명 <span class="font_red">*</span></th>
                <td>
                  <input type="hidden" name="warehouse_cd" id="warehouse_cd">
                  <input type="text" class="inputTxt p100"
                  name="warehouse_nm" id="warehouse_nm" placeholder="창고명"/></td>
                <th scope="row">재고개수(EA)<span class="font_red">*</span></th>
                <td colspan="3"><input type="text" class="inputTxt p100"
                  name="stock" id="stock" maxlength="11" placeholder="제고개수"/></td>
              </tr>
              <tr>
                <th rowspan="2" scope="row">상세정보 <span class="font_red">*</span></th>
                <td rowspan="2" colspan = "5"><textarea class = "ui-widget ui-widget-content ui-corner-all" id="detail" maxlength="500" name="detail" 
                                            style="height:130px;outline:none;resize:none;" placeholder="여기에 상세정보를 적어주세요.(500자 이내)"></textarea></td>
              </tr>
              <tr>
              <td class="thumb">
                            <span> 
                <input name="thumbnail" type="file" id="thumbnail" accept="image/* " required>
    
                    <!-- 파일 미리보기 스크립트 영역 -->
                       <script>
                       var file = document.querySelector('#thumbnail');
                    
                       file.onchange = function () { 
                           var fileList = file.files ;
                           
                           // 읽기
                           var reader = new FileReader();
                           reader.readAsDataURL(fileList [0]);
                           //로드 한 후
                           reader.onload = function  () {
                               //로컬 이미지를 보여주기
                               
                               //썸네일 이미지 생성
                               var tempImage = new Image(); //drawImage 메서드에 넣기 위해 이미지 객체화
                               tempImage.src = reader.result; //data-uri를 이미지 객체에 주입
                               tempImage.onload = function() {
                                   //리사이즈를 위해 캔버스 객체 생성
                                   var canvas = document.createElement('canvas');
                                   var canvasContext = canvas.getContext("2d");
                                   
                                   //캔버스 크기 설정
                                   canvas.width = 300; //가로 300px
                                   canvas.height = 300; //세로 300px
                                   
                                   
                                   //이미지를 캔버스에 그리기
                                   canvasContext.drawImage(this, 0, 0, 300, 300);
                                   //캔버스에 그린 이미지를 다시 data-uri 형태로 변환
                                   var dataURI = canvas.toDataURL("image/jpeg");
                                   
                                   //썸네일 이미지 보여주기
                                   document.querySelector('#tempImg').src = dataURI;
                               };
                           }; 
                       };
                                </script>
                                <!-- 파일 미리보기 스크립트 영역 끝 -->
                                </span>
                 </td>
              </tr>
            </tbody>
          </table>
          
          
          <div class="btn_areaC mt30">
            <a href="" class="btnType blue" id="btnSaveMainProduct" name="btn"><span>저장</span></a>
             <a href="" class="btnType blue" id="btnDeleteMainProduct" name="btn"><span>삭제</span></a>   
             <a href="" class="btnType gray" id="btnCloseMainProduct" name="btn"><span>닫기</span></a>
          </div>
          
        </dd>
      </dl>
      <a href="" class="closePop"><span class="hidden">닫기</span></a>
    </div>
  </form>
</body>
</html>