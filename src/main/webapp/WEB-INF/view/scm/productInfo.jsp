<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="kr.happyjob.study.scm.model.ProductInfoModel"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>제품정보 관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link rel="stylesheet" href="${CTX_PATH}/css/chosen/chosen.css">
<script src="${CTX_PATH}/js/chosen/chosen.jquery.js"></script>
<script type="text/javascript">
  /*페이징 설정*/
  var userPageSize = 10;
  var userPageBlock = 5;

  /** OnLoad event */
  $(document).ready(function() {

    // 리스트 뿌리기 함수
    selectProductList();

    // 버튼 이벤트 등록
    fButtonClickEvent();

    // chosen load 
    $(".chosen-select").chosen({
    width : '-webkit-fill-available',
    rtl : true
    });

    //css 설정
    $('textarea').addClass("ui-corner-all ui-widget-content");

    //엔터눌렀을때 검색되게하기
    $("#sname").keypress(function(e) {
      if (e.which == 13) {
        board_search(); // 실행할 이벤트
      }
    });

  });

  /*버튼 이벤트 등록*/
  function fButtonClickEvent() {
    $('a[name=btn]').click(function(e) {
      e.preventDefault();

      var btnId = $(this).attr('id');

      switch (btnId) {
      case 'btnSavePro':
        fSaveProduct(); // save 안에 저장,수정
        break;
      case 'btnDeletePro':
        fDeleteProduct(); // 만들자 
        //alert("삭제버튼 클릭!!!이벤트!!");   
        break;
      case 'btnClose':
        gfCloseModal(); // 모달닫기 
        break;
      case 'btnUpdatePro':
        fUpdateProduct(); // 수정하기
        break;
      case 'searchBtn':
        board_search(); // 검색하기
        break;
      }
    });
  }

  /** 제품정보 목록 불러오기 */
  function selectProductList(currentPage) {

    currentPage = currentPage || 1;

    var param = {
    currentPage : currentPage,
    pageSize : userPageSize
    }

    var resultCallback = function(data) {
      productListResult(data, currentPage);
    };

    callAjax("/scm/productList.do", "post", "text", true, param, resultCallback);
  }

  /** 제품정보 리스트의 data를 콜백함수를 통해 뿌리기 */
  function productListResult(data, currentPage) {

    // 기존 목록 삭제
    $("#productList").empty();

    // 신규 목록 생성
    $("#productList").append(data);

    // 총 개수 추출
    var totalCnt = $("#totalCount").val();

    var list = $("#tmpList").val();

    // 페이지 네비게이션 생성
    var paginationHtml = getPaginationHtml(currentPage, totalCnt, userPageSize, userPageBlock, 'selectProductList');

    // 기존 목록 삭제 후 다시 생성
    $("#paginationHtml").empty().append(paginationHtml);

    // 현재 페이지 설정
    $("#currentPage").val(currentPage);
  }

  //검색
  function board_search(currentPage) {

    currentPage = currentPage || 1;
    var param = {
    currentPage : currentPage,
    pageSize : userPageSize
    }

    var resultCallback = function(data) {
      ProductListResult(data, currentPage);
    };
    callAjax("/scm/productList.do", "post", "text", true, param, resultCallback);
  }

  /* 제품정보관리 모달창(팝업) 실행 */
  function fUserModal(product_cd) {

    // 신규저장 하기 버튼 클릭시 (값이 null)
    if (product_cd == null || product_cd == "") {

      $("#action").val("I"); // insert 
      frealPopModal(product_cd); //  초기화 

      //모달 팝업 모양 오픈! (빈거) _ 있는 함수 쓰는거임. 
      gfModalPopTop("#user");

    } else {
      $("#action").val("U"); // update
      fdetailModal(product_cd); //번호로 -> 상품 상세 조회 팝업 띄우기
    }
  }

  /*1건 상세 조회*/
  function fdetailModal(product_cd) {

    var param = {
      product_cd : product_cd
    };
    var resultCallback2 = function(data) {
      fdetailResult(data);
    };

    callAjax("/scm/detailProduct.do", "post", "json", true, param, resultCallback2);
  }

  /*  1건 상세 조회 -> 콜백함수   */
  function fdetailResult(data) {
    //alert("공지사항 상세 조회  33");
    if (data.resultMsg == "SUCCESS") {
      //모달 띄우기 
      gfModalPopTop("#user");
      // 모달에 정보 넣기 
      frealPopModal(data.result);

    } else {
      alert(data.resultMsg);
    }
  }

  /* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */
  function frealPopModal(object) {

    /* 신규 */
    if (object == "" || object == null || object == undefined) {

      $("#product_cd").val(""); // product_cd 되돌리기
      $("#product_cd").attr("readonly", false); // product_cd 되돌리기
      $("#product_cd").css("border", ""); // product_cd 되돌리기

      $("#l_ct_nm").val("");
      $("#prod_nm").val("");

      $("#warehouse_nm option").prop("selected", false).trigger("chosen:updated");
      $("#warehouse_nm").chosen();
      $("#m_ct_nm").val("");

      $("#purchase_price").val("");
      $("#price").val("");

      // chosen option
      $("#supply_nm").val("").trigger("chosen:updated");
      $("#btnDeletePro").hide(); // 삭제버튼 숨기기
      $("#btnUpdatePro").hide();
      $("#btnSavePro").show();

    } else {
      $("#warehouse_nm option").prop("selected", false).trigger("chosen:updated");
      $("#warehouse_nm").chosen();
      $("#product_cd").val(object[0].product_cd);
      $("#product_cd").attr("readonly", true); // product_cd 수정불가 
      $("#product_cd").css("border", "none"); // product_cd 수정불가 

      $("#l_ct_nm").val(object[0].l_ct_nm);
      $("#prod_nm").val(object[0].prod_nm);
      $("#m_ct_nm").val(object[0].pro_manu_name);
      $("#purchase_price").val(object[0].purchase_price);
      $("#price").val(object[0].price);

      // chosen option setting
      for (var i = 0; i < object.length; i++) {
        $('#warehouse_nm option[value=' + object[i].warehouse_nm + ']').prop('selected', true).trigger("chosen:updated");
      }
      $("#supply_nm").val(object[0].deli_no).trigger("chosen:updated");

      $("#btnDeletePro").show(); // 삭제버튼 보이기 
      $("#btnSavePro").hide();
      $("#btnUpdatePro").css("display", "");

    }
  }

  /* 팝업내 수정, 저장 확인 */
  function fValidatePopup() {
    var chk = checkNotEmpty([ [ "product_cd", "제품코드를 입력해주세요!" ], [ "prod_nm", "제품명을 입력해주세요!" ], [ "warehouse_nm", "저장창고를 선택해주세요!" ], [ "l_ct_nm", "모델명을 입력해주세요!" ], [ "m_ct_nm", "제조사를 입력해주세요!" ], [ "purchase_price", "장비 구매액을 입력해주세요!" ], [ "supply_nm", "납품업체를 선택해주세요!" ], [ "price", "단가를 입력해주세요!" ], [ "thumbnail", "대표 이미지를 업로드해주세요!" ] ]);

    if (!chk) {
      return;
    }
    return true;
  }

  /* 제품 등록(저장) */
  function fSaveProduct() {

    // validation 체크 
    if (!(fValidatePopup())) {
      return;
    }

    var resultCallback3 = function(data) {
      fSaveProductResult(data);

    };
    //form
    var frm = document.getElementById("myProduct");
    frm.enctype = 'multipart/form-data';
    var dataWithFile = new FormData(frm);

    //다중 selected option값 가져오기
    var selected = [];
    $('#warehouse_nm :selected').each(function() {
      selected.push($(this).val());
    });
    //form에 추가
    dataWithFile.append("ware_list", selected);

    $("#action").val("I"); // insert

    callAjaxFileUploadSetFormData("/scm/productSave.do", "post", "json", true, dataWithFile, resultCallback3);

  }

  /* 저장 ,수정, 삭제 콜백 함수 처리  */
  function fSaveProductResult(data) {
    var currentPage = currentPage || 1;

    if ($("#action").val() != "I") {
      currentPage = $("#currentPage").val();
    }

    if (data.resultMsg == "SUCCESS") {
      //alert(data.resultMsg); // 받은 메세지 출력 
      alert("저장 되었습니다.");
    } else if (data.resultMsg == "UPDATE") {
      alert("수정 되었습니다.");
    } else if (data.resultMsg == "DELETE") {
      alert("삭제 되었습니다.");
    } else {
      alert(data.resultMsg); //실패시 이거 탄다. 
      alert("실패 했습니다.");
    }

    gfCloseModal(); // 모달 닫기
    selectProductList(currentPage); // 목록조회 함수 다시 출력 
    frealPopModal();// 입력폼 초기화
  }

  /* 제품 수정 */
  function fUpdateProduct() {

    // validation 체크 
    if (!(fValidatePopup())) {
      return;
    }

    var resultCallback3 = function(data) {
      fSaveProductResult(data);
    };

    //form  
    var frm = document.getElementById("myProduct");
    frm.enctype = 'multipart/form-data';
    var dataWithFile = new FormData(frm);

    //다중 selected option값 가져오기
    var selected = [];
    $('#warehouse_nm :selected').each(function() {
      selected.push($(this).val());
    });
    //form에 추가
    dataWithFile.append("ware_list", selected);

    $("#action").val("I"); // insert

    $("#action").val("U"); // update

    callAjaxFileUploadSetFormData("/scm/productUpd.do", "post", "json", true, dataWithFile, resultCallback3);

  }

  /* 상품 1건 삭제 */
  function fDeleteProduct() {
    var con = confirm("정말 삭제하겠습니까? \n 삭제시 복구불가합니다.");
    if (con) {
      var resultCallback3 = function(data) {
        fSaveProductResult(data);
      }
      $("#action").val("D"); // delete
      callAjax("/scm/productDel.do", "post", "json", true, $("#myProduct").serialize(), resultCallback3);
    } else {
      gfCloseModal(); // 모달 닫기
      selectProductList(currentPage); // 목록조회 함수 다시 출력 
      frealPopModal();// 입력폼 초기화
    }
  }

  //숫자타입체크
  function filterNumber(elem, event) {
    elem.value = elem.value.replace(/[^0-9]/g, "");
    var code = event.keyCode;
    if ((code > 47 && code < 58) || event.ctrlKey || event.altKey || code == 8 || code == 9 || code == 46) {
      return;
    }
    event.preventDefault();
    return false;
  }
  function filterNum(elem) {
    elem.value = elem.value.replace(/[^0-9]/g, "");
  }
</script>
</head>
<body>
  <form id="myProduct" action="" method="">
    <input type="hidden" id="currentPage" value="1">
    <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
    <input type="hidden" id="tmpList" value="">
    <!-- ★ 이거뭐임??? -->
    <input type="hidden" id="tmpListNum" value="">
    <!-- 스크립트에서 값을 설정해서 넘길거임 / 임시 리스트 넘버 -->
    <input type="hidden" name="action" id="action" value="">
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
                <a href=/system/comnCodMgr.do " class="btn_set home">메인으로</a> <a href="#" class="btn_nav">기준 정보</a> <span class="btn_nav bold">제품정보 관리</span> <a onClick="top.location='javascript:location.reload()'" class="btn_set refresh">새로고침</a>
              </p>
              <p class="conTitle">
                <span>제품정보 관리 </span> <span class="fr"> <c:set var="nullNum" value=""></c:set> <a class="btnType blue" href="javascript:fUserModal(${null});" name="modal"> <span>신규등록</span></a>
                </span>
              </p>
              <!--검색창   -->
              <table width="100%" cellpadding="5" cellspacing="0" border="1" align="left" style="border-collapse: collapse; border: 1px #50bcdf;">
                <tr style="border: 0px; border-color: blue">
                  <td width="100" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>
                  <td width="50" height="25" style="font-size: 100%; text-align: right; padding-right: 25px;"><select id="oname" name="oname" style="width: 130px; height: 27px">
                      <option value="prod_nm">제품명</option>
                      <option value="l_ct_nm">품목명</option>
                      <option value="supply_nm">공급처명</option>
                  </select> <input type="text" style="width: 150px; height: 25px;" id="sname" name="sname"> <a href="" class="btnType blue" id="searchBtn" name="btn"><span>검 색</span></a></td>
                </tr>
              </table>
              &nbsp;&nbsp;
              <div class="ProductList">
                <table class="col">
                  <caption>caption</caption>
                  <colgroup>
                    <col width="3%">
                    <col width="20%">
                    <col width="5%">
                    <col width="5%">
                    <col width="5%">
                    <col width="7%">
                    <col width="5%">
                    <col width="5%">
                  </colgroup>
                  <thead>
                    <tr>
                      <th scope="col">제품코드</th>
                      <th scope="col">제품명</th>
                      <th scope="col">품목명</th>
                      <th scope="col">제조사명</th>
                      <th scope="col">공급처명</th>
                      <th scope="col">창고명</th>
                      <th scope="col">장비구매가</th>
                      <th scope="col">단가</th>
                    </tr>
                  </thead>
                  <tbody id="productList"></tbody>
                </table>
                <!-- 페이징 처리  -->
                <div class="paging_area" id="paginationHtml"></div>
              </div>
            </div> <!--// content -->
            <h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
          </li>
        </ul>
      </div>
    </div>
    <!-- 제품정보 모달 -->
    <div id="user" class="layerPop layerType2" style="width: 900px; height: auto;">
      <input type="hidden" id="loginID" name="loginID">
      <!-- 수정시 필요한 num 값을 넘김  -->
      <dl>
        <dt>
          <strong>제품정보 관리</strong>
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
                <th scope="row">제품 코드 <span class="font_red">*</span></th>
                <td colspan="3"><input class="ui-widget ui-widget-content ui-corner-all" style="height: 20px;" type="text" maxlength="15" name="product_cd" id="product_cd" /></td>
              </tr>
              <tr>
                <th scope="row">저장 창고 <span class="font_red">*</span></th>
                <td colspan="3"><select name="warehouse_nm" id="warehiuse_nm" data-placeholder="1개 이상의 창고를 선택하세요." multiple class="chosen-select">
                    <c:forEach var="tempCdlist2" items="${whListObj}">
                      <option value="${tempCdlist2.warehouse_nm}">${tempCdlist2.warehouse_cd}</option>
                    </c:forEach>
                </select></td>
              </tr>
              <tr>
                <th scope="row">제품명 <span class="font_red">*</span></th>
                <td><input class="ui-widget ui-widget-content ui-corner-all" style="height: 20px;" type="text" maxlength="15" name="prod_nm" id="prod_nm"></td>
                <th scope="row">모델명 <span class="font_red">*</span></th>
                <td><input class="ui-widget ui-widget-content ui-corner-all" style="height: 20px;" type="text" maxlength="15" name="l_ct_nm" id="l_ct_nm" /></td>
              </tr>
              <tr>
                <th scope="row">제조사 <span class="font_red">*</span></th>
                <td><input class="ui-widget ui-widget-content ui-corner-all" style="height: 20px;" type="text" maxlength="15" name="m_ct_nm" id="m_ct_nm" /></td>
                <th scope="row">단가 <span class="font_red">*</span></th>
                <td><input class="ui-widget ui-widget-content ui-corner-all" style="height: 20px;" type="text" maxlength="10" name="price" id="price" /></td>
              </tr>
              <tr>
                <th scope="row">공급처 <span class="font_red">*</span></th>
                <td><select name="supply_nm" id="supply_nm" style="width: 129px; height: 16.25px" data-placeholder="납품업체를 선택하세요." class="chosen-select">
                    <c:forEach var="tempCdlist3" items="${deliListObj}">
                      <option value="${tempCdlist3.supply_nm}">${tempCdlist3.supply_cd}</option>
                    </c:forEach>
                </select></td>
                <th scope="row">장비구매가 <span class="font_red">*</span></th>
                <td><input class="ui-widget ui-widget-content ui-corner-all" style="height: 20px;" type="text" maxlength="10" name="purchase_price" id="purchase_price" /></td>
              </tr>
            </tbody>
          </table>
          <div class="btn_areaC mt30">
            <a href="" class="btnType blue" id="btnUpdatePro" name="btn" style="display: none"><span>수정</span></a> <a href="" class="btnType blue" id="btnDeletePro" name="btn"><span>삭제</span></a> <a href="" class="btnType blue" id="btnSavePro" name="btn"><span>저장</span></a> <a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
          </div>
        </dd>
      </dl>
      <a href="" class="closePop"><span class="hidden">닫기</span></a>
    </div>
  </form>
</body>
</html>