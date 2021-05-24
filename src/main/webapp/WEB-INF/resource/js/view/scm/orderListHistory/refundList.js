// 반품신청 목록 페이징 설정
var pageSizeRefundList = 5;
var pageBlockSizerefundList = 10;

$(document).ready(function() {
  // 반품신청 목록
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

/** 반품신청 목록 조회 */
function getRefundList(currentPage) {
  
  currentPage = currentPage || 1;

  console.log("currentPage : " + currentPage);

  var param = {
    currentPage: currentPage, 
    pageSize: pageSizeRefundList
  };

  var resultCallback = function(data) {
    getRefundListResult(data, currentPage);
  };
  
  callAjax("/scm/refundListInfo.do", "post", "text", true, param, resultCallback);
};

/** 반품신청 목록 조회 콜백 함수 */
function getRefundListResult(data, currentPage) {
  console.log(data);
  // 기존 목록 삭제
  $('#refundListHistory').empty().append(data);

  // 총 개수 추출
  let totalCnt = $("#totcnt").val();
  console.log(totalCnt);
  // 페이지 네비게이션 생성
  var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSizeRefundList, pageBlockSizerefundList, 'searchRefundList');

  $("#refundListPagination").empty().append(paginationHtml);

  // 현재 페이지 설정
  $("#currentPage").val(currentPage);
  
};

function getRefundDetail(orderCode) {
  console.log(orderCode);
  
  var param = {
      orderCode: orderCode
  };
  
  var resultCallback = function(data) {
    getRefundDetailResult(data);
  }
  
  callAjax("/scm/refundDetailInfo.do", "post", "text", true, param, resultCallback);
};

function getRefundDetailResult(data) {
  console.log(data);
  
  $('#detailRefund').empty().append(data);
};

function closeRefundDetail() {
  $('#detailRefund').empty();
}

function requestApprove() {
  var param = $('#refundForm').serialize();
  
  var resultCallback = function(data) {
    getRefundApproveResult(data);
  }
  
  callAjax("/scm/refundDirectionInsert.do", "post", "json", true, param, resultCallback);
}

function getRefundApproveResult(data) {
  if (data.result === "SUCCESS") {
    swal(data.resultMsg).then(function() {
      window.location.reload(); // 새로고침
    });
    console.log("상태 업데이트 완료");
    return 1;
  } else {
    swal(data.resultMsg).then(function() {
      window.location.reload(); // 새로고침
    });
    console.log("상태 업데이트 실패");
    return 0;
  }
}

// 반품신청목록 검색 기능
function searchRefundList(currentPage) {
  var param = $('#refundListForm').serialize();
  console.log(param);
  
  currentPage = currentPage || 1;
  
  param += "&currentPage="+currentPage;
  param += "&pageSize="+pageSizeRefundList;
  
  var startD = $('#startDate').val();
  var endD = $('#endDate').val();
  
  console.log(param);
  
  // 날짜 에러 있을 때, 경고창 띄우고 refresh
  if (startD > endD) {
    swal("시작일자가 종료일자보다 뒤에 있을 수 없습니다.\n날짜를 다시 지정해주세요.").then(function() {
      window.location.reload();
    });
    return 0;
  } 
  
  var resultCallback = function(data) {
    getRefundListResult(data, currentPage);
  };
  
  callAjax("/scm/refundListInfo.do", "post", "text", true, param, resultCallback);
}

$('input[type="text"]').keydown(function(event) {
  if (event.keyCode === 13) {
    searchRefundList();
  };
});