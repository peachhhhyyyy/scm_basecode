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

/* 모달 닫기 */
#close-modal{
  display:"none"
  }
</style>
<script type="text/javascript">

  // 페이징 설정
  var pageSize = 5;
  var pageBlock = 5;

  /* OnLoad event */ 
  $(function() {

    // 공지사항 목록 조회
    selectList();

  });

   /* 공지사항 목록 조회 함수 */
  function selectList(currentPage, serchOptions) {
    //추가코드 시작
    var option = $('#options').val();
    var keyword = $('#keyword').val();
    console.log('옵션:', option);
    console.log('키워드:', keyword)
    var date = $("#datetimepicker1").find("input").val()
    
    // datepicker설정
     $(function() {
       //
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
        
        $("#datetimepicker1").on("change.datetimepicker", function(e) {
          var date = $("#datetimepicker1").find("input").val()
          console.log('날짜확인', date)
          $('#datetimepicker2').datetimepicker('minDate', e.date);
        });
        
        //
        $('#datetimepicker3').datetimepicker({
           //format : 'L',
           format: 'YYYY-MM-DD',
           formatDate: 'YYYY-MM-DD'
        });
        
        $('#datetimepicker4').datetimepicker({
        format : 'L',
        useCurrent : false
        });
        
        $("#datetimepicker3").on("change.datetimepicker", function(e) {
          var date = $("#datetimepicker3").find("input").val()
          console.log('날짜확인', date)
          $('#datetimepicker4').datetimepicker('minDate', e.date);
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
    callAjax("/system/notice.do", "post", "text", true, param, resultCallback);
  }

   /* 공지사항 목록 조회 콜백 함수 */
  function selectListCallBack(data, currentPage) {
    
    console.log('공지사항 목록:', data);
    
    // 기존 목록 삭제
    $('#noticeList').empty();
    
    // 신규 목록 생성
    $("#noticeList").append(data);
    
    // 리스트 로우의 총 개수 추출
    var totalCount = $("#totalCount").val();
    console.log("공지사항 전체 건수", totalCount)
    console.log('공지사항 목록 파라미터 확인:',currentPage, totalCount, pageSize, pageBlock)
    
    // 페이지 네비게이션 생성
    var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSize, pageBlock, 'selectList');
    console.log("paginationHtml : " + paginationHtml);
    $("#pagination").empty().append(paginationHtml);
  
    // 현재 페이지 설정
    $("#currentPageCod").val(currentPage);
  }

  /* 공지사항 단건 조회 모달  */
  function fadeInModal(refund_list_no) {
    
    // 신규 저장
    if (refund_list_no === null || refund_list_no === 0) {
      // Tranjection type 설정
      $("#action").val("I");
      
      // 공지사항 모달 초기화
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
  
  /* 공지사항 작성  모달 활성화 함수 */
  function fadeInModal() {
    // 그룹코드 폼 초기화
    initModal();
    
    // 모달 팝업
    gfModalPop("#layer1");
    
  }
    
    /* 공지사항 글 작성  함수 */
    function writeNotice() {
      
      // 제목, 내용이 입력되었는지 확인
      var title = $('#title').val();
      var content = $('#content').val();
      var auth = $('#auth').val();
      console.log('타이틀:', title, '내용',content,'권한', auth);
      
      // 날짜 추가
      // var date = moment();
     // date = date.format('YYYY-MM-DD');
      
     // console.log('글작성일확인:', date);
      
      // 파일 경로 추가 예정
      
      if(title === '') {
        
        alert('제목을  입력해주세요');
        $('#title').focus();
        return false;
        
      } 
      else if(content === '') {
        
        alert('내용을  입력해주세요');
        $('#content').focus();
        return false;
      } 
      
      // 콜백 함수
      function resultCallback(data) {
        console.log('글작성 반환값 확인:', data)
        if(data === 1) {
          
          window.location.reload();
        } 
        else {
          alert('서버에서 에러가 발생했습니다');
        }
      }
      
      var param = {
          
          title: title,
          content: content,
          auth: auth 
          
      }
      
      // AJAX호출
      callAjax("/system/writeNotice.do", "post", "json", true, param, resultCallback);
    };
    
    /* 모달 닫기 */
    function fadeOutModal() {
      $('#mask').hide();
      $('.layerPop').hide();
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
                <span>공지사항</span>
              </p>
              <form class="search-container">
                <div class="row">
                  <!-- searchbar -->
                  <div class="col-lg-6">
                    <div class="input-group">
                      <select style="width: 90px; height: 34px;" id="options">
                        <option value="all" selected>제목+내용</option>
                        <option value="category" id="category">제목</option>
                      </select> <input type="text" class="form-control" aria-label="..." id="keyword" autocomplete="off">
                    </div>
                  </div>
                  <!-- // searchbar -->
                  <!-- datepicker -->
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
                  <span class="divider">~</span>
                  <div class='col-md-3 col-xs-4'>
                    <div class="form-group">
                      <div class="input-group date" id="datetimepicker3" data-target-input="nearest">
                        <input type="text" class="form-control datetimepicker-input" data-target="#datetimepicker3" value="">
                        <div class="input-group-append" data-target="#datetimepicker3" data-toggle="datetimepicker">
                          <div class="input-group-text">
                            <i class="fa fa-calendar"></i>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <!-- // datepicker -->
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
                    <col width="10%">
                    <col width="50%">
                    <col width="30%">
                    <col width="20%">
                  </colgroup>
                  <thead>
                    <tr>
                      <th scope="col">글번호</th>
                      <th scope="col">제목</th>
                      <th scope="col">작성일</th>
                      <th scope="col">조회수</th>
                    </tr>
                  </thead>
                  <tbody id="noticeList"></tbody>
                </table>
              </div>
              <div class="paging_area" id="pagination"></div>
              <div class="btn-wrap">
                  <c:if test="${sessionScope.userType eq 'E'}">
                    <button type="button" class="btn btn-default">수정</button>
                    <button type="button" class="btn btn-default" onclick="fadeInModal()">글쓰기</button>
                  </c:if>
              </div>
              <h3 class="hidden">풋터 영역</h3>
              <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
          </li>
        </ul>
      </div>
    </div>
    <!-- 글쓰기 모달팝업 -->
    <div id="layer1" class="layerPop layerType2" style="width: 600px;">
      <dl>
        <dt>
          <strong>글쓰기</strong>
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
                <th scope="row">제목</th>
                <td colspan="3"><input type="text" class="inputTxt p100" name="title" id="title" autocomplete="off"/></td>
              </tr>
              <tr>
                <th scope="row">내용</th>
                <td colspan="3"><textarea class="inputTxt p100" name="content" id="content" autocomplete="off"/></textarea></td>
              </tr>
              <tr>
                <th scope="row">첨부파일</th>
                <td colspan="3"><input type="file" class="inputTxt p100" name="return_mng_id" id="return_mng_id" /></td>
              </tr>
              <tr>
                <th scope="row">열람권한</th>
                <td colspan="3">
                <select id="auth">
                    <option value="0">전체</option>
                    <option value="1">고객</option>
                    <option value="2
                    ">직원</option>
                </select>
                  <div class="btn-group" >
                    <button class="btn-default  btn-sm" onclick="writeNotice()">저장</button>
                    <button class="btn-default  btn-sm">삭제</button>
                    <button class="btn-default  btn-sm" onclick="fadeOutModal()">취소</button>
                  </div></td>
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