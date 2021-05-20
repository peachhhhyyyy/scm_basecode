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
					
					// 필요하기 전까지 숨기기
					$('#submitBtn').hide();
					$('#detailList').hide();
			
					currentPage = currentPage || 1;
			
					// console.log("currentPage : " + currentPage);
					
					var param = {
						currentPage : currentPage,
						pageSize : pageSizeinfo
					}
			
					var resultCallback = function(data) {
						fOrderListResult(data, currentPage);
					};
					
					//Ajax실행 방식
					//callAjax("Url",type,return,async or sync방식,넘겨준 값,Callback함수 이름)
					callAjax("/dlv/outgoingList.do", "post", "text", true, param, resultCallback);
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
					
					// 필요하기 전까지 숨기기
                    $('#submitBtn').show();
                    $('#detailList').show();
				
				
				  var param = {
				  		  order_cd : order_cd,
				  }
				
				  var resultCallback = function(data) {
					  fOrderListDetailResult(data);
				  };
				
				  callAjax("/dlv/outgoingDetailList.do", "post", "text", true, param, resultCallback);
				}
				
				
				// 출하내역 상세조회 콜백 함수 
				function fOrderListDetailResult(data) {
				    //console.log(data);
				
				    // 기존 목록 삭제
				    $('#outgoingDetailListTop').empty();
				    $('#outgoingDetailListBottom').empty();
				    
				    var $data = $($(data).html());
				    // topList
				    var $outgoingDetailListTop = $data.find("#outgoingDetailListTop");
				    $("#outgoingDetailListTop").append($outgoingDetailListTop.children());
				    
				    // bottomList
				    var $outgoingDetailListBottom = $data.find("#outgoingDetailListBottom");
				    $("#outgoingDetailListBottom").append($outgoingDetailListBottom.children());
				}
				
				
				// 검색조건으로 수주내역 가져오기
				function fSearchOrderList(currentPage, STTcd, startDate, endDate) {
					
					// 필요하기 전까지 숨기기
                    $('#submitBtn').hide();
                    $('#detailList').hide();
					
					console.log(STTcd, startDate, endDate)
					
					currentPage = currentPage || 1;
			        
	                console.log("currentPage : " + currentPage);
	                
	                // 날짜가 올바르지 않거나 널값인 경우 랜딩
	                if(startDate == '' || endDate == ''){
	                    alert("날짜를 설정해주세요.");
	                    location.href= "/dlv/outgoing.do";
	                }
	                
	                if(startDate > endDate){
	                    alert("시작일자는 종료일자보다 클 수가 없습니다.");
	                    location.href= "/dlv/outgoing.do";
	                }
	                
	                var param = {
	                		currentPage : currentPage,
	                		pageSize : pageSizeinfo,
	                		STTcd : STTcd,
	                		startDate : startDate,
	                		endDate : endDate
	                }
	        
	                var resultCallback = function(data) {
	                	fSearchOrderListResult(data, currentPage);
	                };
	        
	                //Ajax실행 방식
	                //callAjax("Url",type,return,async or sync방식,넘겨준 값,Callback함수 이름)
	                callAjax("/dlv/outgoingSearchList.do", "post", "text", true, param,
	                        resultCallback);
				}
				
			    // 검색 조건 콜백함수
	            function fSearchOrderListResult(data, currentPage) {
	                
			    	console.log(data);
	                
	                // 기존 목록 삭제
	                $('#outgoingList').empty();
	                $("#outgoingList").append(data);
	        
	                // 총 개수 추출
	                var totcnt = $("#totcnt").val();
	        
	                // 페이지 네비게이션 생성
	                var paginationHtml = getPaginationHtml(currentPage, totcnt,
	                        pageSizeinfo, pageBlockSizeinquiry, 'fSearchOrderList');
	        
	                /* console.log("paginationHtml : " + paginationHtml); */
	        
	                $("#lisOutgoingPagination").empty().append(paginationHtml);
	        
	            }
			    
			    // 콤보박스로 선택된 배송기사이름으로 연락처 받아오기
			    function fSelectDlvStaffTel(){
			    	
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
	                callAjax("/dlv/selDlvTel.do", "post", "json", true, param, resultCallback);
			    }
			    
			    function fDlvStaffTelResult(data) {
	                
	                console.log("연락처 결과 : " + data.dlvStaffTel);
	                
	                $('#dlvStaffTel').text(data.dlvStaffTel)
	        
	            }
			    
				
			</script>
	</head>
	<body>
		<input type="hidden" id="currentPage" value="1">
		<!-- 모달 배경 -->
		<div id="mask"></div>
		<div id="wrap_area">
			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb 영역 --> 
						<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
					</li>
					<li class="contents">
						<h3 class="hidden">contents 영역</h3> <!-- content --> <!-- <form> -->
						<div class="content" style="margin-bottom: 20px;">
							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">메인</span>
								<a href="../dashboard/dashboard.do" class="btn_set refresh">새로고침</a>
							</p>
							<p class="conTitle" style="display:flex; justify-content: space-between; align-items: center;" >
								<span>출하계획</span>
								<!-- 상단 상태, 날짜 조회 부분 -->
								<span style="width: 590px;">
								    <select id="STTcd" name="STTcd" style="width: 100px;">
										<option value="13, 14, 15">전체</option>
										<option value="13">배송준비</option>
										<option value="14">배송중</option>
										<option value="15">배송완료</option>
									</select>
									<input type="date" name="startDate" id="startDate" style="width: 200px; height: 28px;">
									<span>~</span>
									<input type="date" name="endDate" id="endDate" style="width: 200px; height: 28px;">
                                    <a id="searchEnter" 
                                        class="btn btnTypeBox" 
                                        href="javascript:fSearchOrderList(1, $('#STTcd').val(), $('#startDate').val(), $('#endDate').val())"
                                        style="border:1px solid #adb0b5;">검색</a>
                                </span>
							</p>
							<table class="col">
								<thead>
									<tr>
										<th scope="col">접수일자</th>
										<th scope="col">배송완료일자</th>
										<th scope="col">도착예정일자</th>
										<th scope="col">주문코드</th>
										<th scope="col">배송사원</th>
										<th scope="col">창고명</th>
										<th scope="col">상태</th>
									</tr>
								</thead>
								<tbody id="outgoingList"></tbody>
							</table>
						<div class="paging_area" id="lisOutgoingPagination"></div>
					</div>
						<form action="submitDlvInfo.do" method="post">
						<div id="detailList" class="content">
							<p class="conTitle">
								<span>상세페이지</span>
							</p>
							<!--주문내용  -->
							<table class="col">
								<colgroup>
									<col width="5%">
									<col width="5%">
									<col width="5%">
									<col width="15%">
									<col width="2.5%">
									<col width="5%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
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
									</tr>
								</thead>
							    <tbody id="outgoingDetailListTop"></tbody>
		                    </table>
		                    <table class="col">
								<colgroup>
									<col width="10%">
									<col width="10%">
									<col width="15%">
									<col width="10%">
									<col width="10%">
									<col width="15%">
									<col width="5%">
									<col width="10%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">SCM담당자명</th>
										<th scope="col">창고명</th>
										<th scope="col">배송사원</th>
										<th scope="col">배송사원 연락처</th>
										<th scope="col">도착예정일자</th>
										<th scope="col">배송상태</th>
										<th scope="col" colspan="2">요구사항</th>
									</tr>
								</thead>
							    <tbody id="outgoingDetailListBottom">
				                    <tr>
				                      <td colspan="14">주문코드를 선택해 주세요.</td>
				                    </tr>
			                    </tbody>
							</table>
							<button id="submitBtn" type="submit" value="Submit" class="col-1-4 btnType blue" style="
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