<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>직원정보관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
  // 직원정보관리 페이징 설정
  var pageSizeEmployeeInfo = 5;
  var pageBlockSizeEmployeeInfo = 5;

  $(document).ready(function() {
    // 직원정보관리 조회
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
      case 'btnCloseEmployeeInfo':
        gfCloseModal();
        break;
      case 'btnSearchEmployeeInfo':
        board_search();
        break;
      }
    });
  }

  /** 직원정보관리 모달 실행 */
  function fPopEmployeeInfo(loginID, name, tel, mail, detail_name, zip_code, addr, addr_detail, use_yn, entry_date) {
    // 신규 저장
    if (loginID == null || loginID == "") {
    } else {
      fSelectSubmitBtn(loginID, name, tel, mail, detail_name, zip_code, addr, addr_detail, use_yn, entry_date);
    }
  }

  /** 직원정보관리 검색 */  
  function board_search(currentPage) {
    var sname = $('#sname').val();
    var searchKey = document.getElementById("searchKey");
    var oname = searchKey.options[searchKey.selectedIndex].value;
    
    console.log("sname : " + sname);
    console.log("oname : " + oname);
    
    currentPage = currentPage || 1;
    console.log("currentPage : " + currentPage);
    
    var param = {
          sname : sname
          , oname : oname
          , currentPage : currentPage
          , pageSize : pageSizeEmployeeInfo
    }
    //swal(JSON.stringify(param));
    var resultCallback = function(data) {
      fListEmployeeInfoResult(data, currentPage);
    };
    callAjax("/scm/employeeInfoList.do", "post", "text", true, param, resultCallback);
  }
  
  /** 직원정보관리 목록 조회 */
  function fListEmployeeInfo(currentPage) {
    currentPage = currentPage || 1;

    console.log("currentPage : " + currentPage);

    var param = {
      currentPage : currentPage,
      pageSize : pageSizeEmployeeInfo
    }
    var resultCallback = function(data) {
      fListEmployeeInfoResult(data, currentPage);
    };
    //Ajax실행 방식
    //callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
    callAjax("/scm/employeeInfoList.do", "post", "text", true, param, resultCallback);
  }

  /** 직원정보관리 콜백 함수 */
  function fListEmployeeInfoResult(data, currentPage) {
    //alert(data);
    console.log("data: " + data);

    // 기존 목록 삭제
    $("#employeeInfoList").empty().append(data);

    // 총 개수 추출
    var totalCount = $("#totalCount").val();
    
    // 페이지 네비게이션 생성
    var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSizeEmployeeInfo, pageBlockSizeEmployeeInfo, 'fListEmployeeInfo');
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
  
  /** 직원정보관리 상세 화면 띄우기 */ 
  function fSelectSubmitBtn(loginID, name, tel, mail, detail_name, zip_code, addr, addr_detail, use_yn, entry_date) {

    var param = {
      loginID : loginID,
      name : name,
      tel : tel,
      mail : mail,
      detail_name : detail_name,
      zip_code : zip_code,
      addr : addr,
      addr_detail : addr_detail,
      use_yn : use_yn,
      entry_date : entry_date
    };
    
    $("#loginID").val(loginID);
    $("#name").val(name);
    $("#tel").val(tel);
    $("#mail").val(mail);
    $("#detail_name").val(detail_name);
    $("#zip_code").val(zip_code);
    $("#addr").val(addr);
    $("#addr_detail").val(addr_detail);
    $("#use_yn").val(use_yn);
    $("#entry_date").val(entry_date);
    
    var resultCallback = function(data) {
      fSelectSubmitBtnResult(data);
    };

    callAjax("/scm/selectSubmitBtn.do", "post", "json", true, param, resultCallback);
  }
  
  /** 직원정보관리 화면 콜백 함수*/
  function fSelectSubmitBtnResult(data) {
    gfModalPop("#layer1");
    console.log("fSelectSubmitBtnResult : " + JSON.stringify(data));
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
                                <a href="employeeinfo.do" class="btn_nav">기준정보</a>
                                <span class="btn_nav bold">직원정보 관리</span>
                                <a href="../scm/employeeinfo.do" class="btn_set refresh">새로고침</a>
                            </p>
                            <p class="conTitle">
                                <span>직원정보 관리</span>
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
                                      <a class="btn btn-default" id="btnSearchEmployeeInfo" name="btn" href="">검색</a>
                                    </div>
                                    <!-- // button -->
                                    <!-- checkbox -->
                                    <div class="input-group" style="display:inline-block;vertical-align:middle;margin-left:10px;">
	                                    <input type="checkbox" id="searchUseYn" name="searchUseYn" value="">
	                                    <label for="searchUseYn" style="display:inline-block;margin-top:2px;">비활성화된 항목 표시</label>
                                    </div>
                                    <!-- // checkbox -->
                                </div>
                                <!-- /.row -->
                            </form>
                            <div class="divEmployeeInfoList" style="margin-top:15px;">
                                <table class="col">
                                    <caption>caption</caption>
                                    <colgroup>
                                        <col width="20%">
                                        <col width="*">
                                        <col width="15%">
                                        <col width="20%">
                                        <col width="10%">
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
        <!-- 모달팝업 -->
        <div id="layer1" class="layerPop layerType2" style="width: 600px;">
            <dl>
                <dt>
                    <strong>상세정보</strong>
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
                                <th scope="row">아이디</th>
                                <td><input type="text" class="form-control" name="loginID" id="loginID" readonly="readonly"/></td>
                                <th scope="row">직원명</th>
                                <td><input type="text" class="form-control" name="name" id="name" readonly="readonly"/></td>
                            </tr>
                            <tr>
                                <th scope="row">연락처</th>
                                <td><input type="text" class="form-control" name="tel" id="tel" readonly="readonly"/></td>
                                <th scope="row">이메일</th>
                                <td><input type="text" class="form-control" name="mail" id="mail" readonly="readonly"/></td>
                            </tr>
                            <tr>
                                <th scope="row">담당업무</th>
                                <td colspan="3"><input type="text" class="form-control" name="detail_name" id="detail_name" readonly="readonly"/></td>
                            </tr>
                            <tr>
                                <th scope="row">우편번호</th>
                                <td colspan="3"><input type="text" class="form-control" name="zip_code" id="zip_code" readonly="readonly"/></td>
                            </tr>
                            <tr>
                                <th scope="row">주소</th>
                                <td colspan="3"><input type="text" class="form-control" name="addr" id="addr" readonly="readonly"/></td>
                            </tr>
                            <tr>
                                <th scope="row">상세주소</th>
                                <td colspan="3"><input type="text" class="form-control" name="addr_detail" id="addr_detail" readonly="readonly"/></td>
                            </tr>
                            <tr>
                                <th scope="row">활성화 여부</th>
                                <td><input type="text" class="form-control" name="use_yn" id="use_yn" readonly="readonly"/></td>
                                <th scope="row">가입날짜</th>
                                <td><input type="text" class="form-control" name="entry_date" id="entry_date" readonly="readonly"/></td>
                            </tr>
                        </tbody>
                    </table>
                    <!-- e : 여기에 내용입력 -->
                    <div class="btn_areaC mt30">
                        <a href="" class="btnType gray" id="btnCloseEmployeeInfo" name="btn"><span>닫기</span></a>
                    </div>
                </dd>
            </dl>
            <a href="" class="closePop"><span class="hidden">닫기</span></a>
        </div>
        <!--// 모달팝업 -->
    </form>
</body>
</html>