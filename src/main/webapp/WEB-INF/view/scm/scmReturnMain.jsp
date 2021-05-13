<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
   <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge" />
      <title>반품계획서</title>
      <jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
      <script type="text/javascript">
      	var pageSizeinf = 5;
  		var pageBlockSizeinquiry = 3;
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
   <input type="hidden" id="currentPage" value="1"> <input
			type="hidden" id="selectedInfNo" value="">
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
                     <div class="content" style="min-height: 203px;">
                        <p class="Location">
                           <a href="" class="btn_set home">메인으로</a> 
                           <a href="" class="btn_nav">작업지시서</a> <span class="btn_nav bold">반품지시서</span>
                           <a href="" class="btn_set refresh">새로고침</a>
                        </p>
                        <!-- 반품 지시서리스트 조회  -->
                        <form name="returnList" id="returnList" method="post" action="returnList.do">
                        <input name="product_name" type="hidden" value="${productDes.product_name}">
                        <div class="divComGrpCodList">
                           <p class="conTitle">
                              <span>반품지시서</span>
                              <span class="fr">
                                 <span>
                                    <select id="adm_type" style="width: 100px;">
                                       <option value="all" >전체</option>
                                       <option value="title">제품명</option>
                                       <option value="content">공급처명</option>
                                       <option value="title">scm관리자명</option>
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
                                 <col width="10%">
                                 <col width="15%">
                              </colgroup>
                              <thead>
                                 <tr>
                                    <th scope="col">번호</th>
                                    <th scope="col">제품명</th>
                                    <th scope="col">품목명</th>
                                    <th scope="col">공급처명</th>
                                    <th scope="col">발주개수</th>
                                    <th scope="col">scm관리자</th>
                                    <th scope="col">제출일자</th>
                                 </tr>
                              </thead>
                              <tbody id="returnList">
                              </tbody>
                           </table>
                           </form>
                        </div>
                        <div class="paging_area" id="listInfPagination"></div>
      											</div> 
                        <!-- 반품 리스트 조회  -->
                        <br><br>
                       
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
   </body>
</html>