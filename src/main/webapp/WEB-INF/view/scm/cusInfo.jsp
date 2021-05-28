<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>기업고객관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
</head>
<body>
	<input type="hidden" id="currentPage" value="1">
	<div id="mask"></div>
	<div id="wrap_area">
		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
					<!--// lnb 영역 -->
				</li>
				<li class="contents">
					<h3 class="hidden">contents 영역</h3> 
					<div class="content" style="margin-bottom: 20px;">
						<p class="Location">
							<a href="/system/notice.do" class="btn_set home">메인으로</a>
							<a class="btn_nav">기준정보</a>
							<span class="btn_nav bold">기업고객관리</span>
							<a href="" class="btn_set refresh">새로고침</a>
						</p>
						<form id="searchForm">
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
                                      <a class="btn btn-default" id="btnSearchEmployeeInfo" href="">검색</a>
                                    </div>
                                    <!-- // button -->
                                    <!-- checkbox -->
                                    <div class="input-group" style="display:inline-block;vertical-align:middle;margin-left:10px;">
                                        <input type="checkbox" id="searchUseYn" name="searchUseYn" onchange="javascript:fSearchCusList()">
                                        <label for="searchUseYn" style="display:inline-block;margin-top:2px;">비활성화된 항목 표시</label>
                                    </div>
                                    <!-- // checkbox -->
                                </div>
                                <!-- /.row -->
						</form>
							<table class="col" style="margin-top:15px;">
								<caption>caption</caption>
								<colgroup>
									<col width="12%">
									<col width="12%">
									<col width="12%">
									<col width="12%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">회사명</th>
										<th scope="col">담당자명</th>
										<th scope="col">연락처</th>
										<th scope="col">활성화여부</th>
									</tr>
								</thead>
								<tbody id="cusListInfo"></tbody>
							</table>
						<div class="paging_area" id="Pagination"></div>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<script type="text/javascript">

    var pageSizeInfo = 10;
    var pageBlockSize = 5;

    /*OnLoad event*/
    $(document).ready(function(){
      console.log("메인페이지 함수 실행")
      fCusList();
    }) 

    /* 기업고객 조회 */
    function fCusList(currentPage) {
        currentPage = currentPage || 1;

        console.log("currentPage : " + currentPage);

        var param = {
            currentPage : currentPage,
            pageSize : pageSizeInfo
        }
        var resultCallback = function(data) {
            fCusListResult(data, currentPage);
        }
        callAjax("/scm/cusListInfo.do", "post", "text", true, param,
                resultCallback);
    }
    
    /* 검색 조건 리스트 함수 */
    function fSearchCusList(currentPage) {
    	
    	if($("input:checkbox[id='searchUseYn']").is(":checked") == false){
    		
    		currentPage = currentPage || 1;
            
            var param = $('#searchForm').serialize();
            
            param += "&currentPage="+currentPage;
            param += "&pageSize="+pageSizeInfo;
            param += "&showY=Y";
            
            console.log("검색조건에 대한 param : " + param);
            console.log("currentPage : " + currentPage);
            
            var resultCallback = function(data) {
                fCusListResult(data, currentPage);
            };
            
            //Ajax실행 방식
            //callAjax("Url",type,return,async or sync방식,넘겨준 값,Callback함수 이름)
            callAjax("/scm/cusListInfo.do", "post", "text", true, param, resultCallback);
    	} else {
    		currentPage = currentPage || 1;
            
            var param = $('#searchForm').serialize();
            
            param += "&currentPage="+currentPage;
            param += "&pageSize="+pageSizeInfo;
            param += "&showY=N";
            
            console.log("검색조건에 대한 param : " + param);
            console.log("currentPage : " + currentPage);
            
            var resultCallback = function(data) {
                fCusListResult(data, currentPage);
            };
            
            //Ajax실행 방식
            //callAjax("Url",type,return,async or sync방식,넘겨준 값,Callback함수 이름)
            callAjax("/scm/cusListInfo.do", "post", "text", true, param, resultCallback);
    	}
                    
        
    }
    /* 고객 조회 콜백 함수 */
    function fCusListResult(data, currentPage) {

        // console.log(data);
        
        //기존 목록 삭제 및 신규 목록 삽입
        $('#cusListInfo').empty().append(data);

        // 총 개수 추출
        var totCnt = $("#totCnt").val();

        //페이지 네비게이션 생성
        var paginationHtml = getPaginationHtml(currentPage, totCnt,
                pageSizeInfo, pageBlockSize, 'fSearchCusList');
        $("#Pagination").empty().append(paginationHtml);

        //현재 페이지 설정
        $("#currentPage").val(currentPage);
    }
    
    // 기업고객 모달창
    var cusInfoModal = new tingle.modal({
        footer: true,
        stickyFooter: false,
        closeMethods: ['button'],
        closeLabel: "Close",
        cssClass: ['custom-class-1', 'custom-class-2'],
        onOpen: function() {
            console.log('modal open');
        },
        onClose: function() {
            console.log('modal closed');
        },
        beforeClose: function() {
            // here's goes some logic
            // e.g. save content before closing the modal
            return true; // close the modal
            return false; // nothing happens
        }
    });
        
    // 모달창에 들어갈 데이터
    function cusInfoModalOpen(loginID) {
        console.log("컨트롤러로 넘어가는 loginID : " + loginID)
        cusDetailInfoDirection(loginID)
        cusInfoModal.open();
    }
    
    // 저장 버튼 추가 및 리스트 Ajax    
    cusInfoModal.addFooterBtn('저장', 'tingle-btn tingle-btn--primary', function() {
        
        var param = {};

        console.log(param);
        var resultCallback = function(data) {
            // getUpdateMessage(data);
        }

        callAjax("/scm/sendPurchaseDirection.do", "post", "json", true, param, resultCallback);
        cusInfoModal.close();
    });
    
    // 닫기 버튼
    cusInfoModal.addFooterBtn('닫기', 'tingle-btn tingle-btn--danger', function() {
        cusInfoModal.close();
    });
    
    
    // 모달창에 가져올 데이터
    function cusDetailInfoDirection(loginID) {
        console.log("=== 1.모달창에 뿌릴 데이터 가져오기 시작 ===");

        var param = {
            loginID : loginID
        };

        var resultCallback = function(data) {
            cusInfoModalResult(data);
        };

        // Ajax 실행 방식
        // callAjax("Url", type, return, async or sync방식, 넘겨준거, Callback함수 이름)
        // html로 받을거라 text
        callAjax("/scm/cusDetailInfo.do", "post", "text", true, param, resultCallback);
    }

    function cusInfoModalResult(data) {
        console.log("=== 2.모달창에 뿌릴 데이터 === : " + data);
        cusInfoModal.setContent(data);
        return;
    }
    
    // DB업데이트 상태 
    function getUpdateMessage(data) {
        if (data.result === "SUCCESS") {
            swal(data.resultMsg).then(function() {
                window.location.reload(); // 새로고침
            });
            console.log("상태 업데이트 완료");
            return 1;
        } else {
            swal(data.resultMsg).then(function() {
                window.location.reload(); // 새로고침
            });
            console.log("상태 업데이트 실패");
            return 0;
        }
    }
</script>
</body>
</html>