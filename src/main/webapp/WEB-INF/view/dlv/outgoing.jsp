<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>출하계획</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- D3 -->
<style>
//
click-able rows
	.clickable-rows {tbody tr td { cursor:pointer;
	
}

.el-table__expanded-cell {
	cursor: default;
}
}
</style>
<script type="text/javascript">
        var pageSizeinf  = 3;
        var pageBlockSizeinquiry  = 10;

		/* onload 이벤트  */
		$(function(){
			comcombo("areaCD", "areaall", "all", "2");   // Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value )  
			comcombo("JOBCD", "joball", "all", "3");   // Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value )  
			comcombo("industryCD", "industryall", "allindustry", "J62");   // Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value )  
			
			// 공지사항 조회
			fListInf();
			
			//간이차트 조회
			//goChart();
			
			// 버튼 이벤트 등록
			fRegisterButtonClickEvent();
		});
		

		//차트 뿌리러 감
		function goChart(loginID) {
			//alert("1");
			//alert(JSON.stringify(data));
			var param= {
					loginID : loginID
			
			}
		
			var resultCallback1 = function(data) {
		//	 alert("3");
		//	alert(JSON.stringify(data.lec_Name_List));
		//	alert(JSON.stringify(data.lec_Name_List)) 
			
			fChart (data);
		};
		
		alert("2");
		callAjax("/dashboard/goChart.do", "post", "json", true, param, resultCallback1);
	}
		
		
		// bar형 chart
		function fChart(data){
		
			//일단 간단한 값만
			var cntEngineer = data.cntEngineer;
			var cntCompany = data.cntCompany;
			var cntProject = data.cntProject;
			//var cntApplicant = ${cntApplicant};
			
			var minChart = new Chart($("#minChart"),{
				
				type : 'bar' ,
				data : {
					labels : ['가입된 엔지니어 수', '가입된 기업 수', '등록된 프로젝트 수', '일별 지원자 수'] ,
						datasets : [{
								label : '간이 통계' ,
								data : [cntEngineer, cntCompany, cntProject] ,
								borderColor: [
												'rgba(255, 99, 132, 1)' ,
												'rgba(255, 206, 86, 0.2)',
												'rgba(54, 162, 235, 0.2)'
											] ,
								borderWidth : 1
						}]
				}
			});
		}
		
		
		
		/** 버튼 이벤트 등록 */
		function fRegisterButtonClickEvent() {
			$('a[name=btnInfo]').click(function(e) {
				e.preventDefault();

				var btnId = $(this).attr('id');
				switch (btnId) {
					case 'btnCloseGrpCod' :
					case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}
				  
				
		/** 공지사항 조회 */
		function fListInf(currentPage) {
			
			currentPage = currentPage || 1;
			
			console.log("currentPage : " + currentPage);
			
			var param = {
						currentPage : currentPage
					,	pageSize : pageSizeinf
			}
			
			var resultCallback = function(data) {
				fListInfResult(data, currentPage);
			};
			
			//Ajax실행 방식
			//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
			//html로 받을거라 text
			callAjax("/inf/listinf.do", "post", "text", true, param, resultCallback);
		}
		
		
		/** 공지사항 조회 콜백 함수 */
		function fListInfResult(data, currentPage) {
					//alert(data);
			console.log(data);		
			
			// 기존 목록 삭제
			$('#listInf').empty();
			$("#listInf").append(data);
			
			// 총 개수 추출
			var totalCntlistInf = $("#totcnt").val();
			var list = $("#selectedInfNo").val();
			// 페이지 네비게이션 생성
			var paginationHtml = getPaginationHtml(currentPage, totalCntlistInf, pageSizeinf, pageBlockSizeinquiry, 'fListInf',[list]);
			console.log("paginationHtml : " + paginationHtml);
		
			$("#listInfPagination").empty().append( paginationHtml );
		
		}
		
		 /*공지사항 상세 조회*/
		 function fNoticeModal(noticeNo) {
		
			 var param = {noticeNo : noticeNo};
			 var resultCallback2 = function(data){
				 fdetailResult(data);
			 };
			 
			 callAjax("/system/detailNotice.do", "post", "json", true, param, resultCallback2);
		 }
		
		 /*  공지사항 상세 조회 -> 콜백함수   */
		 function fdetailResult(data){

			 if(data.resultMsg == "SUCCESS"){
				 //모달 띄우기 
				 gfModalPop("#notice");
				 
				// 모달에 정보 넣기 
				frealPopModal(data.result);
			 
			 }else{
				 alert(data.resultMsg);
			 }
		 }
		
		 /* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */
		 function frealPopModal(object){
			 
			 $("#loginId").val(object.loginId);
			 $("#loginId").attr("readonly", true); // 작성자 수정불가 
			 
			 $("#write_date").val(object.noticeRegdate);
			 $("#write_date").attr("readonly", true); // 처음 작성된 날짜 수정불가 
			 
			 $("#noticeTitle").val(object.noticeTitle);
			 $("#noticeTitle").attr("readonly", true);

			 $("#noticeContent").val(object.noticeContent);
			 $("#noticeContent").attr("readonly", true);
			 
			 $("#noticeNo").val(object.noticeNo); // 중요한 num 값도 숨겨서 받아온다. 
			 
		 }



</script>

</head>
<body>
<form id="myForm" action=""  method="">

<input type="hidden" id="currentPage" value="1">
<input type="hidden" id="selectedInfNo" value="">
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
	               
					<div class="content" style="margin-bottom:20px;">
                       
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">메인</span> <a href="../dashboard/dashboard.do"
								class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" style="margin-bottom: 1%;">
							<span>출하계획</span> <span class="fr"> 
								<span>로그인</span>
								<span>회원가입</span>
								<span>마이페이지</span>
							</span>
						</p>
						
						
				             <div class="divComGrpCodList">
								<table class="col">
	<%-- 								<caption>caption</caption>
									<colgroup>
									   <col width="5%">
										<col width="70%">
										<col width="10%">
										<col width="5%">
									</colgroup> --%>
				
									<thead>
										<tr>
										    <th scope="col">접수일</th>
											<th scope="col">도착일자</th>
											<th scope="col">도착변경일자</th>
											<th scope="col">주문코드</th>
											<th scope="col">배송담당자</th>
											<th scope="col">창고명</th>
											<th scope="col">배송상태</th>
										</tr>
									</thead>
									<tbody id="listInf">
									</tbody>
								</table>
							</div>
										   
					   <div class="paging_area"  id="listInfPagination"> </div>
					   
					   <br><br>
					   
					   <!-- 프로젝트 조회 -->
						<div class="selectProject" >
							<table width="100%" cellpadding="5" cellspacing="0" border="1"
		                        align="left" 
		                        style="border-collapse: collapse; border: 10px #50bcdf; ">
		                        <tr style="border: 10px; border-color: blue">
		                           <td width="20" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>
		
		                           <td width="220" height="25" style="font-size: 150%; font-weight: bold;">프로젝트 조회</td>
		                           <td width="30" height="25" style="font-size: 100%"></td>
		                           <td width="40" height="25" style="font-size: 100%">지역&nbsp;</td><td><select id="areaall" name="areaall">	</select></td>          
		                           <td width="30" height="25" style="font-size: 100%"></td>
		                           <td width="40" height="25" style="font-size: 100%">직무&nbsp;</td><td><select id="joball" name="joball">	</select></td>          
		                           <td width="30" height="25" style="font-size: 100%"></td>
		                           <td width="40" height="25" style="font-size: 100%">산업&nbsp;</td><td><select id="industryall" name="industryall">	</select></td>          
		                            
		                           <td width="180" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>        
		                           <td width="100" height="60" style="font-size: 120%">
		                           <a href="" class="btnType blue" id="searchBtn" name="btn"><span>검  색</span></a></td> 
		                           <td width="20" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>        
		                        </tr>
		                     </table>    
						</div>
				
						<div class="divListProject">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="8%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">회사명</th>
										<th scope="col">지역</th>
										<th scope="col">직무</th>
										<th scope="col">산업</th>
										<th scope="col">작성일</th>
										<th scope="col">모집마감일</th>
										<th scope="col">작성 회사</th>
									</tr>
								</thead>
								<tbody id="listProject">
									<tr>
										<td colspan="12">조건에 맞는 프로젝트 목록이 조회됩니다.</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="paging_area"  id="listProjectPagination"> </div>
						
						<!-- 통계 -->
						<div class="stat" >
							<table width="100%" cellpadding="5" cellspacing="0" border="1" align="left" 
		                        style="border-collapse: collapse; border: 10px #50bcdf; ">
		                        <tr style="border: 10px; border-color: blue">
		                           <td width="20" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>
		                           <td width="950" height="25" style="font-size: 150%; font-weight: bold;">간이 통계</td>
		                           <td width="30" height="25" style="font-size: 100%"></td>
		                      		<br><br>
		                        </tr>
		                     </table>    
						</div>
						
						<div class="statView">
							<table class="col">
								<canvas id="minChart" style="height:30vh;"/>
							</table>
						</div>
						
					</div> <!--// content -->

					</li>
			</ul>
		</div>
	</div>
					

				
				
		<div id="infModal" class="layerPop layerType2" style="width: 900px;">
								
		<dl>
			<dt>
				<strong>1:1문의</strong>
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
							<th scope="row">제목 </th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="grp_cod_eplti" id="inf_title" maxlength="100"readonly/></td>
						</tr>
						
						<tr>
							<th scope="row">내용</th>
							<td colspan="3" ><textarea class="inputTxt p100"
							style="height: 200px; word-break : break-all;"
								name="grp_cod_eplti" id="inf_content"readonly></textarea></td>
						</tr>
						<tr>
							<th scope="row">첨부 파일 </th>
							<td>
								<div id="filedown"></div>
							</td>
						</tr>
				</tbody>
		</table>
				<div class="btn_areaC mt30">
					<a href="" class="btnType gray" id="btnCloseGrpCod" name="btnInfo"><span>취소</span></a>
				</div>
		</dl>
		</div>
		
		
	<!-- 모달팝업 -->
	<div id="notice" class="layerPop layerType2" style="width: 600px;">
		<input type="hidden" id="noticeNo" name="noticeNo" value="${noticeNo}"> <!-- 수정시 필요한 num 값을 넘김  -->
		
		<dl>
			<dt>
				<strong>공지사항</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>

					<tbody>
						<tr>
							<th scope="row">작성자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="loginId" id="loginId" /></td>
							<!-- <th scope="row">작성일<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="write_date" id="write_date" /></td> -->
						</tr>
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="noticeTitle" id="noticeTitle" /></td>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td colspan="3">
								<textarea class="inputTxt p100" name="noticeContent" id="noticeContent">
								</textarea>
							</td>
						</tr>
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>

		</dl>
	</div>
</form>
</body>
</html>