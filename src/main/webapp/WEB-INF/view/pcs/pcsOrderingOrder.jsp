<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
  // 그룹코드 페이징 설정
  var pageSizeComnGrpCod = 10;
  var pageBlockSizeComnGrpCod = 5;

  // 상세코드 페이징 설정
  var pageSizeComnDtlCod = 5;
  var pageBlockSizeComnDtlCod = 10;

  /** OnLoad event */

  $(function() {

    // 그룹코드 조회
    fListComnGrpCod();

    // 버튼 이벤트 등록
    fRegisterButtonClickEvent();
  });

  /** 버튼 이벤트 등록 */
  function fRegisterButtonClickEvent() {
    $('a[name=btn]').click(function(e) {
      e.preventDefault();

      var btnId = $(this).attr('id');

      switch (btnId) {
      case 'btnSubmitPurchBtn':
        fSelectPurchBtn();
        break;
      case 'btnClosePurchBtn':
        gfCloseModal();
        break;
      }
    });
  }

  /** 그룹코드 모달 실행 */
  function fPopModalComnGrpCod(purch_list_no, supply_nm, prod_nm, l_ct_cd, purch_qty, purchase_price, desired_delivery_date, warehouse_nm, purch_mng_id) {
    // 신규 저장
    if (purch_list_no == null || purch_list_no == "") {

      // Tranjection type 설정
      $("#action").val("I");

      // 그룹코드 폼 초기화
      fInitFormGrpCod();

      // 모달 팝업
      gfModalPop("#layer1");

      // 수정 저장
    } else {

      // Tranjection type 설정
      $("#action").val("U");

      // 발주서 버튼 클릭 시 화면 출력
      fSelectPurchBtn(purch_list_no, supply_nm, prod_nm, l_ct_cd, purch_qty, purchase_price, desired_delivery_date, warehouse_nm, purch_mng_id);
    }
  }

  /** 발주지시서 목록 조회 */
  function fListComnGrpCod(currentPage) {

    currentPage = currentPage || 1;

    console.log("currentPage : " + currentPage);

    var param = {
    currentPage : currentPage,
    pageSize : pageSizeComnGrpCod
    }

    var resultCallback = function(data) {
      flistPcsOrderingOrder(data, currentPage);
    };
    //Ajax실행 방식
    //callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
    callAjax("/pcs/listPcsOrderingOrder.do", "post", "text", true, param, resultCallback);
  }

  /** 발주지시서 콜백 함수 */
  function flistPcsOrderingOrder(data, currentPage) {

    //alert(data);
    console.log(data);

    // 기존 목록 삭제
    $('#listPcsOrderingOrder').empty();

    // 신규 목록 생성
    $("#listPcsOrderingOrder").append(data);

    // 총 개수 추출
    var totalCount = $("#totalCount").val();
    
    // 페이지 네비게이션 생성
    var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSizeComnGrpCod, pageBlockSizeComnGrpCod, 'fListComnGrpCod');
    console.log("paginationHtml : " + paginationHtml);
    //alert(paginationHtml);
    $("#comnOrderingOrderPagination").empty().append(paginationHtml);

    // 현재 페이지 설정
    $("#currentPage").val(currentPage);
  }

  /** 발주서 화면 띄우기 */ 
  function fSelectPurchBtn(purch_list_no, supply_nm, prod_nm, l_ct_cd, purch_qty, purchase_price, desired_delivery_date, warehouse_nm, purch_mng_id) {

    var param = {
      purch_list_no : purch_list_no,
      supply_nm : supply_nm,
      prod_nm : prod_nm,
      l_ct_cd : l_ct_cd,
      purch_qty : purch_qty,
      purchase_price : purchase_price,
      desired_delivery_date : desired_delivery_date,
      warehouse_nm : warehouse_nm,
      purch_mng_id : purch_mng_id
    };

    $("#purchListNo").text(purch_list_no);
    $("#supplyNm").text(supply_nm);
    $("#prodNm").text(prod_nm);
    $("#lCtCd").text(l_ct_cd);
    $("#purchQty").text(purch_qty);
    $("#purchasePrice").text(purchase_price);
    $("#desiredDeliveryDate").text(desired_delivery_date);
    $("#warehouseNm").text(warehouse_nm);
    $("#purchMngId").text(purch_mng_id);
    
    // 발주 버튼 누르고 전송버튼 누를 때 보내는 데이터, hidden값에 실어서 보낼 데이터
    // $("#tmpGrpCod").val('????');
    
    // 모달 팝업
    gfModalPop("#layer1");
    
    var resultCallback = function(data) {
      fSelectPurchBtnResult(data);
    };

    callAjax("/pcs/selectPurchBtn.do", "post", "json", true, param, resultCallback);
  }
  
  /** 발주서 화면 콜백 함수*/
  function fSelectPurchBtnResult(data) {
    if (data.result == "SUCCESS") {
      // 모달 팝업
      gfModalPop("#layer1");

      console.log("fSelectPurchBtnResult : " + JSON.stringify(data));
    } else {
      alert(data.resultMsg);
    }
  }
</script>
</head>
<body>
		<form id="myForm" action="" method="">
				<input type="hidden" id="currentPageComnGrpCod" value="1">
				<input type="hidden" id="currentPageComnDtlCod" value="1">
				<input type="hidden" id="tmpGrpCod" value="">
				<input type="hidden" id="tmpGrpCodNm" value="">
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
																<a href="#" class="btn_set home">메인으로</a>
																<a href="pcs/pcsOrderingoOrder.do" class="btn_nav">구매</a>
																<span class="btn_nav bold">발주 지시서</span>
																<a href="#" class="btn_set refresh">새로고침</a>
														</p>
														<p class="conTitle">
																<span>발주 지시서 목록</span>
														</p>
														<div class="divComGrpCodList">
																<table class="col">
																		<caption>caption</caption>
																		<colgroup>
																				<col width="7%">
																				<col width="10%">
																				<col width="20%">
																				<col width="7%">
																				<col width="7%">
																				<col width="6%">
																				<col width="*">
																				<col width="10%">
																				<col width="7%">
																				<col width="7%">
																		</colgroup>
																		<thead>
																				<tr>
																						<th scope="col">발주번호</th>
																						<th scope="col">회사명</th>
																						<th scope="col">제품명</th>
																						<th scope="col">품목명</th>
																						<th scope="col">제품수량</th>
																						<th scope="col">금액</th>
																						<th scope="col">배송희망날짜</th>
																						<th scope="col">창고명</th>
																						<th scope="col">담당자</th>
																						<th scope="col">발주</th>
																				</tr>
																		</thead>
																		<tbody id="listPcsOrderingOrder"></tbody>
																</table>
														</div>
														<div class="paging_area" id="comnOrderingOrderPagination"></div>
												<h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
										</li>
								</ul>
						</div>
				</div>
				<!-- 모달팝업 -->
				<div id="layer1" class="layerPop layerType2" style="width: 600px;">
						<dl>
								<dt>
										<strong>발주서</strong>
								</dt>
								<dd class="content">
										<!-- s : 여기에 내용입력 -->
										<table class="row">
												<caption>caption</caption>
												<colgroup>
														<col width="120px">
														<col width="*">
												</colgroup>
												<tbody>
														<tr>
																<th scope="row">발주코드</th>
																<td id="purchListNo"></td>
														</tr>
														<tr>
																<th scope="row">회사명</th>
																<td id="supplyNm"></td>
														</tr>
														<tr>
																<th scope="row">제품명</th>
																<td id="prodNm"></td>
														</tr>
														<tr>
                                <th scope="row">품목명</th>
                                <td id="lCtCd"></td>
                            </tr>
                            <tr>
                                <th scope="row">제품수량</th>
                                <td id="purchQty"></td>
                            </tr>
                            <tr>
                                <th scope="row">금액</th>
                                <td id="purchasePrice"></td>
                            </tr>
                            <tr>
                                <th scope="row">배송희망날짜</th>
                                <td id="desiredDeliveryDate"></td>
                            </tr>
                            <tr>
                                <th scope="row">창고명</th>
                                <td id="warehouseNm"></td>
                            </tr>
                            <tr>
                                <th scope="row">담당자</th>
                                <td id="purchMngId"></td>
                            </tr>
												</tbody>
										</table>
										<!-- e : 여기에 내용입력 -->
										<div class="btn_areaC mt30">
												<a href="" class="btnType blue" id="btnSubmitPurchBtn" name="btn"><span>전송</span></a>
												<a href="" class="btnType gray" id="btnClosePurchBtn" name="btn"><span>취소</span></a>
										</div>
								</dd>
						</dl>
						<a href="" class="closePop"><span class="hidden">닫기</span></a>
				</div>
				<!--// 모달팝업 -->
		</form>
</body>
</html>