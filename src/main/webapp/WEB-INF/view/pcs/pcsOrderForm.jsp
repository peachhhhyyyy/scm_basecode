<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>발주서</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
  // 발주서 페이징 설정
  var pageSizePcsOrderForm = 10;
  var pageBlockSizePcsOrderForm = 5;

  $(document).ready(function() {
    // 발주서 조회
    fListPcsOrderForm();

    // 버튼 이벤트 등록
    fRegisterButtonClickEvent();
  });

  /** 버튼 이벤트 등록 */
  function fRegisterButtonClickEvent() {
    $('a[name=btn]').click(function(e) {
      e.preventDefault();

      var btnId = $(this).attr('id');

      switch (btnId) {
      case 'btnClosePcsOrderForm':
        gfCloseModal();
        break;
      case 'btnSearchOrderForm':
        board_search();
        break;
      case 'btnSubmitPcsOrderForm':
        fsend();
        break;
      }
    });
  }

  /** 발주서 상세페이지 모달 실행 */  
  function fPopPcsOrderForm(purch_list_no, order_cd, supply_nm, prod_nm, m_ct_cd, warehouse_nm, purch_qty, purchase_price, purch_mng_id, direction_date, purch_date, desired_delivery_date, supply_cd, product_cd, STTcd, detail_name) {
    // 신규 저장
    if (purch_list_no == null || purch_list_no == "") {
    } else {
      // 발주서 버튼 클릭 시 화면 출력
      fSelectPurchBtn(purch_list_no, order_cd, supply_nm, prod_nm, m_ct_cd, warehouse_nm, purch_qty, purchase_price, purch_mng_id, direction_date, purch_date, desired_delivery_date, supply_cd, product_cd, STTcd, detail_name);
    }
  }

  /** 발주서 검색 */  
  function board_search(currentPage) {
    var sname = $('#sname').val();
    var searchKey = document.getElementById("searchKey");
    var oname = searchKey.options[searchKey.selectedIndex].value;
    
    console.log("sname : " + sname);
    console.log("oname : " + oname);
    
    currentPage = currentPage || 1;
    console.log("currentPage : " + currentPage);
    
    var date = $("#datetimepicker1").find("input").val()
    
    console.log("date : " + date);
    
    // datepicker설정
    $(document).ready(function() {
      $('#datetimepicker1').datetimepicker({
          format: 'YYYY-MM-DD',
          formatDate: 'YYYY-MM-DD'
      });
      $("#datetimepicker1").on("change.datetimepicker", function(e) {
        var date = $("#datetimepicker1").find("input").val();
        console.log('날짜확인 :', date);
        $('#datetimepicker2').datetimepicker('minDate', e.date);
      });
    });
    
    var param = {
          sname : sname
          , oname : oname
          , date : date
          , currentPage : currentPage
          , pageSize : pageSizePcsOrderForm
    }
    //swal(JSON.stringify(param));
    var resultCallback = function(data) {
      fListPcsOrderFormResult(data, currentPage);
    };
    callAjax("/pcs/listPcsOrderForm.do", "post", "text", true, param, resultCallback);
  }
  
  /** 발주서 목록 조회 */
  function fListPcsOrderForm(currentPage) {
    currentPage = currentPage || 1;

    console.log("currentPage : " + currentPage);

    var param = {
      currentPage : currentPage,
      pageSize : pageSizePcsOrderForm
    }
    var resultCallback = function(data) {
      fListPcsOrderFormResult(data, currentPage);
    };
    //Ajax실행 방식
    //callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
    callAjax("/pcs/listPcsOrderForm.do", "post", "text", true, param, resultCallback);
  }

  /** 발주서 콜백 함수 */
  function fListPcsOrderFormResult(data, currentPage) {
    //alert(data);
    console.log("data: " + data);

    // 기존 목록 삭제
    $("#listPcsOrderForm").empty();

    // 신규 목록 생성
    $("#listPcsOrderForm").append(data);

    // 총 개수 추출
    var totalCount = $("#totalCount").val();
    
    // 페이지 네비게이션 생성
    var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSizePcsOrderForm, pageBlockSizePcsOrderForm, 'fListPcsOrderForm');
    console.log("paginationHtml : " + paginationHtml);
    //alert(paginationHtml);
    $("#pcsOrderFormPagination").empty().append(paginationHtml);

    // 현재 페이지 설정
    $("#currentPage").val(currentPage);
  }

  /** 시간 변환 함수 
    출처 : https://stackoverflow.com/questions/23593052/format-javascript-date-as-yyyy-mm-dd
  */
  function formatDate(date) {
    var d = new Date(date),
    month = '' + (d.getMonth() + 1),
    day = '' + d.getDate(),
    year = d.getFullYear();
    
    if (month.length < 2) 
    month = '0' + month;
    if (day.length < 2) 
    day = '0' + day;
    
    return [year, month, day].join('-');
  }
  
  /** 발주서 화면 띄우기 */ 
  function fSelectPurchBtn(purch_list_no, order_cd, supply_nm, prod_nm, m_ct_cd, warehouse_nm, purch_qty, purchase_price, purch_mng_id, direction_date, purch_date, desired_delivery_date, supply_cd, product_cd, STTcd, detail_name) {

    var param = {
      purch_list_no : purch_list_no,
      order_cd : order_cd,
      supply_nm : supply_nm,
      prod_nm : prod_nm,
      m_ct_cd : m_ct_cd,
      warehouse_nm : warehouse_nm,
      purch_qty : purch_qty,
      purchase_price : purchase_price,
      purch_mng_id : purch_mng_id,
      direction_date : direction_date,
      purch_date : purch_date,
      desired_delivery_date : desired_delivery_date,
      supply_cd : supply_cd,
      product_cd : product_cd,
      STTcd : STTcd,
      detail_name : detail_name
    };
    
    $("#purchListNo").text(purch_list_no);
    $("#supplyNm").text(supply_nm);
    $("#prodNm").text(prod_nm);
    $("#mCtCd").text(m_ct_cd);
    $("#warehouseNm").text(warehouse_nm);
    $("#purchQty").text(purch_qty);
    $("#purchMngId").text(purch_mng_id);
    $("#purchasePrice").text(purchase_price);
    
    // 날짜 타입 변환
    var date1 = purch_date.substr(0, 10);
    var date2 = purch_date.substr(24, 29);
    purch_date = date1 + ',' + date2;
    $("#purchDate").text(formatDate(purch_date));
    var date3 = desired_delivery_date.substr(0, 10);
    var date4 = desired_delivery_date.substr(24, 29);
    desired_delivery_date = date3 + ',' + date4;
    $("#desiredDeliveryDate").text(formatDate(desired_delivery_date));
    $("#STTcd").text(STTcd);
    
    var resultCallback = function(data) {
      fSelectPurchBtnResult(data);
    };

    callAjax("/pcs/selectPurchBtn.do", "post", "json", true, param, resultCallback);
  }
  
  /** 발주서 화면 콜백 함수*/
  function fSelectPurchBtnResult(data) {
    if (data.result == "SUCCESS") {
      // 모달 팝업
      gfModalPop("#layer1");
          
      $("#purchMngId").text(data.pcsModel.purch_mng_id);
      $("#purchasePrice").text(data.pcsModel.purchase_price);
      
      console.log("fSelectPurchBtnResult : " + JSON.stringify(data));
    } else {
      alert(data.resultMsg);
    }
  }
  
  /** 입고완료 버튼 클릭 */
  function fSelectUpdateSTTcd(STTcd, detail_name, order_cd, product_cd, purch_qty) {
    var param = {
        STTcd : STTcd,
        detail_name : detail_name,
        order_cd : order_cd,
        product_cd : product_cd,
        purch_qty : purch_qty
      };
    
    var resultCallback = function(data) {
      fSelectUpdateSTTcdResult(data);
    };
    //Ajax실행 방식
    //callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
    callAjax("/pcs/updateSTTcd.do", "post", "text", true, param, resultCallback);
  }
  
  /** 입고완료 버튼 클릭 콜백 함수 */
  function fSelectUpdateSTTcdResult(data) {
    if (data.result == "SUCCESS") {
      // 모달 팝업
      console.log("fSelectUpdateSTTcdResult : " + JSON.stringify(data));
    } else {
      location.reload();
    }
  }
  
  /** 반품서 화면 띄우기 */ 
  function fSelectRefundBtn(purch_list_no, supply_nm, supply_cd, prod_nm, m_ct_nm, product_cd, return_qty, warehouse_cd, purch_mng_id) {
    var param = {
      purch_list_no : purch_list_no,
      supply_nm : supply_nm,
      supply_cd : supply_cd,
      prod_nm : prod_nm,
      m_ct_nm : m_ct_nm,
      product_cd : product_cd,
      return_qty : return_qty,
      warehouse_cd : warehouse_cd,
      purch_mng_id : purch_mng_id
    };
    
    $("#purch_list_no").val(purch_list_no);
    $("#supply_nm").val(supply_nm);
    $("#supply_cd").val(supply_cd);
    $("#prod_nm").val(prod_nm);
    $("#m_ct_nm").val(m_ct_nm);
    $("#product_cd").val(product_cd);
    $("#return_qty").val(return_qty);
    $("#warehouse_cd").val(warehouse_cd);
    $("#purch_mng_id").val(purch_mng_id);
    
    var resultCallback = function(data) {
      fSelectRefundBtnResult(data);
    };

    callAjax("/pcs/selectRefundBtn.do", "post", "json", true, param, resultCallback);
  }
  
  /** 반품서 화면 콜백 함수*/
  function fSelectRefundBtnResult(data) {
    if (data.result == "SUCCESS") {
      // 모달 팝업
      gfModalPop("#layer2");
      
      console.log("fSelectRefundBtnResult : " + JSON.stringify(data));
    } else {
      alert(data.resultMsg);
    }
  }
  
  /** 발주서 목록 조회 */
  function fsend() {
    var purch_list_no = $("#purchListNo").text();
    var order_cd = $("#order_cd").val();
    var supply_cd = $("#supply_cd").val();
    var purch_date = $(".purchaseDateValue").val();
    var desired_delivery_date = $(".desiredDeliveryDateValue").val();
 
    var param = {
        purch_list_no : purch_list_no,
        order_cd : order_cd,
        supply_cd : supply_cd,
        purch_date : purch_date,
        desired_delivery_date : desired_delivery_date
    }
    
    var resultCallback = function(data) {
      fsendResult(data);
    };
    //Ajax실행 방식
    //callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
    callAjax("/pcs/sendrefund.do", "post", "json", true, param, resultCallback);
  }
  
  function fsendResult(data) {
    if (data.result == "SUCCESS") {
      alert(data.resultMsg);
      location.reload('');
      console.log("fsendResult : " + JSON.stringify(data));
    } else {
      alert(data.resultMsg);
    }
  }
  
</script>
</head>
<body>
    <form id="myForm" action="" method="">
        <input type="hidden" id="currentPage" value="1">
        <input type="hidden" id="product_cd" name="product_cd" value="">
        <input type="hidden" name="action" id="action" value="">
        <!-- 모달 배경 -->
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
                                <a href="#" class="btn_set home">메인으로</a>
                                <a href="pcsOrderingoOrder.do" class="btn_nav">구매</a>
                                <span class="btn_nav bold">발주서</span>
                                <a href="../pcs/pcsOrderForm.do" class="btn_set refresh">새로고침</a>
                            </p>
                            <p class="conTitle">
                                <span>발주서</span>
                            </p>
                            <form class="search-container">
                                <div class="row">
                                    <!-- searchbar -->
                                    <div class="col-lg-6">
                                        <div class="input-group">
                                            <select id="searchKey" name="searchKey" style="width:90px;height:34px;">
                                               <option value="all">전체</option>
                                               <option value="brand">상호명</option>
                                               <option value="product">제품명</option>
                                            </select>
                                            <input type="text" id="sname" name="sname" class="form-control">
                                        </div>
                                    </div>
                                    <!-- // searchbar -->
                                    <!-- date -->
                                    <div class='col-md-3 col-xs-4'>
                                      <div class="form-group">
                                        <div class="input-group date" id="datetimepicker1" data-target-input="nearest">
                                          <input type="text" class="form-control datetimepicker-input" data-target="#datetimepicker1" value="">
                                          <div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker">
                                            <div class="input-group-text">
                                              <i class="fa fa-calendar"></i>
                                            </div>
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                    <!-- // date -->
                                    <!-- button -->
                                    <div class="btn-group" role="group" aria-label="...">
                                      <a class="btn btn-default" id="btnSearchOrderForm" name="btn" href="">검색</a>
                                    </div>
                                    <!-- // button -->
                                </div>
                                <!-- /.row -->
                            </form>
                            <div class="divComGrpCodList">
                                <table class="col">
                                    <caption>caption</caption>
                                    <colgroup>
                                        <col width="5%">
                                        <col width="7%">
                                        <col width="10%">
                                        <col width="10%">
                                        <col width="7%">
                                        <col width="7%">
                                        <col width="10%">
                                        <col width="10%">
                                        <col width="10%">
                                        <col width="7%">
                                        <col width="*">
                                        <col width="6%">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th scope="col">발주번호</th>
                                            <th scope="col">발주코드</th>
                                            <th scope="col">공급처명</th>
                                            <th scope="col">제품명</th>
                                            <th scope="col">상호명</th>
                                            <th scope="col">발주수량</th>
                                            <th scope="col">창고명</th>
                                            <th scope="col">발주날짜</th>
                                            <th scope="col">배송희망날짜</th>
                                            <th scope="col">상태</th>
                                            <th scope="col">입고완료</th>
                                            <th scope="col">반품</th>
                                        </tr>
                                    </thead>
                                    <tbody id="listPcsOrderForm"></tbody>
                                </table>
                            </div>
                            <div class="paging_area" id="pcsOrderFormPagination"></div>
                        </div> <!--// content -->
                        <h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
                    </li>
                </ul>
            </div>
        </div>
        <!-- 모달팝업 -->
        <div id="layer1" class="layerPop layerType2" style="width: 600px;">
            <dl>
                <dt>
                    <strong>발주서</strong>
                </dt>
                <dd class="content">
                    <!-- s : 여기에 내용입력 -->
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
                                <th scope="row">발주번호</th>
                                <td id="purchListNo"></td>
                                <th scope="row">공급처명</th>
                                <td id="supplyNm"></td>
                            </tr>
                            <tr>
                                <th scope="row">제품명</th>
                                <td id="prodNm" colspan="3"></td>
                            </tr>
                            <tr>
                                <th scope="row">상호명</th>
                                <td id="mCtCd" colspan="3"></td>
                            </tr>
                            <tr>
                                <th scope="row">창고명</th>
                                <td id="warehouseNm"></td>
                                <th scope="row">제품수량</th>
                                <td id="purchQty"></td>
                            </tr>
                            <tr>
                                <th scope="row">담당자</th>
                                <td id="purchMngId"></td>
                                <th scope="row">금액</th>
                                <td id="purchasePrice"></td>
                            </tr>
                            <tr>
                                <th scope="row">발주날짜</th>
                                <td id="purchDate"></td>
                                <th scope="row">배송희망날짜</th>
                                <td id="desiredDeliveryDate"></td>
                            </tr>
                        </tbody>
                    </table>
                    <!-- e : 여기에 내용입력 -->
                    <div class="btn_areaC mt30">
                        <a href="" class="btnType gray" id="btnClosePcsOrderForm" name="btn"><span>닫기</span></a>
                    </div>
                </dd>
            </dl>
            <a href="" class="closePop"><span class="hidden">닫기</span></a>
        </div>
        <!--// 모달팝업 -->
        <!-- 모달팝업 -->
        <div id="layer2" class="layerPop layerType2" style="width: 600px;">
            <dl>
                <dt>
                    <strong>반품서</strong>
                </dt>
                <dd class="content">
                    <!-- s : 여기에 내용입력 -->
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
                                <th scope="row">반품번호</th>
                                <td colspan="3"><input type="text" class="form-control" name="purch_list_no" id="purch_list_no" /></td>
                            </tr>
                            <tr>
                                <th scope="row">공급처명</th>
                                <td><input type="text" class="form-control" name="supply_nm" id="supply_nm" /></td>
                                <th scope="row">공급처코드</th>
                                <td><input type="text" class="form-control" name="supply_cd" id="supply_cd" /></td>
                            </tr>
                            <tr>
                                <th scope="row">제품명</th>
                                <td colspan="3"><input type="text" class="form-control" name="prod_nm" id="prod_nm" /></td>
                            </tr>
                            <tr>
                                <th scope="row">상호명</th>
                                <td colspan="3"><input type="text" class="form-control" name="m_ct_nm" id="m_ct_nm" /></td>
                            </tr>
                            <tr>
                                <th scope="row">제품번호</th>
                                <td><input type="text" class="form-control" name="product_cd" id="product_cd" /></td>
                                <th scope="row">제품수량</th>
                                <td><input type="text" class="form-control" name="return_qty" id="return_qty" /></td>
                            </tr>
                            <tr>
                                <th scope="row">창고코드</th>
                                <td><input type="text" class="form-control" name="warehouse_cd" id="warehouse_cd" /></td>
                                <th scope="row">담당자</th>
                                <td><input type="text" class="form-control" name="purch_mng_id" id="purch_mng_id" /></td>
                            </tr>
                        </tbody>
                    </table>
                    <!-- e : 여기에 내용입력 -->
                    <div class="btn_areaC mt30">
                        <a href="" class="btnType blue" id="btnSubmitPcsOrderForm" name="btn"><span>전송</span></a>
                        <a href="" class="btnType gray" id="btnClosePcsOrderForm" name="btn"><span>닫기</span></a>
                    </div>
                </dd>
            </dl>
            <a href="" class="closePop"><span class="hidden">닫기</span></a>
        </div>
        <!--// 모달팝업 -->
    </form>
    <script>
    $(document).ready(function() {
      $('#datetimepicker1').datetimepicker({
          format: 'YYYY-MM-DD',
          formatDate: 'YYYY-MM-DD',
          language: 'ko',
          autoclose: true,
      });
    });
    </script>
</body>
</html>