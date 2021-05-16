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

  /*OnLoad event*/
  $(function() {
    //창고 목록 조회
    fListWarehouse();
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
</script>
</head>
<body>
  <form id="myForm" action="" method="">
    <input type="hidden" id="currentPageWarehouse" value="1"> <input type="hidden" id="currentPageProduct" value="1"> <input type="hidden" id="tmpwarehouse_nm" value=""> <input type="hidden" id="tmpwarehouse_cd" value=""> <input type="hidden" name="action" id="action" value="">
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
                <a href="/system/notice.do" class="btn_set home">메인으로</a> <a class="btn_nav">기준 정보</a> <span class="btn_nav bold">창고 정보</span> <a href="" class="btn_set refresh">새로고침</a>
              </p>
              <p class="conTitle">
                <span>창고 정보</span> <span class="fr"> <a href="javascript:fPopModalWarehouse()" class="btnType blue" name="modal"> <span>신규등록</span>
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
            </div> <!--// content -->
            <h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
          </li>
        </ul>
      </div>
    </div>
  </form>
</body>
</html>