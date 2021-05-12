<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="kr.happyjob.study.scm.model.SupplierInfoModel"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공급처 관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link rel="stylesheet" href="${CTX_PATH}/css/chosen/chosen.css">
<script src="${CTX_PATH}/js/chosen/chosen.jquery.js"></script>
<script type="text/javascript">

   /* 페이징 설정 */
   var userPageSize = 10;
   var userPageBlock = 5;
   
   /* onLoad event */
   $(document).ready(function() {
   // 리스트 뿌리기 함수
   selectSupplierList();
   
   });
   
   
   /* 공급처정보 목록 불러오기 */
   function selectSupplierList() {
     currentPage = currentPage || 1;
     var param = {
         currentPage : currentPage,
         pageSize : userPageSize
     }
     var resultCallback = function(data) {
       supplierListResult(data, currentPage);
     };
     callAjax("/scm/supplierList.do", "post", "text", true, pram, resultCallBack);  
   }
   
   /* 공급처정보 리스트의 data를 callback함수를 통해 뿌리기 */
   function supplierListResult(data, currentPage) {
     // 기존 목록 삭제
     $("#supplierList").empty();
     // 신규 목록 생성
     $("#supplierList").append(date);
     
     // 총 갯수 추출
     var totalCount = $("#totalCount").val();
     var list = $("#tmpList").val();
     // 페이지 네비게이션 생성
     var paginationHtml = getPaginationHtml(currentPage, totalCount, userPageSize, userPageBlock, 'selectSupplierList');
     // 기존 목록 삭제 후 다시 생성
     $("#paginationHtml").empty().append(paginationHtml);
     // 현재 페이지 설정
     $("#currentPage").val(currentPage);
   }
</script>
</head>
<body>
  <form id="mySupplier" action="" method="">
    <input type="hidden" id="currentPage" value="1">
    <!-- 현재페이지는 처음에 항상 1로 설정 -->
    <input type="hidden" id="tmpList" value="">
    <input type="hidden" id="tmpListNum" value="">
    <!-- 임시 리스트 넘버 / 스크립트에서 값을 설정해서 넘김 -->
    <input type="hidden" name="action" id="action" value="">
    <div id="wrap_area">
      <h2 class="hidden">header 영역</h2>
      <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
      <h2 class="hidden">컨텐츠 영역</h2>
      <div>
        <ul>
          <li class="lnb">
            <!-- lnb 영역 --> <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
          </li>
          <li class="contents">
          <!-- contents -->
            <h3 class="hidden">contents 영역</h3>
            <!-- content 시작-->
            <div class="content">
              <p class="Location">
               <a href=/system/notice.do " class="btn_set home">메인으로</a> 
               <a href="#" class="btn_nav">기준 정보</a> 
               <span class="btn_nav bold">공급처 관리</span> 
               <a onClick="top.location='javascript:location.reload()'" class="btn_set refresh">새로고침</a>
              </p>
              
              <P class="conTitle">
                <span>공급처 관리</span> 
              </P>
              &nbsp;&nbsp;
              <!-- 공급처 목록 테이블 -->
              <div class="supplierList">
                 <table class="col">
                  <caption>caption</caption>
                  <colgroup>
                    <col width="15%">
                    <col width="10%">
                    <col width="25%">
                    <col width="35%">
                    <col width="15%">
                  </colgroup>
                  <thead>
                    <tr>
                      <th scope="col">공급처명</th>
                      <th scope="col">담당자명</th>
                      <th scope="col">담당자 연락처</th>
                      <th scope="col">이메일</th>
                      <th scope="col">창고명</th>
                    </tr>                    
                  </thead>
                  <tbody id="supplierList"></tbody>                      
                 </table>
                 <!-- 페이징 처리 -->
                 <div class="paging_area" id="paginationHtml"></div>
              </div>              
            </div>  
            <!-- content 끝 -->  
            <h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
          </li>                              
        </ul>     
      </div>        
    </div>
  </form>
</body>
</html>