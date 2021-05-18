<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<style>
/* 모달 클릭 방지 */
.forbidden-event {
 pointer-events: none;
}
</style>
<!-- 테스트용 datetpicker -->
<script src="/build/jquery.datetimepicker.full.min.js"></script>
<script type="text/javascript">

  // 페이징 설정
  var pageSize = 5;
  var pageBlock = 5;

  /* OnLoad event */ 
  $(function() {

    // 반품서 목록 조회 호출
    selectList();

  });

   /* 반품서 목록 조회 */
  function selectList(currentPage, serchOptions) {
    //추가코드 시작
    var option = $('#options').val();
    var keyword = $('#keyword').val();
    console.log('옵션:', option);
    console.log('키워드:', keyword)
    var date = $("#datetimepicker1").find("input").val()
    
    // datepicker설정
     $(function() {
        $('#datetimepicker1').datetimepicker({
           //format : 'L',
           format: 'YYYY-MM-DD',
           formatDate: 'YYYY-MM-DD'
        });
        
        $('#datetimepicker2').datetimepicker({
        format : 'L',
        useCurrent : false
        });
        
        $("#datetimepicker1").on("change.datetimepicker", function(e) {
          var date = $("#datetimepicker1").find("input").val()
          console.log('날짜확인', date)
          $('#datetimepicker2').datetimepicker('minDate', e.date);
        });
      });
    // 추가 코드 끝
    
    currentPage = currentPage || 1;

    console.log("currentPage : " + currentPage);

    if (keyword || date) {
      console.log('검색어있음, 현재페이지:', currentPage, pageSize)
      
      var param = {
      option : option,
      keyword : keyword,
      date : date,
      currentPage : currentPage,
      pageSize : pageSize
      }

    } else {
      console.log('검색어 없음')
      
      var param = {
      currentPage : currentPage,
      pageSize : pageSize
      }

    }

    var resultCallback = function(data) {
      selectListCallBack(data, currentPage);
    };

    //Ajax실행 방식
    //callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
    callAjax("/pcs/refund/list.do", "post", "text", true, param, resultCallback);
  }

   /* 반품서 목록 조회 콜백 함수 */
  function selectListCallBack(data, currentPage) {
    
    console.log('반품서 목록:', data);
    
    // 기존 목록 삭제
    $('#refundList').empty();
    
    // 신규 목록 생성
    $("#refundList").append(data);
    
    // 리스트 로우의 총 개수 추출
    var totalCount = $("#totalCount").val();
    console.log('반품서 목록 파라미터 확인:',currentPage, totalCount, pageSize, pageBlock)
    
    // 페이지 네비게이션 생성
    var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSize, pageBlock, 'selectList');
    console.log("paginationHtml : " + paginationHtml);
    $("#pagination").empty().append(paginationHtml);
  
    // 현재 페이지 설정
    $("#currentPageCod").val(currentPage);
  }

  /* 반품서 단건 조회 모달  */
  function fadeInModal(refund_list_no) {
    console.log('모달', refund_list_no)
    console.log('타입확인', typeof (refund_list_no))
    // 신규 저장
    if (refund_list_no === null || refund_list_no === 0) {
      // Tranjection type 설정
      $("#action").val("I");
      
      // 그룹코드 폼 초기화
      initModal();
      
      // 모달 팝업
      gfModalPop("#layer1");
      
    } else {
      // Tranjection type 설정
      $("#action").val("U");
    }
    // 반품서 단건 조회
    selectDetail(refund_list_no);
  }

  /* 반품서 단건 조회 함수 */
  // fSelectGrpCodResult 참고
  function selectDetail(refund_list_no) {
    console.log('단건 조회 호출!!', refund_list_no);
    var param = {
      refund_list_no : refund_list_no
    };

    /* 반품서 단건 조회 콜백 함수 */
    var resultCallback = function(data) {
      console.log('콜백:', data);
      selectDetailCallBack(data);
    };

    //callAjax("/pcs/refund/one.do", "post", "text", true, param, resultCallback);
    callAjax("/pcs/refund/detail.do", "post", "json", true, param, resultCallback);
  }

  // 반품서 단건 조회  데이터 설정 함수 호출 
  // fSelectGrpCodResult참고
  function selectDetailCallBack(data) {
    gfModalPop("#layer1");
    initModal(data);
  }

  /* 반품서 모달 초기화,데이터 설정 함수 */
  // fInitFormGrpCod 참고
  function initModal(object) {

    if (object == "" || object == null || object == undefined) {

      $("#purch_list_no").val("");
      $("#supply_nm").val("");
      $("#supply_cd").val("");
      $("#m_ct_cd").val("");
      $("#m_ct_cd").val("");
      $("#product_cd").val("");
      $("#prod_nm").val("");
      $("#return_qty").val("");
      $("#return_price").val("");
      $("#warehouse_cd").val("");
      $("#addr").val("");
      $("#return_mng_id").val("");
      $("#purch_date").val("");
      $("#desired_delivery_date").val("");

    } else {

      $("#purch_list_no").val(object.purch_list_no);
      $("#supply_nm").val(object.supply_nm);
      $("#supply_cd").val(object.supply_cd);
      $("#m_ct_cd").val(object.m_ct_cd);
      $("#product_cd").val(object.product_cd);
      $("#prod_nm").val(object.prod_nm);
      $("#return_qty").val(object.return_qty);
      $("#return_price").val(object.return_price);
      $("#warehouse_cd").val(object.warehouse_cd);
      $("#addr").val(object.addr);
      $("#return_mng_id").val(object.return_mng_id);
      $("#purch_date").val(object.purch_date);
      $("#desired_delivery_date").val(object.desired_delivery_date);

    }

  }

  /* 반품 완료 처리 */
  function insertReturnDate(purch_list_no) {
    purch_list_no = parseInt(purch_list_no);

    var param = {
      purch_list_no : purch_list_no
    }

    function resultCallback(data) {
      if (data === 1) {
        window.location.reload();
      } else {
        alert('서버에서 에러가 발생했습니다.');

      }
    }
    callAjax("/pcs/refund/returndate.do", "post", "json", true, param, resultCallback);

  }
</script>
</head>
<body>
  <form id="myForm" action="" method="">
    <input type="hidden" id="currentPageCod" value="1"> <input type="hidden" id="currentPageComnDtlCod" value="1"> <input type="hidden" id="tmpGrpCod" value=""> <input type="hidden" id="tmpGrpCodNm" value=""> <input type="hidden" name="action" id="action" value="">
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
                <a href="#" class="btn_set home">메인으로</a> <a href="pcs/pcsOrderingoOrder.do" class="btn_nav">구매</a> <span class="btn_nav bold">반품서</span> <a href="#" class="btn_set refresh">새로고침</a>
              </p>
              <p class="conTitle">
                <span>반품서 목록</span>
              </p>
              <form class="search-container">
                <div class="row">
                  <!-- searchbar -->
                  <div class="col-lg-6">
                    <div class="input-group">
                      <select style="width: 90px; height: 34px;" id="options">
                        <option value="all" selected>전체</option>
                        <option value="category" id="category">업종</option>
                        <option value="product" id="product">제품</option>
                      </select> <input type="text" class="form-control" aria-label="..." id="keyword" autocomplete="off">
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
                    <button type="button" class="btn btn-default" onclick="selectList()">검색</button>
                  </div>
                  <!-- // button -->
                </div>
                <!-- /.row -->
              </form>
              <div class="divComGrpCodList">
                <table class="col">
                  <caption>caption</caption>
                  <colgroup>
                    <col width="*%">
                    <col width="*%">
                    <col width="*%">
                    <col width="*%">
                    <col width="*%">
                    <col width="*%">
                    <col width="*%">
                    <col width="*">
                    <col width="*%">
                  </colgroup>
                  <thead>
                    <tr>
                      <th scope="col">반품번호</th>
                      <th scope="col">반품코드</th>
                      <th scope="col">회사명</th>
                      <th scope="col">회사코드</th>
                      <th scope="col">반품제품</th>
                      <th scope="col">브랜드</th>
                      <th scope="col">반품수량</th>
                      <th scope="col">반품날짜</th>
                      <th scope="col">반품완료</th>
                    </tr>
                  </thead>
                  <tbody id="refundList"></tbody>
                </table>
              </div>
              <div class="paging_area" id="pagination"></div>
              <h3 class="hidden">풋터 영역</h3>
              <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
          </li>
        </ul>
      </div>
    </div>
    <!-- 모달팝업 -->
    <div id="layer1" class="layerPop layerType2" style="width: 600px;">
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
            <tbody class="forbidden-event">
              <tr>
                <th scope="row">반품번호</th>
                <td><input type="text" class="inputTxt p100" name="purch_list_no" id="purch_list_no" /></td>
                <th scope="row">회사명 </th>
                <td><input type="text" class="inputTxt p100" name="supply_nm" id="supply_nm" /></td>
              </tr>
              <tr>
                <th scope="row">회사코드</th>
                <td><input type="text" class="inputTxt p100" name="supply_cd" id="supply_cd" /></td>
                <th scope="row">브랜드</th>
                <td><input type="text" class="inputTxt p100" name="m_ct_cd" id="m_ct_cd" /></td>
              </tr>
              <tr>
                <th scope="row">제품번호</th>
                <td><input type="text" class="inputTxt p100" name="product_cd" id="product_cd" style="pointer-events: none" /></td>
                <th scope="row">제품명</th>
                <td><input type="text" class="inputTxt p100" name="prod_nm" id="prod_nm" /></td>
              </tr>
              <tr>
                <th scope="row">반품수량</th>
                <td><input value="" type="text" class="inputTxt p100" name="return_qty" id="return_qty" /></td>
                <th scope="row">금액</th>
                <td><input type="text" class="inputTxt p100" name="return_price" id="return_price" /></td>
              </tr>
              <tr>
                <th scope="row">창고 코드</th>
                <td colspan="3"><input type="text" class="inputTxt p100" name="warehouse_cd" id="warehouse_cd" /></td>
              </tr>
              <tr>
                <th scope="row">창고 주소</th>
                <td colspan="3"><input type="text" class="inputTxt p100" name="addr" id="addr" /></td>
              </tr>
              <tr>
                <th scope="row">담당자</th>
                <td colspan="3"><input type="text" class="inputTxt p100" name="return_mng_id" id="return_mng_id" /></td>
              </tr>
              <tr>
                <th scope="row">발주날짜</th>
                <td><input type="text" class="inputTxt p100" name="purch_date" id="purch_date" /></td>
                <th scope="row">배송희망날짜</th>
                <td><input type="text" class="inputTxt p100" name="desired_delivery_date" id="desired_delivery_date" /></td>
              </tr>
            </tbody>
          </table>
          <!-- e : 여기에 내용입력 -->
        </dd>
      </dl>
      <a href="" class="closePop"><span class="hidden">닫기</span></a>
    </div>
  </form>
</body>
</html>