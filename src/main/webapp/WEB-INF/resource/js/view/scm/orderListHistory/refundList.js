// 수주내역 조회 페이징 설정
var pageSizerefundList = 5;
var pageBlockSizerefundList = 10;

$(document).ready(function() {
  // 일일 수주 조회
  getRefundList();
  
});

//function fExcelDownload(tableID, fileID){
//   $("#"+tableID).table2excel({
//     exclude: ".noExl",
//     name: "Excel Document Name",
//     filename: fileID +'.xls', // 확장자를 여기서 붙여줘야한다.
//     fileext: ".xls",
//     exclude_img: true,
//     exclude_links: true,
//     exclude_inputs: true
//     });
//}

/** 일별 수주 내역 조회 */
function getRefundList(currentPage) {
  
  currentPage = currentPage || 1;

  console.log("currentPage : " + currentPage);

  var param = {
    currentPage: currentPage, 
    pageSize: pageSizerefundList
  };

  var resultCallback = function(data) {
    getRefundListResult(data, currentPage);
  };
  
  // Ajax 실행 방식
  // callAjax("Url", type, return, async or sync방식, 넘겨준거, Callback함수 이름)
  // html로 받을거라 text
  callAjax("/scm/refundListInfo.do", "post", "text", true, param, resultCallback);
}

/** 일별 수주 내역 조회 콜백 함수 */
function getRefundListResult(data, currentPage) {
  console.log(data);
  // 기존 목록 삭제
  $('#refundListHistory').empty().append(data);

  // 총 개수 추출
  let totalCnt = $("#totcnt").val();
  console.log(totalCnt);
  // 페이지 네비게이션 생성
  var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSizerefundList, pageBlockSizerefundList, 'getRefundList');

  $("#refundListPagination").empty().append(paginationHtml);

  // 현재 페이지 설정
  $("#currentPage").val(currentPage);
  
};
