<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
   <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge" />
      <title>반품계획</title>
      <jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
      <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
      <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
      <script src="${CTX_PATH}/js/summernote/summernote-ko-KR.js"></script>
      <script type="text/javascript">
      	var pageSizeinf = 5;
  		var pageBlockSizeinquiry = 10;
  	
         $(document).ready(function(){
         	fReturnList();
         })
         
         //반품리스트 조회
         function fReturnList(currentPage) {
			
			// 상태와 날짜 변수
			/* state = $('#state').val()
			startDate = $('#startDate').val()
			endDate = $('#endDate').val() */
	
			currentPage = currentPage || 1;
	
			console.log("currentPage : " + currentPage);
	
			var param = {
				currentPage : currentPage,
				pageSize : pageSizeinf
			}
	
			var resultCallback = function(data) {
				fReturnListResult(data, currentPage);
			};
	
			//Ajax실행 방식
			//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
			//html로 받을거라 text
			callAjax("/dlv/returnList.do", "post", "text", true, param, resultCallback);
		}

         function fReturnListResult(data, currentPage) {

        	    //alert(data);
        	    console.log(data);

        	    // 기존 목록 삭제
        	    $('#returnList').empty();

        	    // 신규 목록 생성
        	    $("#returnList").append(data);

        	    // 총 개수 추출
        	    var totalCntComnGrpCod = $("#totalCntComnGrpCod").val();

        	    // 페이지 네비게이션 생성
        	    //var paginationHtml = getPaginationHtml(currentPage, totalCntComnGrpCod, pageSizeComnGrpCod, pageBlockSizeComnGrpCod, 'fListComnGrpCod');
        	    //console.log("paginationHtml : " + paginationHtml);
        	    //alert(paginationHtml);
        	    //$("#comnGrpCodPagination").empty().append(paginationHtml);

        	    // 현재 페이지 설정
        	    //$("#currentPageComnGrpCod").val(currentPage);
        	  }

        
         
         //관리자 공지사항 리스트 데이터 받아오기
         function fAdmList(currentPage) {
         	
         	var adm_type = $("#adm_type").val();
         	var adm_key = $("#adm_key").val();
         	
         	currentPage = currentPage || 1;
         
         	var param = {
         		currentPage : currentPage,
         		pageSize : pageSize,
         		adm_type : adm_type,
         		adm_key : adm_key
         	}
         
         	var resultCallback = function(data) {
         		fAdmResult(data, currentPage);
         	};
         
         	//Ajax실행 방식
         	//callAjax("Controller Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
         	// json으로 보내서 오류가 났음 , -> text
         	callAjax("/div/returnmain.do", "post", "text", true, param,resultCallback);
         }
         
         //관리자 공지사항 리스트 데이터 출력
         function fAdmResult(data, currentPage) {
         
         	console.log("값가져오ㅏ ㅇㅅㅇ" + data);
         	
         	// 기존 목록 삭제
         	$('#admNoticeList').empty();
         	//$('#listLec').find("tr").remove() 
         
         	var $data = $($(data).html());
         
         	// 신규 목록 생성
         	var $admNoticeList = $data.find("#admNoticeList");
         	$("#admNoticeList").append($admNoticeList.children());
         
         	// 총 개수 추출
         	var $admNoticeCnt = $data.find("#admNoticeCnt");
         	var admNoticeCnt = $admNoticeCnt.text();
         
         	// 페이지 네비게이션 생성
         	var paginationHtml = getPaginationHtml(currentPage, admNoticeCnt,
         			pageSize, pageBlockSize, 'fAdmList');
         	
         	//alert(paginationHtml);
         	$("#admPagination").empty().append(paginationHtml);
         
         	// 현재 페이지 설정
         	$("#admCurrentPage").val(currentPage);
         
         }
         
         //강사 공지사항 리스트 데이터 받아오기
         function fTutList(currentPage) {
         	var tut_type = $("#tut_type").val();
         	var tut_key = $("#tut_key").val();
         
         	
         	currentPage = currentPage || 1;
         
         	var param = {
         		currentPage : currentPage,
         		pageSize : pageSize,
         		tut_type : tut_type,
         		tut_key : tut_key
         	}
         
         	var resultCallback = function(data) {
         		fTutResult(data, currentPage);
         	};
         
         	//Ajax실행 방식
         	//callAjax("Controller Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
         	// json으로 보내서 오류가 났음 , -> text
         	callAjax("/notice/tutNoticeList.do", "post", "text", true, param,resultCallback);
         }
         
         //강사 공지사항 리스트 데이터 출력
         function fTutResult(data, currentPage) {
         
         	//alert(data);
         	console.log("gdgd" + data);
         
         	// 기존 목록 삭제
         	$('#tutNoticeList').empty();
         	//$('#listLec').find("tr").remove() 
         
         	var $data = $($(data).html());
         
         	// 신규 목록 생성
         	var $tutNoticeList = $data.find("#tutNoticeList");
         	$("#tutNoticeList").append($tutNoticeList.children());
         
         	// 총 개수 추출
         	var $tutNoticeCnt = $data.find("#tutNoticeCnt");
         	var tutNoticeCnt = $tutNoticeCnt.text();
         
         	// 페이지 네비게이션 생성
         	var paginationHtml = getPaginationHtml(currentPage, tutNoticeCnt,
         			pageSize, pageBlockSize, 'fTutList');
         	
         	//alert(paginationHtml);
         	$("#tutPagination").empty().append(paginationHtml);
         
         	// 현재 페이지 설정
         	$("#tutCurrentPage").val(currentPage);
         
         }
         
         //관리자 공지사항 상세조회 모달창 띄우기
         function fPopModalAdm( notice_id ) {
         	   
         	
               var param = {
            		   notice_id : notice_id
                   }
               var resultCallback = function(data) {
                 $('#layer1').empty().append(data);
                 gfModalPop("#layer1");
               };
               callAjax("/notice/admDetail.do", "post", "text", true, param, resultCallback);
            }
         
         //강사 공지사항 상세조회 모달창 띄우기
         function fPopModalTut( notice_id ) {
         	   
         	
                var param = {
             		   notice_id : notice_id
                    }
                var resultCallback = function(data) {
         
                  $('#layer1').empty().append(data);
                  gfModalPop("#layer1");
                };
                callAjax("/notice/tutDetail.do", "post", "text", true, param, resultCallback);
            }
         
         //공지사항 작성하기
         function fWrite(){
            /*  $("#notice_tit").val("");
             $("#notice_con").val(""); */
             
          	var notice_tit = $("#notice_tit").val();
         	var notice_con = $("#notice_con").val();   
         	notice_con = notice_con.replace(/(?:\r\n|\r|\n)/g, '<br>');
         	
         
         	if(notice_tit != null && notice_con != null && notice_con != '' && notice_tit != ''){
                 var param = {
                		  notice_tit : notice_tit
                		 ,notice_con : notice_con
                 	}
                
                 var resultCallback = function(param) {
                	 fModalResult(param);
                 	};
                 
                 callAjax("/notice/noticeWrite.do", "post", "json", true, param, resultCallback);
         	}
         
         	else{alert("작성이 완료되지 않았습니다.")}
              }
           
         
         //공지사항 삭제하기 
         function fDelete(notice_id){
         	
         	var param = {
         		notice_id : notice_id
         		}
         	   
         	var resultCallback = function(data) {
         		fModalResult(data);
         	   }
         	
         	callAjax("/notice/noticeDelete.do", "post", "json", true, param, resultCallback);
            }
         
         
         function fUpdateResult(notice_id) {
         
         	var tit = $("#re_tit").val();
         	var con = $("#re_con").val();
         	con = con.replace(/(?:\r\n|\r|\n)/g, '<br>');
         	if (tit != null && con != null && con != '' && tit != '') {
         		var param = {
         			notice_id : notice_id,
         			notice_tit : tit,
         			notice_con : con
         		}
         		var resultCallback = function(data) {
         			fModalResult(data);
         		}
         		callAjax("/notice/noticeUpdate.do", "post", "json", true, param,
         				resultCallback);
         	}
         
         	else {
         		alert("작성이 완료되지 않았습니다.");
         	}
         }
         
         //모달 결과 
         function fModalResult(data) {
         
         	if (data.result == "게시글 작성을 성공하였습니다." || data.result == "게시글을 삭제하였습니다."
         			|| data.result == "게시글을 수정하였습니다.") {
         
         		// 모달 팝업
         		gfCloseModal();
         		alert(data.result);
         		fAdmList();
         		fTutList();
         
         		$("#notice_tit").val("");
         		$("#notice_con").val("");
         
         	} else {
         		gfCloseModal();
         		alert(data.result);
         	}
         
         }
      </script>
   </head>
   <body>
      <form id="myForm">
         <div id="mask"></div>
         <div id="wrap_area">
            <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
            <div id="container">
               <ul>
                  <li class="lnb">
                     <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
                  </li>
                  <li class="contents">
                     <h3 class="hidden">contents 영역</h3>
                     <div class="content">
                        <p class="Location">
                           <a href="" class="btn_set home">메인으로</a> 
                           <a href="" class="btn_nav">학습지원</a> <span class="btn_nav bold">공지사항</span>
                           <a href="" class="btn_set refresh">새로고침</a>
                        </p>
                        <!-- 반품 리스트 조회  -->
                        <form name="returnList" id="returnList" method="post" action="returnList.do">
                        <div class="divComGrpCodList">
                           <p class="conTitle">
                              <span>반품계획</span>
                              <span class="fr">
                                 <span>
                                    <select id="adm_type" style="width: 100px;">
                                       <option value="all" selected="selected">전체</option>
                                       <option value="title">승인대기</option>
                                       <option value="content">반품 진행 중</option>
                                       <option value="title">승인대기</option>
                                       <option value="content">반품완료</option>
                                    </select>
                                 </span>
                                 <input type="date" id="theday" min="2020-01-01" max="2020-12-31"  style="width: 200px; height: 28px;" 
                                    onKeyDown="if(event.keyCode == 13) javascript:fAdmList()">
                                 <span>~</span>
                                 <input type="date" id="theday" min="2020-01-01" max="2020-12-31"  style="width: 200px; height: 28px;" 
                                    onKeyDown="if(event.keyCode == 13) javascript:fAdmList()">
                                 <a class="btnType blue" href="javascript:fReturnList()" ><span id="searchEnter">검색</span></a>
                                 <c:if test="${typeCheck.user_type eq 'C'}">
                                    <a href="javascript:gfModalPop('#layer2');" class="btnType blue" id="submitBtn"><span id="">작성</span></a>
                                 </c:if>
                              </span>
                           </p>
                            
                           <table class="col">
                              <caption>caption</caption>
                              <colgroup>
                                 <col width="10%">
                                 <col width="15%">
                                 <col width="10%">
                                 <col width="15%">
                                 <col width="10%">
                              </colgroup>
                              <thead>
                                 <tr>
                                    <th scope="col">반품번호</th>
                                    <th scope="col">회사명</th>
                                    <th scope="col">회사코드</th>
                                    <th scope="col">품목명</th>
                                    <th scope="col">제품명</th>
                                    <th scope="col">수량</th>
                                    <th scope="col">금액</th>
                                    <th scope="col">반품 창고명</th>
                                    <th scope="col">반품 접수일자</th>
                                    <th scope="col">상태</th>
                                 </tr>
                              </thead>
                              <tbody id="returnList">
                              </tbody>
                           </table>
                           </form>
                        </div>
                        <!-- 반품 리스트 조회  -->
                        <br><br>
                        <!-- 상세페이지 조회 -->
                        <div class="divComGrpCodList">
                           <p class="conTitle">               
                              <span>상세페이지</span>
                           </p>
                           <!--주문내용  -->
                           <table class="col">
                              <caption>caption</caption>
                              <colgroup>
                                 <col width="10%">
                                 <col width="15%">
                                 <col width="10%">
                                 <col width="15%">
                                 <col width="10%">
                              </colgroup>
                              <thead>
                                 <tr>
                                    <th scope="col">주문코드</th>
                                    <th scope="col">제목명</th>
                                    <th scope="col">배송코드</th>
                                    <th scope="col">수량</th>
                                    <th scope="col">품목명</th>
                                 </tr>
                              </thead>
                              <tbody id="admNoticeList">
                                 <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                 </tr>
                              </tbody>
                           </table>
                        </div>
                        <!--주문내용끝  -->
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <!--반품내용  -->
                        <div class="divComGrpCodList">
                           <table class="col">
                              <caption>caption</caption>
                              <colgroup>
                                 <col width="10%">
                                 <col width="15%">
                                 <col width="10%">
                                 <col width="15%">
                                 <col width="10%">
                              </colgroup>
                              <thead>
                                 <tr>
                                    <th scope="col">공급처명</th>
                                    <th scope="col">공급처 연락처</th>
                                    <th scope="col">담당자명</th>
                                    <th scope="col">주소</th>
                                    <th scope="col">배송사원</th>
                                    <th scope="col">배송사원 연락처</th>
                                    <th scope="col">반품 완료 날짜</th>
                                    <th scope="col">반품상태</th>
                                 </tr>
                              </thead>
                              <tbody id="admNoticeList">
                                 <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td>
                                       <i class="fa fa-sort"></i>
                                       <select class="floatLabel">
                                          <option value="제품수거중" selected>제품수거중</option>
                                          <option value="반품완료">반품완료</option>
                                       </select>
                                    </td>
                                 </tr>
                              </tbody>
                           </table>
                        </div>
                        <!--반품내용 끝  -->
                        <!--주문내용  ver2  -->
                        <!--  <section>
                           <form action="">
                            반품내용1 Details
                           <div class="form-group">
                           <h2 class="heading">주문내용</h2>
                           <div class="controls">
                           <label for="name" style="margin-right: 17px; line-height: 3.5em;">주문코드</label>
                           <input type="text" id="name" class="floatLabel" name="name" style="margin-right: 17px;">
                           <label for="email" style="margin-right: 17px; line-height: 3.5em;">제목명</label>
                           <input type="text" id="name" class="floatLabel" name="name" style="margin-right: 17px;">
                           </div>
                           <div class="controls">
                           <label for="email" style="line-height: 3.5em; margin-right: 17px;">배송코드</label>
                           <input type="text" id="email" class="floatLabel" name="email" style="margin-right: 17px;">
                           <label for="phone" style="line-height: 3.5em; margin-right: 17px;">수량</label>
                           <input type="tel" id="phone" class="floatLabel" name="phone" style="margin-right: 17px;">
                           </div>       
                           <div class="grid">
                           <div class="col-2-3">
                           <div class="controls">
                           <label for="street" style="line-height: 3.5em; margin-right: 17px;">품목명</label>
                           <input type="text" id="street" class="floatLabel" name="street" style="margin-right: 17px;">
                           </div>          
                           </div>
                           </div>
                           </div></section>   -->
                        <!--주문내용 ver2끝  -->
                        <!--  반품내용2 Details -->
                        <div class="form-group">
                           <!--      <h2 class="heading">반품 내용</h2>
                              <div class="controls">
                              <label for="name" style="line-height: 3.5em; margin-right: 17px;">공급처명</label>
                              <input type="text" id="name" class="floatLabel" name="name" style="margin-right: 17px;">
                              <label for="email" style="line-height: 3.5em; margin-right: 17px;">공급처 연락처</label>
                              <input type="text" id="name" class="floatLabel" name="name" style="margin-right: 17px;">
                              </div>
                              <div class="controls">
                              <label for="email" style="line-height: 3.5em; margin-right: 17px;">담당자명</label>
                              <input type="text" id="email" class="floatLabel" name="email" style="margin-right: 17px;">
                              <label for="phone" style="line-height: 3.5em; margin-right: 17px;">주소</label>
                              <input type="tel" id="phone" class="floatLabel" name="phone" style="margin-right: 17px;">
                              </div>       
                              <div class="grid">
                              <div class="col-2-3">
                              <div class="controls">
                              <label for="street" style="line-height: 3.5em; margin-right: 17px;">배송사원</label>
                              <input type="text" id="street" class="floatLabel" name="street" style="margin-right: 17px;">
                              <label for="phone" style="line-height: 3.5em; margin-right: 17px;">배송사원 연락처</label>
                              <input type="tel" id="phone" class="floatLabel" name="phone" style="margin-right: 17px;">
                              </div>          
                              </div>
                              </div>
                              <div class="grid">
                              <div class="col-2-3">
                              <div class="controls">
                              <label for="street" style="line-height: 3.5em; margin-right: 17px;">반품 완료 날짜</label>
                              <input type="text" id="street" class="floatLabel" name="street" style="margin-right: 17px;">
                              <label for="phone" style="line-height: 3.5em; margin-right: 17px;">반품상태</label>
                              <i class="fa fa-sort"></i>
                              <select class="floatLabel">
                              <option value="제품수거중" selected>제품수거중</option>
                              <option value="반품완료">반품완료</option>
                              </select>
                              </div>          
                              </div>
                              </div>
                              <div class="grid">
                              <div class="col-2-3">
                              <div class="controls">
                              <label for="phone" style="line-height: 3.5em; margin-right: 17px;">창고명</label>
                              <input type="tel" id="phone" class="floatLabel" name="phone" style="margin-right: 17px;">
                              <i class="fa fa-sort"></i>
                              </div>          
                              </div>
                              </div> -->
                           <div class="grid">
                              <div class="col-1-3 col-1-3-sm">
                                 <div class="controls">
                                    <button type="submit" value="Submit" class="col-1-4 btnType blue" style="margin-right: 12px;
                                       font-size: 15px;
                                       color: #fff;
                                       background: #3cb3eb;
                                       padding: 7px 0;
                                       margin-left: 24px;
                                       width: 9%;
                                       margin-top: 97px;
                                       " >등록</button>
                                    <button type="submit" value="Submit" class="col-1-4 btnType blue" style="margin-right: 27px;
                                       font-size: 15px;
                                       color: #fff;
                                       background: #3cb3eb;
                                       padding: 7px 0;
                                       margin-left: 385px;
                                       width: 9%;
                                       margin-top: -4px;
                                       " >닫기</button>
                                 </div>
                              </div>
                              <div class="grid">
                                 <p class="info-text"></p>
                                 <br>
                                 <br>
                                 <br>
                              </div>
                           </div>
                           <!-- /.form-group -->
      </form>
      </div>
      <div class="paging_area" id="tutPagination"></div>
      </div>
      <!-- 반품 리스트 조회  -->
      <div class="btn_areaC mt20">
      </div>
      <h3 class="hidden">풋터 영역</h3> 
      <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
      </li>
      </ul> 
      </div>
      </div>
      <div id="layer1" class="layerPop layerType2" style="width: 650px; overflow:auto;">
      </div>
      </form>
      <form id="myForm">
         <div id="layer2" class="layerPop layerType2" style="width: 650px;">
            <dl>
               <dt>
                  <strong>공지사항 등록하기</strong>
               </dt>
               <dd class="content">
                  <table class="row">
                     <colgroup>
                        <col width="12%">
                        <col width="*">
                        <col width="12%">
                        <col width="*">
                     </colgroup>
                     <tbody>
                        <tr>
                           <th scope="row">제목</th>
                           <td><input type="text" class="inputTxt p100" name="notice_tit" id="notice_tit" placeholder="제목을 입력하세요."/></td>
                        </tr>
                        <tr>
                           <th scope="row">내용</th>
                           <td><textarea class="inputTxt p100" name="notice_con" id="notice_con" style= "min-height:250px; resize:none;"></textarea></td>
                        </tr>
                     </tbody>
                  </table>
                  <div class="btn_areaC mt20">
                     <a href="javascript:fWrite();" class="btnType blue" id="submitBtn" ><span id="">작성</span></a>
                     <a href="" class="btnType blue" id="closeBtn"><span id="">닫기</span></a>
                  </div>
               </dd>
            </dl>
            <a href="" class="closePop"><span class="hidden">닫기</span></a>
         </div>
      </form>
   </body>
</html>