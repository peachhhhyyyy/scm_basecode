<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>반품계획</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link rel="stylesheet" href="${CTX_PATH}/css/view/dlv/outgoing.css">
<script type="text/javascript">
	var pageSizeinfo = 5;
	var pageBlockSizeinquiry = 3;

	$(document).ready(function() {
		fReturnList();
	})

	//반품리스트 조회
	function fReturnList(currentPage) {
		currentPage = currentPage || 1;
		console.log("currentPage : " + currentPage);
		
		$('#submitBtn').hide();
		$('#detailList').hide();

		var param = {
			currentPage : currentPage,
			pageSize : pageSizeinfo
		}

		var resultCallback = function(data) {
			fReturnListResult(data, currentPage);
		};

		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		//html로 받을거라 text
		callAjax("/dlv/returnList.do", "post", "text", true, param,
				resultCallback);

	}

	function fReturnListResult(data, currentPage) {

		//console.log(data);

		// 기존 목록 삭제
		$('#returnList').empty();

		// 신규 목록 생성
		$("#returnList").append(data);

		// 총 개수 추출
		var totalReturnListCnt = $("#totCnt").val();

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalReturnListCnt,
				pageSizeinfo, pageBlockSizeinquiry, 'fReturnList');
		// 현재 페이지 설정
		$("#listInfPagination").empty().append(paginationHtml);
	}

	// 검색조건으로 반품내역 가져오기
	function fSearchReturnList(currentPage, STTcd, startDate, endDate) {

		console.log(STTcd, startDate, endDate)

		currentPage = currentPage || 1;

		console.log("currentPage : " + currentPage);
		
		$('#submitBtn').hide();
		$('#detailList').hide();

		// 날짜 비교, 널값 알맞지 않으면 랜딩
		if (startDate == '' || endDate == '') {
			alert("날짜를 설정해주세요.");
			location.href = "/dlv/returnMain.do";
		}

		if (startDate > endDate) {
			alert("시작일자는 종료일자보다 클 수가 없습니다.");
			location.href = "/dlv/returnMain.do";
		}

		var param = {
			currentPage : currentPage,
			pageSize : pageSizeinfo,
			STTcd : STTcd,
			startDate : startDate,
			endDate : endDate
		}

		var resultCallback = function(data) {
			fSearchReturnListResult(data, currentPage);
		};

		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준 값,Callback함수 이름)
		callAjax("/dlv/returnSearchList.do", "post", "text", true, param,
				resultCallback);
	}

	// 검색 조건 콜백함수
	function fSearchReturnListResult(data, currentPage) {

		console.log(data);

		// 기존 목록 삭제
		$('#returnList').empty();
		$("#returnList").append(data);

		// 총 개수 추출
		var totcnt = $("#totcnt").val();

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totcnt,
				pageSizeinfo, pageBlockSizeinquiry, 'fSearchReturnList');

		/* console.log("paginationHtml : " + paginationHtml); */

		$("#lisOutgoingPagination").empty().append(paginationHtml);

	}

	/* 반품내역 상세 조회*/
	function fReturnDetailList(refund_list_no) {
		
		$('#submitBtn').show();
		$('#detailList').show();

		var param = {
			refund_list_no : refund_list_no,
		}

		var resultCallback = function(data) {
			fReturnDetailResult(data);
		};

		callAjax("/dlv/returnDetailList.do", "post", "text", true, param,
				resultCallback);
	}

	/** 반품내역 상세조회 콜백 함수 */
	function fReturnDetailResult(data) {
		// console.log(data);

		// 기존 목록 삭제
		$('#returnDetailListTop').empty();
		$('#returnDetailListBottom').empty();

		var $data = $($(data).html());

		// topList
		var $returnDetailListTop = $data.find("#returnDetailListTop");
		$("#returnDetailListTop").append($returnDetailListTop.children());
		// bottomList
		var $returnDetailListBottom = $data.find("#returnDetailListBottom");
		$("#returnDetailListBottom").append($returnDetailListBottom.children());
	}

	// 콤보박스로 선택된 배송기사이름으로 연락처 받아오기
	function fSelectDlvStaffTel() {

		var selDlvName = $('#getDlvStaffName > option:selected').val().split(' ')[0];

		// console.log(selDlvName);

		var param = {
			selDlvName : selDlvName
		}

		var resultCallback = function(data) {
			fDlvStaffTelResult(data);
		};

		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준 값,Callback함수 이름)
		callAjax("/dlv/selDlvTelReturn.do", "post", "json", true, param,
				resultCallback);
	}

	function fDlvStaffTelResult(data) {

		console.log("연락처 결과 : " + data.dlvStaffTel);

		$('#dlvStaffTel').text(data.dlvStaffTel)

	}
</script>
</head>
<body>
	<input type="hidden" id="currentPage" value="1">
	<div id="mask"></div>
	<div id="wrap_area">
	    <h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
				    <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
			    </li>
				<li class="contents">
					<h3 class="hidden">contents 영역</h3>
					<div class="content" style="min-height: 20px;">
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
							<span class="btn_nav bold">메인</span> <a
								href="../dashboard/dashboard.do" class="btn_set refresh">새로고침</a>
						</p>
						<p class="conTitle" style="display: flex; justify-content: space-between; align-items: center;">
							<span>반품계획</span> 
							<span style="width: 590px;"> 
								<select id="STTcd" name="STTcd" style="width: 100px;">
										<option value="5, 6, 7" selected="selected">전체</option>
										<option value="5">승인완료</option>
										<option value="6">반품 진행 중</option>
										<option value="7">반품완료</option>
								</select> 
								<input type="date" id="startDate" style="width: 200px; height: 28px;">
								<span>~</span>
								<input type="date" id="endDate" style="width: 200px; height: 28px;">
								<a id="searchEnter" 
								    class="btn btnTypeBox" 
								    href="javascript:fSearchReturnList(1, $('#STTcd').val(), $('#startDate').val(), $('#endDate').val())"
								    style="border:1px solid #adb0b5;">검색</a>
							</span>
						</p>
						<!-- 반품 리스트 조회  -->
						<table class="col">
							<caption>caption</caption>
							<thead>
								<tr>
									<th scope="col">반품번호</th>
									<th scope="col">고객명</th>
									<th scope="col">품목명</th>
									<th scope="col">제품명</th>
									<th scope="col">반품수량</th>
									<th scope="col">반품금액</th>
									<th scope="col">창고명</th>
									<th scope="col">반품접수일자</th>
									<th scope="col">상태</th>
								</tr>
							</thead>
							<tbody id="returnList"></tbody>
						</table>
						<div class="paging_area" id="listInfPagination"></div>
					</div> <!-- 상세페이지 조회 -->
					<form action="updateSubmitInfo.do" method="post">
						<div id="detailList" class="content">
							<p class="conTitle">
								<span>상세페이지</span>
							</p>
							<!--주문내용  -->
							<table class="col">
								<thead>
									<tr>
										<th scope="col">주문코드</th>
										<th scope="col">반품번호</th>
										<th scope="col">품목명</th>
										<th scope="col">제품명</th>
										<th scope="col">반품수량</th>
										<th scope="col">고객명</th>
										<th scope="col">고객연락처</th>
										<th scope="col">주소</th>
									</tr>
								</thead>
								<tbody id="returnDetailListTop"></tbody>
							</table>
							<table class="col">
								<thead>
									<tr>
										<th scope="col">담당자명</th>
										<th scope="col">배송사원</th>
										<th scope="col">배송사원 연락처</th>
										<th scope="col">창고명</th>
										<th scope="col">반품 상태</th>
										<th scope="col">적요</th>
									</tr>
								</thead>
								<tbody id="returnDetailListBottom">
									<tr>
										<td colspan="7">반품번호를 선택해 주세요.</td>
									</tr>
								</tbody>
							</table>
							<button id="submitBtn" type="submit" value="Submit" class="col-1-4 btnType blue"
								style="
								    margin-right: -2px; 
								    font-size: 15px; 
								    color: #fff; 
								    background: #3cb3eb; 
								    padding: 7px 0; 
								    margin-left: 339px; 
								    width: 9%; 
								    margin-top: 55px;"
								formmethod="post">등록</button>
						</div>
					</form>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>