// 수주내역 조회 페이징 설정
var pageSizeOrderList = 10;
var pageBlockSizeOrderList = 10;

$(document).ready(function() {
	// 일일 수주 조회
	forderListHistory();
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
function forderListHistory(currentPage) {
	
  currentPage = currentPage || 1;

  console.log("currentPage : " + currentPage);

  var param = {
    currentPage: currentPage, 
    pageSize: pageSizeOrderList
  };

  var resultCallback = function(data) {
    forderListHistoryResult(data, currentPage);
  };
  
  // Ajax 실행 방식
  // callAjax("Url", type, return, async or sync방식, 넘겨준거, Callback함수 이름)
  // html로 받을거라 text
  callAjax("/scm/listInfo.do", "post", "text", true, param, resultCallback);
}

/** 일별 수주 내역 조회 콜백 함수 */
function forderListHistoryResult(data, currentPage) {

  // alert(data);
  console.log(data);

  // 기존 목록 삭제
  $('#orderListHistory').empty().append(data);

  // 총 개수 추출
  let totalCnt = $("#totcnt").val();
  console.log(totalCnt);
  // 페이지 네비게이션 생성
  var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSizeOrderList, pageBlockSizeOrderList, 'forderListHistory');
  console.log("paginationHtml : " + paginationHtml);

  $("#orderListPagination").empty().append(paginationHtml);

  // 현재 페이지 설정
  $("#currentPage").val(currentPage);
  
};

// 입금대기 상태일때 배송,발주 버튼 클릭할 때 나타나는 에러 메시지 함수
function fnotYetDeposit() {
  alert("아직 입금이 완료되지 않았습니다.");
};