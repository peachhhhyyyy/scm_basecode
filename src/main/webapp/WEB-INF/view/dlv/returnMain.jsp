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
                                 <col width="10%">
                                 <col width="15%">
                                 <col width="10%">
                                 <col width="15%">
                                 <col width="10%">
                              </colgroup>
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
                              <tbody id="returnList">
                              </tbody>
                           </table>
                           </form>
                           
                        </div>
                        <div class="paging_area" id="listInfPagination"></div>
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
                             
                              <thead>
                                 <tr>
                                    <th scope="col">주문코드</th>
                                    <th scope="col">제목명</th>
                                    <th scope="col">배송코드</th>
                                    <th scope="col">수량</th>
                                    <th scope="col">품목명</th>
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
                              <tbody id="returnDetailList">
                              </tbody>
                              <tbody>
                               
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
   </body>
</html>