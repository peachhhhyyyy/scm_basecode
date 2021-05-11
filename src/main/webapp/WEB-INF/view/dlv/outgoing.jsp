<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>출하계획</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link rel="stylesheet" href="${CTX_PATH}/css/view/dlv/outgoing.css">

<script type="text/javascript">
			var pageSizeinfo = 5;
			var pageBlockSizeinquiry = 5;
		
			// Onload Event //
			$(document).ready(function() {
				fOrderList();
			})
		
			/** 수주내역 조회 */
			function fOrderList(currentPage) {
		
				currentPage = currentPage || 1;
		
				console.log("currentPage : " + currentPage);
		
				var param = {
					currentPage : currentPage,
					pageSize : pageSizeinfo
				}
		
				var resultCallback = function(data) {
					fOrderListResult(data, currentPage);
				};
		
				//Ajax실행 방식
				//callAjax("Url",type,return,async or sync방식,넘겨준 값,Callback함수 이름)
				callAjax("/dlv/outgoingList.do", "post", "text", true, param,
						resultCallback);
			}
		
			/** 출하내역 조회 콜백 함수 */
			function fOrderListResult(data, currentPage) {
				/* console.log(data); */
		
				// 기존 목록 삭제
				$('#outgoingList').empty();
				$("#outgoingList").append(data);
		
				// 총 개수 추출
				var totcnt = $("#totcnt").val();
		
				// 페이지 네비게이션 생성
				var paginationHtml = getPaginationHtml(currentPage, totcnt,
						pageSizeinfo, pageBlockSizeinquiry, 'fOrderList');
		
				/* console.log("paginationHtml : " + paginationHtml); */
		
				$("#lisOutgoingPagination").empty().append(paginationHtml);
		
			}
		
			
			/* 출하내역 상세 조회*/
			function fOrderDetailList(order_cd) {
			
			  // 그룹코드 정보 설정
			  $("#order_cd").val(order_cd);
			
			  var param = {
			  		  order_cd : order_cd,
			  }
			
			  var resultCallback = function(data) {
				  fOrderListDetailResult(data);
			  };
			
			  callAjax("/dlv/outgoingDetailList.do", "post", "text", true, param, resultCallback);
			}
			
			
			/** 출하내역 상세조회 콜백 함수 */
			function fOrderListDetailResult(data) {
			    console.log(data);
			
			    // 기존 목록 삭제
			    $('#outgoingDetailList').empty();
			    
			    var $data = $($(data).html());
			    var $outgoingDetailList = $data.find("#outgoingDetailList");
			    $("#outgoingDetailList").append($outgoingDetailList.children());
			}
		</script>
</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPage" value="1">
		<input type="hidden" id="order_cd" value="">
		<!-- 모달 배경 -->
		<div id="mask"></div>
		<div id="wrap_area">
			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb 영역 --> <jsp:include
							page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
					</li>
					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3> <!-- content --> <!-- <form> -->
						<div class="content" style="margin-bottom: 20px;">

							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">메인</span> <a
									href="../dashboard/dashboard.do" class="btn_set refresh">새로고침</a>
							</p>
							<p class="conTitle">
								<span>출하계획</span>

								<!-- 상단 상태, 날짜 조회 부분 -->
								<span class="fr"> <span> <select name="state"
										id="state" style="width: 100px;">
											<option value="all" selected="selected">전체</option>
											<option value="rfs">배송준비중</option>
											<option value="dfp">배송중</option>
											<option value="com">배송완료</option>
									</select>
								</span> <input type="date" name="startDate" id="startDate"
									style="width: 200px; height: 28px;"> <span>~</span> <input
									type="date" name="endDate" id="endDate"
									style="width: 200px; height: 28px;"> <!-- 검색 부분 구현해야함 -->
									<!-- <button id="searchEnter" class="btn btnTypeBox" type="javascript:fOrderList()">검색</button> -->
								</span>

							</p>
							<table class="col">
								<!-- 각 컬럼 너비 -->
								<!-- <caption>caption</caption>
									<colgroup>
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="5%">
										<col width="5%">
										<col width="5%">
									</colgroup> -->
								<thead>
									<tr>
										<th scope="col">접수일자</th>
										<th scope="col">도착일자</th>
										<th scope="col">도착예정일자</th>
										<th scope="col">주문코드</th>
										<th scope="col">배송담당자</th>
										<th scope="col">창고명</th>
										<th scope="col">상태</th>
									</tr>
								</thead>
								<tbody id="outgoingList"></tbody>
							</table>
						</div> <!-- </form> -->
						<div class="paging_area" id="lisOutgoingPagination"></div>

						<div class="content">
							<p class="conTitle">
								<span>상세페이지</span>
							</p>
							<!--주문내용  -->
							<table class="col">
<!-- 								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="15%">
									<col width="10%">
									<col width="15%">
									<col width="10%">
								</colgroup> -->
								<thead>
									<tr>
										<th scope="col">배송코드</th>
										<th scope="col">주문코드</th>
										<th scope="col">품목명</th>
										<th scope="col">제품명</th>
										<th scope="col">수량</th>
										<th scope="col">고객명</th>
										<th scope="col">고객연락처</th>
										<th scope="col">주소</th>
										<th scope="col">SCM담당자명</th>
										<th scope="col">배송사원</th>
										<th scope="col">배송사원 연락처</th>
										<th scope="col">창고명</th>
										<th scope="col">도착예정일자</th>
										<th scope="col">배송상태</th>
									</tr>
								</thead>
								<tbody id="outgoingDetailList">
				                    <tr>
				                      <td colspan="14">주문코드를 선택해 주세요.</td>
				                    </tr>
			                    </tbody>
							</table>
						</div> <!-- <button class="btn btn-default" type="submit">등록</button>
									<button class="btn btn-default" type="submit">닫기</button> -->
					</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>