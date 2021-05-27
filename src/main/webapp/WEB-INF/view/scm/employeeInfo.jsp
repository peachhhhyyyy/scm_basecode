<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>발주지시서</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
  // SCM 발주 지시서 페이징 설정
  var pageSizeScmOrderingOrder = 10;
  var pageBlockSizeScmOrderingOrder = 5;

  $(document).ready(function() {
    // SCM 발주지시서 조회
    fListEmployeeInfo();

    // 버튼 이벤트 등록
    fRegisterButtonClickEvent();
  });

  /** 버튼 이벤트 등록 */
  function fRegisterButtonClickEvent() {
    $('a[name=btn]').click(function(e) {
      e.preventDefault();

      var btnId = $(this).attr('id');

      switch (btnId) {
      case 'btnCloseOrderingOrder':
        gfCloseModal();
        break;
      case 'btnSearchOrderingOrder':
        board_search();
        break;
      }
    });
  }

  /** SCM 발주지시서 모달 실행 */
  function fPopEmployeeInfo(scm_id, direction_date, prod_nm, purch_qty, m_ct_cd, purchase_price, supply_nm, price, approve_id) {
    // 신규 저장
    if (prod_nm == null || prod_nm == "") {
    } else {
      fSelectPurchBtn(scm_id, direction_date, prod_nm, purch_qty, m_ct_cd, purchase_price, supply_nm, price, approve_id);
    }
  }

  /** SCM 발주지시서 검색 */  
  function board_search(currentPage) {
    var sname = $('#sname').val();
    var searchKey = document.getElementById("searchKey");
    var oname = searchKey.options[searchKey.selectedIndex].value;
    
    console.log("sname : " + sname);
    console.log("oname : " + oname);
    
    currentPage = currentPage || 1;
    console.log("currentPage : " + currentPage);
    
    var date1 = $("#datetimepicker1").find("input").val()
    var date2 = $("#datetimepicker2").find("input").val()
    
    console.log("date1 : " + date1);
    console.log("date2 : " + date2);
    
    // datepicker설정
    $(document).ready(function() {
      $('#datetimepicker1').datetimepicker({
          format: 'YYYY-MM-DD',
          formatDate: 'YYYY-MM-DD'
      });
      $('#datetimepicker2').datetimepicker({
	        format: 'YYYY-MM-DD',
	        formatDate: 'YYYY-MM-DD'
	    });
    });
    
    var param = {
          sname : sname
          , oname : oname
          , date1 : date1
          , date2 : date2
          , currentPage : currentPage
          , pageSize : pageSizeScmOrderingOrder
    }
    //swal(JSON.stringify(param));
    var resultCallback = function(data) {
      fListEmployeeInfoResult(data, currentPage);
    };
    callAjax("/scm/employeeInfoList.do", "post", "text", true, param, resultCallback);
  }
  
  /** SCM 발주 지시서 목록 조회 */
  function fListEmployeeInfo(currentPage) {
    currentPage = currentPage || 1;

    console.log("currentPage : " + currentPage);

    var param = {
      currentPage : currentPage,
      pageSize : pageSizeScmOrderingOrder
    }
    var resultCallback = function(data) {
      fListEmployeeInfoResult(data, currentPage);
    };
    //Ajax실행 방식
    //callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
    callAjax("/scm/employeeInfoList.do", "post", "text", true, param, resultCallback);
  }

  /** SCM 발주지시서 콜백 함수 */
  function fListEmployeeInfoResult(data, currentPage) {
    //alert(data);
    console.log("data: " + data);

    // 기존 목록 삭제
    $("#employeeInfoList").empty();

    // 신규 목록 생성
    $("#employeeInfoList").append(data);

    // 총 개수 추출
    var totalCount = $("#totalCount").val();
    
    // 페이지 네비게이션 생성
    var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSizeScmOrderingOrder, pageBlockSizeScmOrderingOrder, 'fListEmployeeInfo');
    console.log("paginationHtml : " + paginationHtml);
    //alert(paginationHtml);
    $("#employeeInfoListPagination").empty().append(paginationHtml);

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
  
  /** 금액 변환 함수
   출처 : https://stackoverflow.com/questions/2901102/how-to-print-a-number-with-commas-as-thousands-separators-in-javascript
  */
  function numberWithCommas(x) {
	  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
  
  /** SCM 발주지시서 상세 화면 띄우기 */ 
  function fSelectPurchBtn(scm_id, direction_date, prod_nm, purch_qty, m_ct_cd, purchase_price, supply_nm, price, approve_id) {

    var param = {
      scm_id : scm_id,
      direction_date : direction_date,
      prod_nm : prod_nm,
      purch_qty : purch_qty,
      m_ct_cd : m_ct_cd,
      purchase_price : purchase_price,
      supply_nm : supply_nm,
      price : price,
      approve_id : approve_id
    };
    
    $("#scmId").text(scm_id);
    // 날짜 타입 변환
    var date1 = direction_date.substr(0, 10);
    var date2 = direction_date.substr(24, 29);
    direction_date = date1 + ',' + date2;
    $("#directionDate").text(formatDate(direction_date));
    $("#prodNm").text(prod_nm);
    $("#purchQty").text(purch_qty);
    $("#mCtCd").text(m_ct_cd);
    $("#purchasePrice").text(numberWithCommas(purchase_price));
    $("#supplyNm").text(supply_nm);
    $("#price").text(numberWithCommas(price));
    $("#approveId").text(approve_id ? approve_id : "승인대기");
    $("#approveId_head").text(approve_id ? "승인자" : "상태");
    
    var resultCallback = function(data) {
      fSelectPurchBtnResult(data);
    };

    callAjax("/scm/selectPurchBtn.do", "post", "json", true, param, resultCallback);
  }
  
  /** SCM 발주지시서 화면 콜백 함수*/
  function fSelectPurchBtnResult(data) {
    if (data.result == "SUCCESS") {
      // 모달 팝업
      gfModalPop("#layer1");
      
      console.log("fSelectPurchBtnResult : " + JSON.stringify(data));
    } else {
      alert(data.resultMsg);
    }
  }
</script>
</head>
<body>
    <form id="myForm" action="" method="">
        <input type="hidden" id="currentPage" value="1">
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
                                <a href="scmPurchaseMain.do" class="btn_nav">작업지시서</a>
                                <span class="btn_nav bold">발주 지시서</span>
                                <a href="../scm/scmPurchaseMain.do" class="btn_set refresh">새로고침</a>
                            </p>
                            <p class="conTitle">
                                <span>발주 지시서</span>
                            </p>
                            <form class="search-container">
                                <div class="row">
                                    <!-- searchbar -->
                                    <div class="col-lg-6">
                                        <div class="input-group">
                                            <select id="searchKey" name="searchKey" style="width:90px;height:34px;">
                                               <option value="employee">직원명</option>
                                               <option value="task">담당업무</option>
                                            </select>
                                            <input type="text" id="sname" name="sname" class="form-control">
                                        </div>
                                    </div>
                                    <!-- // searchbar -->
                                    <!-- button -->
                                    <div class="btn-group" role="group" aria-label="...">
                                      <a class="btn btn-default" id="btnSearchOrderingOrder" name="btn" href="">검색</a>
                                    </div>
                                    <!-- // button -->
                                </div>
                                <!-- /.row -->
                            </form>
                            <div class="divEmployeeInfoList" style="margin-top:15px;">
                                <table class="col">
                                    <caption>caption</caption>
                                    <colgroup>
                                        <col width="10%">
                                        <col width="*">
                                        <col width="10%">
                                        <col width="15%">
                                        <col width="10%">
                                        <col width="10%">
                                        <col width="15%">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th scope="col">사번</th>
                                            <th scope="col">직원명</th>
                                            <th scope="col">담당업무</th>
                                            <th scope="col">연락처</th>
                                            <th scope="col">활성화여부</th>
                                        </tr>
                                    </thead>
                                    <tbody id="employeeInfoList"></tbody>
                                </table>
                            </div>
                            <div class="paging_area" id="employeeInfoListPagination"></div>
                        </div> <!--// content -->
                        <h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
                    </li>
                </ul>
            </div>
        </div>
    </form>
</body>
</html>