// 그룹코드 페이징 설정
var pageSizeDailyOrder = 10;
var pageBlockSizeDailyOrder = 10;
	
// 상세코드 페이징 설정
var pageSizeComnDtlCod = 5;
var pageBlockSizeComnDtlCod = 10;

$(document).ready(function() {
	// 일일 수주 조회
	fListDailyOrderHistroy();
});

//function fExcelDownload(tableID, fileID){
//	 $("#"+tableID).table2excel({
//		 exclude: ".noExl",
//		 name: "Excel Document Name",
//		 filename: fileID +'.xls', // 확장자를 여기서 붙여줘야한다.
//		 fileext: ".xls",
//		 exclude_img: true,
//		 exclude_links: true,
//		 exclude_inputs: true
//		 });
//}

/** 일별 수주 내역 조회 */
function fListDailyOrderHistroy(currentPage) {
	
  currentPage = currentPage || 1;

  console.log("currentPage : " + currentPage);

  var param = {
    currentPage: currentPage, 
    pageSize: pageSizeDailyOrder
  }

  var resultCallback = function(data) {
    flistDailyOrderHistroyResult(data, currentPage);
  };
  
  // Ajax 실행 방식
  // callAjax("Url", type, return, async or sync방식, 넘겨준거, 값, Callback함수 이름)
  // html로 받을거라 text
  callAjax("/scm/listInfo.do", "post", "text", true, param, resultCallback);
}

/** 일별 수주 내역 조회 콜백 함수 */
function flistDailyOrderHistroyResult(data, currentPage) {

  // alert(data);
  console.log(data);

  // 기존 목록 삭제
  $('#listDailyOrderHistroy').empty();

  var $data = $($(data).html());

  $("#listDailyOrderHistroy").append(data);

  // 총 개수 추출
  let totalCntDailyOrder = $("#totalCntDailyOrder").val();
  
  // 페이지 네비게이션 생성
  var paginationHtml = getPaginationHtml(currentPage, totalCntDailyOrder, pageSizeDailyOrder, pageBlockSizeDailyOrder, 'fListDailyOrderHistroy');
  console.log("paginationHtml : " + paginationHtml);

  $("#dailyOrderPagination").empty().append(paginationHtml);

  // 현재 페이지 설정
  $("#currentPageDailyOrder").val(currentPage);
  
}