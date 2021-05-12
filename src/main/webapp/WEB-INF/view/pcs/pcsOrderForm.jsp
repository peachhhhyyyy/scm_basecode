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
  
  $(function() {
    // 발주 지시서 조회
    fListPcsOrderForm();

    // 버튼 이벤트 등록
    fRegisterButtonClickEvent();
  });

  /** 버튼 이벤트 등록 */
  function fRegisterButtonClickEvent() {
    $('a[name=btn]').click(function(e) {
      e.preventDefault();

      var btnId = $(this).attr('id');

      switch (btnId) {
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
    } else {
      // 발주서 버튼 클릭 시 화면 출력
      fSelectPurchBtn(purch_list_no, supply_nm, prod_nm, l_ct_cd, purch_qty, purchase_price, desired_delivery_date, warehouse_nm, purch_mng_id);
    }
  }

  /** 발주지시서 목록 조회 */
  function fListPcsOrderForm(currentPage) {
    currentPage = currentPage || 1;

    console.log("currentPage : " + currentPage);

    var param = {
      currentPage : currentPage,
      pageSize : pageSizeComnGrpCod
    }
    var resultCallback = function(data) {
      fListPcsOrderFormResult(data, currentPage);
    };
    //Ajax실행 방식
    //callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
    callAjax("/pcs/listPcsOrderForm.do", "post", "text", true, param, resultCallback);
  }

  /** 발주지시서 콜백 함수 */
  function fListPcsOrderFormResult(data, currentPage) {

    //alert(data);
    console.log("data: " + data);

    // 기존 목록 삭제
    $("#listPcsOrderForm").empty();

    // 신규 목록 생성
    $("#listPcsOrderForm").append(data);

    // 총 개수 추출
    var totalCount = $("#totalCount").val();
    
    // 페이지 네비게이션 생성
    var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSizeComnGrpCod, pageBlockSizeComnGrpCod, 'fListPcsOrderForm');
    console.log("paginationHtml : " + paginationHtml);
    //alert(paginationHtml);
    $("#pcsOrderFormPagination").empty().append(paginationHtml);

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

      $("#btnSubmitPurchBtn").click(function(e){
        e.preventDefault();
        e.stopImmediatePropagation();
        alert(data.resultMsg);
      })
      console.log("fSelectPurchBtnResult : " + JSON.stringify(data));
    } else {
      alert(data.resultMsg);
    }
  }
</script>
</head>
<body>
		<form id="myForm" action="" method="">
				<input type="hidden" id="currentPageComnGrpCod" value="1"> <input type="hidden" id="currentPageComnDtlCod" value="1"> <input type="hidden" id="tmpGrpCod" value=""> <input type="hidden" id="tmpGrpCodNm" value=""> <input type="hidden" name="action" id="action" value="">
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
																<span class="btn_nav bold">발주서</span>
																<a href="#" class="btn_set refresh">새로고침</a>
														</p>
														<p class="conTitle">
																<span>발주서</span> 
																<span class="fr"> 
																  <a class="btnType blue" href="javascript:fPopModalComnGrpCod();" name="modal"><span>신규등록</span></a>
																</span>
														</p>
														<form class="search-container">
                                <div class="row">
                                    <!-- searchbar -->
                                    <div class="col-lg-6">
                                        <div class="input-group">
                                            <div class="input-group-btn">
                                                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                                    전체 <span class="caret"></span>
                                                </button>
                                                <ul class="dropdown-menu" role="menu">
                                                    <li><a href="#">업종</a></li>
                                                    <li><a href="#">제품</a></li>
                                                </ul>
                                            </div>
                                            <input type="text" class="form-control" aria-label="...">
                                        </div>
                                    </div>
                                    <!-- // searchbar -->
                                    <!-- date -->
                                    <div class='col-md-3 col-xs-4'>
                                        <div class="form-group">
                                            <div class="input-group date" id="datetimepicker1" data-target-input="nearest">
                                                <input type="text" class="form-control datetimepicker-input" data-target="#datetimepicker1" value="01/11/2020">
                                                <div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker">
                                                    <div class="input-group-text">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- // date -->
                                    <!-- button -->
                                    <div class="btn-group" role="group" aria-label="...">
                                      <button type="button" class="btn btn-default">검색</button>
                                    </div>
                                    <!-- // button -->
                                </div>
                                <!-- /.row -->
                            </form>
														<div class="divComGrpCodList">
																<table class="col">
																		<caption>caption</caption>
																		<colgroup>
																				<col width="5%">
																				<col width="5%">
																				<col width="10%">
																				<col width="10%">
																				<col width="10%">
																				<col width="7%">
																				<col width="10%">
																				<col width="10%">
																				<col width="10%">
																				<col width="10%">
																				<col width="*">
																				<col width="6%">
																		</colgroup>
																		<thead>
																				<tr>
																						<th scope="col">발주번호</th>
																						<th scope="col">발주코드</th>
																						<th scope="col">회사명</th>
																						<th scope="col">제품명</th>
																						<th scope="col">품목명</th>
																						<th scope="col">발주수량</th>
																						<th scope="col">창고명</th>
																						<th scope="col">발주날짜</th>
																						<th scope="col">배송희망날짜</th>
																						<th scope="col">상태</th>
																						<th scope="col">입고완료</th>
																						<th scope="col">반품</th>
																				</tr>
																		</thead>
																		<tbody id="listPcsOrderForm"></tbody>
																</table>
														</div>
														<div class="paging_area" id="pcsOrderFormPagination"></div>
														<p class="conTitle mt50">
																<span>상세 코드</span> 
																<span class="fr">
																  <a class="btnType blue" href="javascript:fPopModalComnDtlCod();" name="modal">
																    <span>신규등록</span>
																  </a>
																</span>
														</p>
														<div class="divComDtlCodList">
																<table class="col">
																		<caption>caption</caption>
																		<colgroup>
																				<col width="7%">
																				<col width="10%">
																				<col width="10%">
																				<col width="10%">
																				<col width="5%">
																				<col width="5%">
																				<col width="9%">
																				<col width="9%">
																				<col width="9%">
																				<col width="9%">
																				<col width="10%">
																				<col width="*">
																		</colgroup>
																		<thead>
																				<tr>
																						<th scope="col">순번</th>
																						<th scope="col">그룹 코드 ID</th>
																						<th scope="col">상세 코드 ID</th>
																						<th scope="col">상세 코드 명</th>
																						<th scope="col">순서</th>
																						<th scope="col">사용</th>
																						<th scope="col">임시 필드 01</th>
																						<th scope="col">임시 필드 01</th>
																						<th scope="col">임시 필드 03</th>
																						<th scope="col">임시 필드 04</th>
																						<th scope="col">코드 설명</th>
																						<th scope="col">비고</th>
																				</tr>
																		</thead>
																		<tbody id="listComnDtlCod">
																				<tr>
																						<td colspan="12">그룹코드를 선택해 주세요.</td>
																				</tr>
																		</tbody>
																</table>
														</div>
														<div class="paging_area" id="comnDtlCodPagination"></div>
												</div> <!--// content -->
												<h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
										</li>
								</ul>
						</div>
				</div>
				<!-- 모달팝업 -->
				<div id="layer1" class="layerPop layerType2" style="width: 600px;">
						<dl>
								<dt>
										<strong>그룹코드 관리</strong>
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
																<th scope="row">그룹 코드 <span class="font_red">*</span></th>
																<td><input type="text" class="inputTxt p100" name="grp_cod" id="grp_cod" /></td>
																<th scope="row">그룹 코드 명 <span class="font_red">*</span></th>
																<td><input type="text" class="inputTxt p100" name="grp_cod_nm" id="grp_cod_nm" /></td>
														</tr>
														<tr>
																<th scope="row">코드 설명 <span class="font_red">*</span></th>
																<td colspan="3"><input type="text" class="inputTxt p100" name="grp_cod_eplti" id="grp_cod_eplti" /></td>
														</tr>
														<tr>
																<th scope="row">임시 필드 01</th>
																<td colspan="3"><input type="text" class="inputTxt p100" name="grp_tmp_fld_01" id="grp_tmp_fld_01" /></td>
														</tr>
														<tr>
																<th scope="row">임시 필드 02</th>
																<td colspan="3"><input type="text" class="inputTxt p100" name="grp_tmp_fld_02" id="grp_tmp_fld_02" /></td>
														</tr>
														<tr>
																<th scope="row">임시 필드 03</th>
																<td colspan="3"><input type="text" class="inputTxt p100" name="grp_tmp_fld_03" id="grp_tmp_fld_03" /></td>
														</tr>
														<tr>
																<th scope="row">사용 유무 <span class="font_red">*</span></th>
																<td colspan="3"><input type="radio" id="radio1-1" name="grp_use_poa" id="grp_use_poa_1" value='Y' /> <label for="radio1-1">사용</label> &nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="radio1-2" name="grp_use_poa" id="grp_use_poa_2" value="N" /> <label for="radio1-2">미사용</label></td>
														</tr>
												</tbody>
										</table>
										<!-- e : 여기에 내용입력 -->
										<div class="btn_areaC mt30">
												<a href="" class="btnType blue" id="btnSaveGrpCod" name="btn"><span>저장</span></a> <a href="" class="btnType blue" id="btnDeleteGrpCod" name="btn"><span>삭제</span></a> <a href="" class="btnType gray" id="btnCloseGrpCod" name="btn"><span>취소</span></a>
										</div>
								</dd>
						</dl>
						<a href="" class="closePop"><span class="hidden">닫기</span></a>
				</div>
				<!--// 모달팝업 -->
		</form>
</body>
</html>