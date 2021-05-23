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

/* 모달 전환 */
.display_none {
  display: none;
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
    
    //datepicker설정
    // formerDate datepicker
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
      $('#datetimepicker2').datetimepicker('minDate', e.date);
    });
    
    
    // latterDate datepicker
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
      $('#datetimepicker4').datetimepicker('minDate', e.date);
    });
    
    // 공지사항 제목 글자 제한
    $('#notice_title').keyup(function(e){
      
      var limit = 100;
      var count = $(this).val().length;
      
      if(count > limit) {
        
        alert('제목은 100자 이하로 작성해 주세요');
        $(this).val($(this).val().substring(0,limit));
        return false;
        
      }
      
    });
    
    // 공지사항 내용 글자 제한
    $("#notice_content").keyup(function(e) {
      
      var limit = 1000;
      var count =  $(this).val().length;
      
      if(count > limit) {
        
        alert('내용은 1000자 이하로 작성해 주세요');
        $(this).val($(this).val().substring(0,limit));
        return false;
        
      }
      
    });

    // 공지사항 검색 버튼 이벤트
    $('#search_button').on('click', function(){
      
      selectList();
      
    } );
    
    // 공지사항 작성 모달 이벤트
    $('#write_modal_button').click(function(){
      
      var identifier = 'w';
      fadeInModal(identifier);
      
    });
    
    // 공지사항 작성 버튼 이벤트
    $('#write_button').click(function() {
      
      writeNotice();
      
    });
    
    // 모달 닫기 버튼 이벤트
    $('#close_button').click(function() {
      
      gfCloseModal();
      
    })
    
    // 공지사항 수정 모달 버튼 이벤트
     $('#modify_modal_button').click(function() {
       
       var identifier = 'm';
       fadeInModal(identifier);
       
     });
    
    // 공지사항 수정 버튼 이벤트
    $('#modify_button').click(function() {
      
      modifyNotice();
      
    });
     
    // 공지사항 삭제 버튼 이벤트
    $('#delete_button').click(function() {
      
      deleteNotice();
      
    })
    
    // onload 끝
  });
  
 

   /* 공지사항 목록 조회 함수 */
  function selectList(currentPage, serchOptions) {
     
    var option = $('#options').val();
    var keyword = $('#keyword').val();
    var formerDate = $("#datetimepicker1").find("input").val();
    var latterDate = $("#datetimepicker3").find("input").val();
    
    currentPage = currentPage || 1;

    console.log("currentPage : " + currentPage);
    

    if (keyword || formerDate || latterDate) {
      
      var param = {
      option : option,
      keyword : keyword,
      formerDate : formerDate,
      latterDate : latterDate,
      currentPage : currentPage,
      pageSize : pageSize
      }

    } else {
      
      var param = {
      currentPage : currentPage,
      pageSize : pageSize
      }

    }

    var resultCallback = function(result) {
      selectListCallBack(result, currentPage);
    };

    //Ajax실행 방식
    //callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
    callAjax("/system/notice.do", "post", "text", true, param, resultCallback);
  }

   /* 공지사항 목록 조회 콜백 함수 */
  function selectListCallBack(result, currentPage) {
    
    // 기존 목록 삭제
    $('#noticeList').empty();
    
    // 신규 목록 생성
    $("#noticeList").append(result);
    
    // 리스트 로우의 총 개수 추출
    var totalCount = $("#totalCount").val();
    
    // 페이지 네비게이션 생성
    var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSize, pageBlock, 'selectList');
    console.log("paginationHtml : " + paginationHtml);
    $("#pagination").empty().append(paginationHtml);
  
    // 현재 페이지 설정
    $("#currentPageCod").val(currentPage);
  }

  
  /* 공지사항 작성, 수정  모달 활성화 함수 */
  /* 작성, 수정 여부에 따라 첨부파일이 변경되니 주의  */
  function fadeInWriteModal() {
    
    swapModal();
    // 모달 초기화
    initWriteModal();
    // 모달 팝업
    gfModalPop("#layer1");
    
  }
  
    /* 공지사항 글 작성  함수 */
    function writeNotice() {
      
      // 제목, 내용이 입력되었는지 확인
      var title = $('#notice_title').val();
      var content = $('#notice_content').val();
      var auth = $('#notice_auth').val();
      
      //*** 파일 추가 ***
      var uploadFile = $('#file-form')[0];
      var fileData = new FormData(uploadFile);
      
      // 
      fileData.append("empty", "empty");
      
      console.log('파일폼확인', uploadFile)
      console.log('파일확인', fileData)
      
      
      
      if(title == '') {
        
        alert('제목을  입력해주세요');
        $('#notice_title').focus();
        return false;
        
      } 
      else if(content == '') {
        
        alert('내용을  입력해주세요');
        $('#notice_content').focus();
        return false;
      } 
      
      var param = {
          
          title: title,
          content: content,
          auth: auth 
          
      }
      
      
      // 콜백 함수
      function resultCallback(result) {
        
        if(result == 1) {
          
         // fadeOutModal();
          gfCloseModal();
          selectList();
          
        } 
        else {
          alert('서버에서 에러가 발생했습니다');
        }
      }
      
      // 파일 업로드 AJAX호출(fileUploadCallback작성 해야 함)
      
      
      // AJAX호출
      callAjax("/system/writeNotice.do", "post", "json", true, param, resultCallback);
    };
    
    /* 공지사항 단건 조회 함수 */
    function selectDetail(notice_id, identifier) {
      
      var param = notice_id;
      
      param = {
          notice_id : notice_id
      }
     
            
      /* 공지사항 단건 조회 콜백 함수  */
      function resultCallback(result) {
        
        // 첨부파일 다운로드 버튼도 있어야 함 
       // gfModalPop("#layer2");
        
          // 공지사항  작성 모달
          gfModalPop("#layer1");
          initModal(identifier, result);
        
      }
      
      callAjax("/system/detailNotice.do", "post", "json", true, param, resultCallback);
    }
    
    
    /* 공지사항 작성 ,공지사항 수정 모달 변경 */
    function swapModal(identifier) {
      
      // 공지사항 작성
     if(identifier == 'w') {
       
       $('#dt_write').show();
       $('#dt_notice').hide();
       $('.auth_block').show();
       
       $('#write_button').show();
       $('#modify_button').hide();
       $('#modify_modal_button').hide();
       $('#delete_button').hide();
       
       $('#add_file').show();
       $('#datice_date_block').hide();
       $('#notice_title').removeClass('forbidden-event');
       $('#notice_content').removeClass('forbidden-event');
       $('#modify_file').hide();
       
       
     }
     // 공지사항 단건 조회
     else if(identifier == 'r') {
       
       $('#add_file').hide();
       $('#dt_write').hide();
       $('#dt_notice').show();
       $('.auth_block').hide();
       
       $('#write_button').hide();
       $('#modify_button').hide();
       $('#modify_modal_button').show();
       $('#delete_button').show();
       
       $('#datice_date_block').show();
       $('#notice_title').addClass('forbidden-event');
       $('#notice_content').addClass('forbidden-event');
       
       $('#modify_file').hide();
       
     }
     // 공지사항 수정
     else if(identifier == 'm'){
       
       $('#add_file').hide();
       $('#dt_write').show();
       $('#dt_notice').hide();
       $('.auth_block').show();
       
       $('#write_button').hide();
       $('#modify_button').show();
       $('#modify_modal_button').hide();
       $('#delete_button').show();
       
       $('#notice_title').removeClass('forbidden-event');
       $('#datice_date_block').hide();
       $('#notice_content').removeClass('forbidden-event');
       $('#modify_button').show();
       $('#modify_file').show();
     }
      
    }
        
    
    /* 공지사항 수정 모달 */
    function initModifyModal(result) {
      
      if(result) {
        
        // 모달에 값 설정하기
        $("#notice_title").val(result.title);
        $("#notice_content").val(result.content);
        $("#notice_auth").val(result.auth);
      }
      else {
        alert('서버에서 에러가 발생했습니다');
      }
    }
    
    /* 공지사항 수정 함수*/
    function modifyNotice() {
      
      var notice_id = $('#notice_id').val();
      var title =  $("#notice_title").val();
      var content =  $("#notice_content").val();
      var auth =  $("#notice_auth").val();
      
      param = {
          notice_id : notice_id,
          title : title,
          content: content,
          auth: auth
      }
      
      function resultCallback(result) {
        if(result == 1){
          
          gfCloseModal();
          selectList();
        } 
        else {
          alert('서버에서 에러가 발생했습니다.')
        }
      }
      
      callAjax("/system/modifyNotice.do", "post", "text", true, param, resultCallback);
      
    }
    
    /* 공지사항 삭제 함수 */
    function deleteNotice() {
      
      var isDelete = confirm('정말 삭제하시겠습니까?');
      
      // 삭제
      if(isDelete) {
        
        var notice_id = $('#notice_id').val();
        
        var param = {
            notice_id : notice_id
        }
        
        function resultCallback(result) {
          
          if(result == 1) {
            
            gfCloseModal();
            selectList();
           
          } 
          else {
            alert('서버에서 에러가 발생했습니다');
          }
        };
        
        callAjax("/system/deleteNotice.do", "post", "text", true, param, resultCallback);
        
      }
      else { 
        return false;
      }
    }
    
    // fadeInModal
    function fadeInModal(identifier, notice_id) {
      
      if(identifier == 'w') {
        
        // 모달 변경
        swapModal(identifier);
        // 모달 초기화 & 값변경
        initModal(identifier);
        // 모달 팝업
        gfModalPop("#layer1");
        
      }
      else if(identifier == 'r') {
        
          swapModal(identifier);
          
          // 공지사항 모달 초기화
          initModal(identifier);
          
          // 공지사항 단건 조회
         selectDetail(notice_id, identifier);
        
      }
      else if(identifier == 'm') {
        
        // 수정은 단건 조회에서 불러온 데이터를 그대로 가지고
        // 모달만 변경시키면 된다.
        swapModal(identifier);
        
      }
    }
    
    // initModal
    // 모달값 초기화 & 값설정
    function initModal(identifier, result) {
      var title =  $('#notice_title').val();
      
      if(identifier == 'w') {
        
        $('#notice_title').val('');
        $('#notice_content').val('');
        // 파일 초기화 추가
        $('#notice_auth').val('0');
        
      }
      else if(identifier == 'r') {
        
        if(result) {
          
          $('#notice_id').val(result.notice_id);
          $('#notice_title').val(result.title);
          $('#notice_date').text(result.date);
          $('#notice_content').val(result.content);
          $('#notice_auth').val(result.auth);
          
        }
        else{
          $('#notice_id').val('');
          $('#notice_title').val('');
          $('#notice_date').text('');
          $('#notice_content').val('');
          $('#notice_auth').val('0');
        }
      }
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
                <a href="#" class="btn_set home">메인으로</a><span class="btn_nav bold">공지사항</span> <a href="javascript:window.location.reload();" class="btn_set refresh">새로고침</a>
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
                        <option value="title" id="title">제목</option>
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
                    <!--  <button type="button" class="btn btn-default" onclick="selectList()">검색</button>-->
                    <button type="button" class="btn btn-default" id="search_button">검색</button>
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
                  <button type="button" class="btn btn-default" id="write_modal_button">글쓰기</button>
                </c:if>
              </div>
              <h3 class="hidden">풋터 영역</h3>
              <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
          </li>
        </ul>
      </div>
    </div>
    <!-- 공지사항 모달 시작-->
    <div id="layer1" class="layerPop layerType2" style="width: 600px;">
      <dl>
        <dt id="dt_write">
          <strong>글쓰기</strong>
        </dt>
        <dt id="dt_notice">
          <strong>공지사항</strong>
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
            <input type="hidden" id="notice_id">
            <tbody>
              <tr>
                <th scope="row">제목</th>
                <td colspan="3"><input type="text" class="inputTxt p100" name="notice_title" id="notice_title" autocomplete="off" /></td>
              </tr>
              <tr id="datice_date_block">
                <th scope="row">작성시간</th>
                <td colspan="3"><p id="notice_date"></p></td>
              </tr>
              <tr>
                <th scope="row">내용</th>
                <td colspan="3"><textarea class="inputTxt p100" name="notice_content" id="notice_content" /></textarea></td>
              </tr>
               <tr id="add_file" class="">
                 <th scope="row">첨부파일(글작성)</th>
                   <td colspan="3"><input type="file" class="inputTxt p100" accept="image/*" /></td>
               </tr>
               <tr id="modify_file" class="display_none">
                  <th scope="row">첨부파일(글수정)</th>
                  <td colspan="3"><input type="file" class="inputTxt p100" accept="image/*"/></td>
               </tr>
              <tr>
                <th scope="row" class="auth_block">열람권한</th>
                <td colspan="3">
                  <select class="auth_block" id="notice_auth">
                    <option value="0">전체</option>
                    <option value="1">고객</option>
                    <option value="2">직원</option>
                </select>
                  <div class="btn-group">
                    <!-- 공지사항 신규 작성 버튼 -->
                    <button class="btn-default btn-sm" id="write_button">저장</button>
                    <!-- 공지사항 수정글 작성 버튼 -->
                    <button class="btn-default btn-sm" id="modify_button">글수정저장</button>
                    <button class="btn-default btn-sm" id="modify_modal_button">수정</button>
                    <button class="btn-default btn-sm" id="delete_button">삭제</button>
                    <button class="btn-default btn-sm" id="close_button">취소</button>
                  </div></td>
              </tr>
            </tbody>
          </table>
        </dd>
      </dl>
      <a href="" class="closePop"><span class="hidden">닫기</span></a>
    </div>
    <!-- 공지사항 모달 끝 -->
  </form>
</body>
</html>