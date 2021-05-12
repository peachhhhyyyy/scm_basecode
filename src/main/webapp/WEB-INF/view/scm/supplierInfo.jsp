<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="kr.happyjob.study.scm.model.SupplierInfoModel"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공급처 관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
  //공급처 페이징 처리
  var userPageSize = 5;
  var userPageBlock = 5;
  //OnLoad event
  $(document).ready(function() {
    //공급처 목록 조회
    selectSupplierList();
  });

  /*공급처 조회*/
  function selectSupplierList(currentPage) {
    currentPage = currentPage || 1;
    var param = {
    currentPage : currentPage,
    pageSize : userPageSize,
    }
    var resultCallback = function(data) {
      supplierListResult(data, currentPage);
    };
    callAjax("/scm/supplierList.do", "post", "text", true, param, resultCallback);
  }
  /*공급처 조회 콜백 함수*/
  function supplierListResult(data, currentPage) {
    
    console.log("data : " + data);
    //기존 목록 삭제
    $("#supplierList").empty();
    $("#supplierList").append(data);
    // 총 개수 추출
    var totalCnt = $("#totalCount").val();
    var list = $("#tmpList").val();
    //페이지 네비게이션 생성
    var paginationHtml = getPaginationHtml(currentPage, totalCnt, userPageSize, userPageBlock, 'selectSupplierList');
    $("#paginationHtml").empty().append(paginationHtml);
    //현재 페이지 설정
    $("#currentPage").val(currentPage);
  }
  
  
</script>
</head>
<body>
<form id="myForm" action="" method="">
    <input type="hidden" id="currentPage" value="1">  
    <input type="hidden" id="tmpList" value=""> 
    <input type="hidden" id="tmpList_no" value=""> 
    <input type="hidden" name="action" id="action" value="">
    <div id="mask"></div>
    <div id="wrap_area">
          
          
          <h2 class="hidden">header 영역</h2>
          <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
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
                       <div class="content">
                       
                            <p class="Location">
                                 <a href="/system/notice.do" class="btn_set home">메인으로</a> 
                                 <a class="btn_nav">기준 정보</a>
                                  <span class="btn_nav bold">공급처 정보</span> 
                                 <a href="" class="btn_set refresh">새로고침</a>
                            </p>
                            
                            <p class="conTitle">
                                 <span>공급처 정보</span>
                                 <span class="fr"> 
                    
                  
                                      <a href="javascript:fPopModalDelivery()" class="btnType blue" name="modal">
                                      <span>신규등록</span>
                                      </a>
                                 </span>
                            </p>
                         <!--검색창   -->
                                  <table width="100%" cellpadding="5" cellspacing="0" border="1" align="left" style="border-collapse: collapse; border: 1px #50bcdf;">
                                  <tr style="border: 0px; border-color: blue">
                                       <td width="100" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>
                                       <td width="50" height="25" style="font-size: 100%; text-align: right; padding-right: 25px;"><select id="oname" name="oname" style="width: 130px; height: 27px">
                                       <option value="supply_nm">공급처명</option>
                                       <option value="supply_mng_nm">담당자명</option>
                                       </select> <input type="text" style="width: 150px; height: 25px;" id="sname" name="sname"> <a href="" class="btnType blue" id="searchBtn" name="btn"><span>검 색</span></a></td>
                                  </tr>
              </table>   
                            
                    <div class="SupplierList">
                         <table class="col">
                                <caption>caption</caption>
                                    <colgroup>
                                    <col width="10%">
                                    <col width="7%">
                                    <col width="13%">
                                    <col width="18%">
                                    <col width="10%">
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
                   </div>
                       
                   <div class="paging_area" id="paginationHtml"></div>    
              </div>
                  
                       <h3 class="hidden">풋터 영역</h3> <jsp:include
                               page="/WEB-INF/view/common/footer.jsp"></jsp:include>
                  </li>
              </ul>
          </div>
    
    
    </div>
</form>
</body>
</html>