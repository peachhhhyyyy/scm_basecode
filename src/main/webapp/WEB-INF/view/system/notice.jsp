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

/* 글 수정 첨부파일 */
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

  });

   /* 공지사항 목록 조회 함수 */
  function selectList(currentPage, serchOptions) {
    //추가코드 시작
    var option = $('#options').val();
    var keyword = $('#keyword').val();
    console.log('옵션:', option);
    console.log('키워드:', keyword)
    var formerDate = $("#datetimepicker1").find("input").val();
    var latterDate = $("#datetimepicker3").find("input").val()
    
    console.log('전:', formerDate, '후', latterDate);
    
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
          // 이 코드 지우기
          var date = $("#datetimepicker1").find("input").val()
          console.log('날짜확인1', date)
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
          console.log('날짜확인3', date)
          $('#datetimepicker4').datetimepicker('minDate', e.date);
        });
        
      });
    // 추가 코드 끝
    
    currentPage = currentPage || 1;

    console.log("currentPage : " + currentPage);

    if (keyword || formerDate || latterDate) {
      console.log('검색어있음, 현재페이지:', currentPage, pageSize)
      
      var param = {
      option : option,
      keyword : keyword,
      formerDate : formerDate,
      latterDate : latterDate,
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

    var resultCallback = function(result) {
      selectListCallBack(result, currentPage);
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

  

  
  /* 공지사항 작성, 수정  모달 활성화 함수 */
  /* 작성, 수정 여부에 따라 첨부파일이 변경되니 주의 html도 분기처리*/
  function fadeInWriteModal() {
    // 모달 초기화
    initWriteModal();
    // 모달 팝업
    gfModalPop("#layer1");
    
  }
  
  /* 공지사항 작성 모달 초기화 */
  function initWriteModal() {
    var title = $('#write_title').val();
    
    if(title) {
      $('#write_title').val('');
      $('#write_content').val('');
      $('#write_auth').val('0');
    }
  }
    
    /* 공지사항 글 작성  함수 */
    function writeNotice() {
      
      // 제목, 내용이 입력되었는지 확인
      var title = $('#write_title').val();
      var content = $('#write_content').val();
      var auth = $('#write_auth').val();
      console.log('타이틀:', title, '내용',content,'권한', auth);
      
      // 날짜 추가
      
      
      // 파일 경로 추가 예정
      
      if(title == '') {
        
        alert('제목을  입력해주세요');
        $('#write_title').focus();
        return false;
        
      } 
      else if(content == '') {
        
        alert('내용을  입력해주세요');
        $('#write_content').focus();
        return false;
      } 
      
      // 콜백 함수
      function resultCallback(result) {
        console.log('글작성 반환값 확인:', result)
        if(result == 1) {
          
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
    
    /* 공지사항 단건 조회 함수 */
    function selectDetail(notice_id, identifier) {
      console.log('???', notice_id)
      console.log('identifier확인:', identifier)
      var param = notice_id;
      //console.log('타입확인.num은 아님:',typeof(param));
      // 숫자로 형변환
      //param = Number(param);
      param = {
          notice_id : notice_id
      }
     
            
      /* 공지사항 단건 조회 콜백 함수  */
      function resultCallback(result) {
        console.log('단건조회 콜백 호출', result);
        // 첨부파일 다운로드 버튼도 있어야 함 -> 이건 처음이니 조사 필요
       // gfModalPop("#layer2");
        
        if(identifier == undefined) {
          // 공지사항  작성 모달
          gfModalPop("#layer2");
          initDetailModal(result);
        
        }
        else {
          console.log('글수정 콜백 호출')
        // 공지사항 수정 모달 
          gfModalPop("#layer1");
        // 이 부분이 변경되어야 함
          initModifyModal(result);
        
        }
       
        
      }
      
      callAjax("/system/detailNotice.do", "post", "json", true, param, resultCallback);
    }
    
    /* 공지사항 단건 조회 모달 초기화,데이터 설정 함수 */
    // fInitFormGrpCod 참고
    function initDetailModal(result) {
      
      if (result == "" || result == null || result == undefined) {
        $("#detail_title").val('');
        $("#detail_date").val('');
        $("#detail_content").val('');
        
      } else {
        $('#detail_notice_id').val(result.notice_id);
        // 모달에 값 설정하기
        $("#detail_title").val(result.title);
        $("#detail_date").text(result.date);
        $("#detail_content").val(result.content);
      }

    }
    
    
    /* 공지사항 단건 조회 모달  */
    function fadeInDetailModal(notice_id) {
      
      // 신규 저장
      if (notice_id == null || notice_id == 0) {
        // Tranjection type 설정
        $("#action").val("I");
        
        // 공지사항 모달 초기화
        initDetailModal();
        
        // 모달 팝업
        gfModalPop("#layer2");
        
      } else {
        // Tranjection type 설정
        $("#action").val("U");
      }
      // 공지사항 단건 조회
       selectDetail(notice_id);
    }

    
    /* 모달 닫기 */
    function fadeOutModal() {
      $('#mask').hide();
      $('.layerPop').hide();
    }
    
    
    /* 공지사항 수정 모달 호출 함수 */
    function modifyNoticeModal() {
      
      // 단건 조회 모달 닫기
      fadeOutModal();
      fadeInWriteModal();
      
      // 글작성 모달 활성화
      // 글작성의 첨부파일이 안 보이게 클래스 변경
      $('#add_file').addClass('display_none');
      $('#writeNoticeButton').addClass('display_none');
      $('#modifyNoticeButton').removeClass('display_none');
      $('#modify_file').removeClass('display_none');
      $('#deleteNoticeButton').removeClass('display_none')
      
      // 해당 글의 notice_id로 글 내용 읽어오기
      // 저장, 삭제, 취소 버튼 3가지
      
      var notice_id = $('#detail_notice_id').val();
      
      // 글 수정을 식별하기 위한 식별 변수
      var identifier = 'm';
      console.log('notice_id는?', notice_id)
      
      // 공지사항 단건 조회
      selectDetail(notice_id, identifier);
      
     
    }
    
    /* 공지사항 수정 모달 */
    function initModifyModal(result) {
      console.log('initModifyModal 호출', result);
      
      if(result) {
        //$('#detail_notice_id').val(result.notice_id);
        // 모달에 값 설정하기
        $("#write_title").val(result.title);
        $("#write_content").text(result.content);
        $("#write_auth").val(result.auth);
      }
      else {
        alert('서버에서 에러가 발생했습니다');
      }
    }
    
    /* 공지사항 수정 함수*/
    function modifyNotice() {
      var notice_id = $('#detail_notice_id').val();
      console.log('수정할 글번호 확인:', notice_id);
      var title =  $("#write_title").val();
      var content =  $("#write_content").val();
      var auth =  $("#write_auth").val();
      
      param = {
          notice_id : notice_id,
          title : title,
          content: content,
          auth: auth
      }
      
      function resultCallback(result) {
        if(result == 1){
          window.location.reload();
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
        
        var notice_id = $('#detail_notice_id').val();
        
        console.log('게시글 번호 확인',notice_id);
        
        var param = {
            notice_id : notice_id
        }
        
        function resultCallback(result) {
          console.log('삭제확인', result)
          console.log('삭제확인', typeof(result))
          if(result == 1) {
            window.location.reload();
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
                  <button type="button" class="btn btn-default" onclick="fadeInWriteModal()">글쓰기</button>
                </c:if>
              </div>
              <h3 class="hidden">풋터 영역</h3>
              <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
          </li>
        </ul>
      </div>
    </div>
    <!-- 공지사항 작성 모달팝업 시작-->
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
                <td colspan="3"><input type="text" class="inputTxt p100" name="write_title" id="write_title" autocomplete="off" /></td>
              </tr>
              <tr>
                <th scope="row">내용</th>
                <td colspan="3"><textarea class="inputTxt p100" name="write_content" id="write_content" autocomplete="off" /></textarea></td>
              </tr>
              <tr id="add_file" class="">
                <th scope="row">첨부파일(글작성)</th>
                <td colspan="3"><input type="file" class="inputTxt p100" name="return_mng_id" id="return_mng_id" /></td>
              </tr>
              <tr id="modify_file" class="display_none">
                <th scope="row">첨부파일(글수정)</th>
                <td colspan="3"><input type="file" class="inputTxt p100" name="return_mng_id" id="return_mng_id" /></td>
              </tr>
              <tr>
                <th scope="row">열람권한</th>
                <td colspan="3">
                  <select id="write_auth">
                    <option value="0">전체</option>
                    <option value="1">고객</option>
                    <option value="2">직원</option>
                </select>
                  <div class="btn-group">
                    <!-- 공지사항 신규 작성 버튼 -->
                    <button class="btn-default btn-sm" id="writeNoticeButton" onclick="writeNotice()">저장</button>
                    <!-- 공지사항 수정글 작성 버튼 -->
                    <button class="display_none btn-default btn-sm" id="modifyNoticeButton" onclick="modifyNotice()">글수정저장</button>
                    <button class="display_none btn-default btn-sm" id="deleteNoticeButton">삭제</button>
                    <button class="btn-default btn-sm" onclick="fadeOutModal()">취소</button>
                  </div></td>
              </tr>
            </tbody>
          </table>
          <!-- e : 여기에 내용입력 -->
        </dd>
      </dl>
      <a href="" class="closePop"><span class="hidden">닫기</span></a>
    </div>
    <!-- 공지사항 작성 모달 끝 -->
    <!-- 공지사항 단건 조회(상세조회)모달 시작 -->
    <div id="layer2" class="layerPop layerType2" style="width: 600px;">
      <dl>
        <dt>
          <strong>공지사항</strong>
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
            <input type="hidden" id="detail_notice_id">
            <tbody>
              <tr>
                <th scope="row">제목</th>
                <td colspan="3"><input type="text" class="inputTxt p100 forbidden-event" name="detail_title" id="detail_title" autocomplete="off" /></td>
              </tr>
              <tr>
                <th scope="row">작성시간</th>
                <td colspan="3"><p id="detail_date"></p></td>
              </tr>
              <tr>
                <th scope="row">내용</th>
                <td colspan="3"><textarea class="inputTxt p100 forbidden-event" name="detail_content" id="detail_content" autocomplete="off" /></textarea></td>
              </tr>
              <tr>
                <th scope="row">첨부파일(다운로드기능 추가해야 함)</th>
                <td colspan="3"><input type="file" class="inputTxt p100" name="return_mng_id" id="return_mng_id" /></td>
              </tr>
              <tr>
                <td colspan="6">
                  <div>
                    <c:if test="${sessionScope.userType eq 'E'}">
                      <button type="button" class="btn-default btn-sm" onclick="modifyNoticeModal()">수정</button>
                      <button type="button" class="btn-default btn-sm" onclick="deleteNotice()">삭제</button>
                    </c:if>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
          <!-- e : 여기에 내용입력 -->
        </dd>
      </dl>
      <a href="" class="closePop"><span class="hidden">닫기</span></a>
    </div>
    <!-- 공지사항 단건 조회(상세조회) 끝 -->
  </form>
</body>
</html>