<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<style type="text/css">


#ProdInfoModal {
  display: none;
}
</style>


<title>제품정보 관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
  /*페이징 설정*/

  var pageSizeProdInfo = 10;
  var pageBlockSizeProdInfo = 5;

  /** OnLoad event */
  $(document).ready(function() {

    fListProdInfo(); // 제품정보 조회

  });

  /** 제품정보 조회 */
  function fListProdInfo(currentPage) {

    currentPage = currentPage || 1;

    var param = {
    currentPage : currentPage,
    pageSize : pageSizeProdInfo
    }

    var resultCallback = function(data) {
      fProdInfoResult(data, currentPage);
    };
    //Ajax실행 방식
    //callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)

    callAjax("/scm/listProdInfo.do", "post", "text", true, param, resultCallback);
  }

  /** 그룹코드 조회 콜백 함수 */
  function fProdInfoResult(data, currentPage) {

    // 기존 목록 삭제
    $('#listProdInfo').empty();

    // 신규 목록 생성
    $("#listProdInfo").append(data);

    // 총 개수 추출
    var totalCntProdInfo = $("#totalCntProdInfo").val();
    
    var list = $("tmpList").val();
    
    var ProdInfoListPagination = getPaginationHtml(currentPage, totalCntProdInfo, pageSizeProdInfo, pageBlockSizeProdInfo, 'fListProdInfo',[list]);
   
   
    // 페이지 네비게이션 생성
    var paginationHtml = getPaginationHtml(currentPage, totalCntProdInfo, pageSizeProdInfo, pageBlockSizeProdInfo, 'fListProdInfo');
    console.log("paginationHtml : " + paginationHtml);
    //alert(paginationHtml);
    $("#ProdInfoPagination").empty().append(paginationHtml); 


    // 현재 페이지 설정
    $("#currentPageProdInfo").val(currentPage);
  }

  function fPopModalProdInfo() {
    gfModalPop('#layer1');
  }

  function fProdInfoModalShow() {
    document.getElementById("ProdInfoModal").style.display = "block";
  }
</script>
</head>



<body>
  <input type="hidden" id="currentPageProdInfo" value="1">
  <input type="hidden" id="tmpProdInfo" value="">
  <input type="hidden" id="tmpProdInfoNm" value="">
  <input type="hidden" name="action" id="action" value="">
  <!-- 모달 배경 -->
  <div id="mask"></div>
  <div id="wrap_area">
    <h2 class="hidden">header 영역</h2>
    <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
    <h2 class="hidden">컨텐츠 영역</h2>
    
    
    <div id="container">
      <ul>
        <li class="lnb">
          <!-- lnb 영역 --> <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
        </li>
        <li class="contents">
          <!-- contents -->
          <h3 class="hidden">contents 영역</h3> <!-- content -->
         
         
          <div class="content">
            <p class="Location">
              <a href="/system/notice.do" class="btn_set home">메인으로</a> <a href="#" class="btn_nav">기준정보</a> <span class="btn_nav bold"> 제품정보 관리</span> <a href="#" class="btn_set refresh">새로고침</a>
            </p>
            
            <p class="conTitle">
              <span>검색</span> <span class="fr">
                <a class="btnType blue"
                    href="javascript:fListProdInfo()" name="search"><span
                    id="searchEnter">조회</span></a><br/>
              </span>
            </p>

            <div class="ProdInfoList">
              <table class="col">
                <caption>caption</caption>
                <colgroup>
                  <col width="10%">
                  <col width="10%">
                  <col width="10%">
                  <col width="10%">
                  <col width="10%">
                  <col width="10%">
                  <col width="10%">
                </colgroup>
                <thead>
                  <tr>
                    <th scope="col">제품코드</th>
                    <th scope="col">제품명</th>
                    <th scope="col">품목명</th>
                    <th scope="col">공급처명</th>
                    <th scope="col">창고명</th>
                    <th scope="col">장비구매액</th>
                    <th scope="col">단가</th>
                  </tr>
                </thead>
                <tbody id="listProdInfo"></tbody>
              </table>
            </div>
            <!-- 페이징 처리 -->    
            <div class="paging_area" id="ProdInfoListPagination">
               <div class="paging">
                  <a class="first" href="javascript:fListProdInfo(1)">
                  <span class="hidden">맨앞</span></a>
                  <a class="pre" href="javascript:fListProdInfo(1)">
                  <span class="hidden">이전</span></a>
                <!-- <strong>1</strong>  -->
                  <a href="javascript:fListProdInfo(1)">1</a> 
                  <a href="javascript:fListProdInfo(2)">2</a> 
                  <a href="javascript:fListProdInfo(3)">3</a> 
                  <a href="javascript:fListProdInfo(4)">4</a>
                  <a href="javascript:fListProdInfo(5)">5</a>
                  <a class="next" href="javascript:fListProdInfo(5)">
                  <span class="hidden">다음</span></a>
                  <a class="last" href="javascript:fListProdInfo(5)">
                  <span class="hidden">맨뒤</span></a>
                </div>    
                                                
            </div>
            
          </div> <!--// content -->
          <h3 class="hidden">풋터 영역</h3> 
            <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
        </li>
      </ul>
    </div>
  </div>
</body>
</html>