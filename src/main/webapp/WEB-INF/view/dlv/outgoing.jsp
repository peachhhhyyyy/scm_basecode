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
					//$('#detailList').hide();
			
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
			
					// 기존 목록 삭제/삽입
					$('#outgoingList').empty().append(data);
			
					// 총 개수 추출
					var totcnt = $("#totcnt").val();
			
					// 페이지 네비게이션 생성
					var paginationHtml = getPaginationHtml(currentPage, totcnt,
							pageSizeinfo, pageBlockSizeinquiry, 'fOrderList');
			
					/* console.log("paginationHtml : " + paginationHtml); */
			
					$("#lisOutgoingPagination").empty().append(paginationHtml);
			
				}
			
				
				// 검색조건으로 수주내역 가져오기
				function fSearchOrderList(currentPage) {
					
					currentPage = currentPage || 1;
					
					// 필요하기 전까지 숨김
                    $('#submitBtn').hide();
                    
                    var param = $('#outgoingSearchForm').serialize();
                    
                    param += "&currentPage="+currentPage;
                    param += "&pageSize="+pageSizeinfo;
                    
                    console.log("검색조건에 대한 param : " + param)
                    
                    var startDate = $('#startDate').val();
                    var endDate = $('#endDate').val();

	                // 날짜가 올바르지 않거나 널값인 경우 랜딩
	                if(startDate > endDate){
	                    alert("시작일자는 종료일자보다 클 수가 없습니다.");
	                    location.href= "/dlv/outgoing.do";
	                }
	                
	                var resultCallback = function(data) {
	                	fOrderListResult(data, currentPage);
	                };
	        
	                //Ajax실행 방식
	                //callAjax("Url",type,return,async or sync방식,넘겨준 값,Callback함수 이름)
	                callAjax("/dlv/outgoingList.do", "post", "text", true, param, resultCallback);
				}
				
				/* 출하내역 상세 조회*/
				function fOrderDetailList(order_cd) {
					
				  $('#submitBtn').show();
				  
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
			    
				
				// 폼값 처리 
				function fsubmitForm(){
					
					var checkValue = {};
				    
					$.each($('#submitForm').serializeArray(), function(){
						checkValue[this.name] = this.value;
					});
					
					// chack null value
					if(checkValue.arrPrevDate != null){
						
					    console.log(checkValue);
						if(checkValue.dlvStaffNameAndLoginId === "선택" || checkValue.arrPrevDate === "" || checkValue.state == "15"){
	                          swal("\n입력하지 않은 양식이 있거나, \n\n아직 배송 중이지 않은 건입니다.").then(function(){
	                              location.href="/dlv/outgoing.do";
                              })
	                    } else{
		                    var param = $('#submitForm').serialize();
		                    
		                    var resultCallback = function(data) {
		                         fSubmitForm(data);
		                    };
		                    
		                    callAjax("/dlv/submitDlvInfo.do", "post", "text", true, param, resultCallback);
	                    	
	                    }
	                    
	                    } else if (checkValue.state == "15"){
	                    	
	                    	
	                    	var param = $('#submitForm').serialize();
                            
                            var resultCallback = function(data) {
                                 fSubmitForm(data);
                            };
                            
                            callAjax("/dlv/submitDlvInfo.do", "post", "text", true, param, resultCallback);
	                    } else if($('#completeState').val() === "15") {
	                    	swal("\n처리된 건입니다.").then(function(){
                                location.href="/dlv/outgoing.do";
                            })
	                    }
					}
					
				// 폼값 콜백 함수
				function fSubmitForm(data){
					console.log("===== 업데이트 완료 =====");
				    jQuery(function(){
				    	window.location.reload();
				    })
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
							<form id="outgoingSearchForm">
								<p class="conTitle" style="display:flex; justify-content: space-between; align-items: center;" >
									<span>출하계획</span>
									<!-- 상단 상태, 날짜 조회 부분 -->
									<span style="width: 590px;">
									    <select id="STTcd" name="STTcd" style="width: 100px;">
											<option value="all">전체</option>
											<option value="13">배송준비</option>
											<option value="14">배송중</option>
											<option value="15">배송완료</option>
										</select>
										<input type="date" name="startDate" id="startDate" style="width: 200px; height: 28px;">
										<span>~</span>
										<input type="date" name="endDate" id="endDate" style="width: 200px; height: 28px;">
	                                    <a id="searchEnter" 
	                                        class="btn btnTypeBox" 
	                                        href="javascript:fSearchOrderList()"
	                                        style="border:1px solid #adb0b5;">검색</a>
	                                </span>
								</p>
                            </form>
							<table class="col">
								<thead>
									<tr>
										<th scope="col">주문코드</th>
										<th scope="col">접수일자</th>
										<th scope="col">도착예정일자</th>
										<th scope="col">배송완료일자</th>
										<th scope="col">배송사원</th>
										<th scope="col">창고명</th>
										<th scope="col">상태</th>
									</tr>
								</thead>
								<tbody id="outgoingList"></tbody>
							</table>
						<div class="paging_area" id="lisOutgoingPagination"></div>
					</div>
					<!-- <div style="display:flex; justify-content: center; align-items: center; min-height:340px;">
					   <p style="font-family:Spoqa Han Sans; font-size: 35px; color:#adb0b5; padding-bottom:80px;">
					       <span>주문코드를 선택해주세요.</span>
					   </p>
					</div> -->
						<form id="submitForm" action="javascript:fsubmitForm();" method="post">
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