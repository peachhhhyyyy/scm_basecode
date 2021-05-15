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
	    var pageSizeinf = 5;
	    var pageBlockSizeinquiry = 3;
				
		$(document).ready(function(){
			fReturnList();
		})
			       
        //반품리스트 조회
       function fReturnList(currentPage) {
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
		
		    //console.log(data);
		
		    // 기존 목록 삭제
		    $('#returnList').empty();
		
		    // 신규 목록 생성
		    $("#returnList").append(data);
		
		    // 총 개수 추출
		    var totalReturnListCnt = $("#returnlistCnt").val();
		  
		
		    // 페이지 네비게이션 생성
		    var paginationHtml = getPaginationHtml(currentPage, totalReturnListCnt, 
		    		pageSizeinf, pageBlockSizeinquiry, 'fReturnList');
		    // 현재 페이지 설정
		    $("#listInfPagination").empty().append(paginationHtml);
		}
			
        /* 반품내역 상세 조회*/
		function fReturnDetailList(refund_list_no) {
		    // 그룹코드 정보 설정
            $("#refund_list_no").val(refund_list_no);
		
			var param = {
				refund_list_no : refund_list_no,
			}
		
			var resultCallback = function(data) {
			    fReturnDetailResult(data);
			};
		
		    callAjax("/dlv/returnDetailList.do", "post", "text", true, param, resultCallback);
		}
				
				
		/** 반품내역 상세조회 콜백 함수 */
		function fReturnDetailResult(data) {
		    console.log(data);
		
		    // 기존 목록 삭제
		    $('#returnDetailList').empty();
		    
		    var $data = $($(data).html());
		    var $returnDetailList = $data.find("#returnDetailList");
		    $("#returnDetailList").append($returnDetailList.children());
		}
        </script>
	</head>
	<body>
		<input type="hidden" id="currentPage" value="1">
		<input type="hidden" id="selectedInfNo" value="">
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
		<div class="content" style="min-height: 203px;">
	<p class="Location">
		<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
		<span class="btn_nav bold">메인</span> 
		<a href="../dashboard/dashboard.do" class="btn_set refresh">새로고침</a>
	</p>
	<!-- 반품 리스트 조회  -->
	<input name="product_name" type="hidden" value="${productDes.product_name}">
	<p class="conTitle" style="display:flex; justify-content: space-between; align-items: center;" >
	<span>반품계획</span>
	<span style="width: 590px;">
	<select id="adm_type" style="width: 100px;">
		<option value="all" selected="selected">전체</option>
		<option value="title">승인대기</option>
		<option value="content">반품 진행 중</option>
		<option value="title">승인대기</option>
		<option value="content">반품완료</option>
	</select>
	<input type="date" id="theday" style="width: 200px; height: 28px;">
	<span>~</span>
	<input type="date" id="theday" style="width: 200px; height: 28px;">
			<a id="searchEnter" class="btn btnTypeBox" href="javascript:fReturnList()">검색</a>
		</span>
	</p>
	<!-- 반품 리스트 조회  -->
	<table class="col">
		<caption>caption</caption>
	<%-- <colgroup>
		<col width="10%">
		<col width="15%">
		<col width="10%">
		<col width="15%">
		<col width="10%">
		<col width="10%">
		<col width="15%">
		<col width="10%">
		<col width="15%">
		<col width="10%">
	</colgroup> --%>
		<thead>
			<tr>
				<th scope="col">반품번호</th>
				<th scope="col">공급처 명</th>
				<th scope="col">품목명</th>
				<th scope="col">제품명</th>
				<th scope="col">반품 수량</th>
				<th scope="col">반품 금액</th>
				<th scope="col">창고명</th>
				<th scope="col">반품접수일자</th>
				<th scope="col">상태</th>
			</tr>
		</thead>
		<tbody id="returnList"></tbody>
	</table>
	                     <div class="paging_area" id="listInfPagination"></div>
	                     </div>
	<!-- 상세페이지 조회 -->
	<form action="returnDetailInfo.do" method="get">
		<div class="divComGrpCodList">
			<p class="conTitle">
				<span>상세페이지</span>
			</p>
			<!--주문내용  -->
	<table class="col">
		<thead>
			<tr>
				<th scope="col">주문코드</th>
				<th scope="col">반품번호</th>
				<th scope="col">제품명</th>
				<th scope="col">품목명</th>
				<th scope="col">반품 수량</th>
				<th scope="col">고객 명</th>
				<th scope="col">고객연락처</th>
			</tr>
		</thead>
		<thead>
			<tr>
				<th scope="col">담당자명</th>
				<th scope="col">주소</th>
				<th scope="col">배송사원 명</th>
				<th scope="col">배송사원 연락처</th>
				<th scope="col">창고명</th>
				<th scope="col">반품 상태</th>
				<th scope="col">적요</th>
			</tr>
		</thead>
		<tbody id="returnDetailList">
			<tr>
			   <td colspan="14">반품번호를 선택해 주세요.</td>
			</tr>
		</tbody>
	</table>
	<button type="submit" 
	        value="Submit" 
	        class="col-1-4 btnType blue" 
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