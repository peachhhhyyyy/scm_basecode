// 발주지시서 목록 페이징 설정
var pageSizeOrderList = 10;
var pageBlockSizeOrderList = 10;

$(document).ready(function() {
  // 일일 수주 조회
  getRefundDirectionList();
  
});

/** 발주지시서 내역 조회 */
function getRefundDirectionList(currentPage) {
  
  currentPage = currentPage || 1;

  console.log("currentPage : " + currentPage);

  var param = {
    currentPage: currentPage, 
    pageSize: pageSizeOrderList
  };

  var resultCallback = function(data) {
    getRefundDirectionListResult(data, currentPage);
  };
  
  // Ajax 실행 방식
  // callAjax("Url", type, return, async or sync방식, 넘겨준거, Callback함수 이름)
  // html로 받을거라 text
  callAjax("/ecv/refundDirectionListInfo.do", "post", "text", true, param, resultCallback);
}

/** 일별 수주 내역 조회 콜백 함수 */
function getRefundDirectionListResult(data, currentPage) {

  // alert(data);
  console.log(data);

  // 기존 목록 삭제
  $('#refundDirListHistory').empty().append(data);

  // 총 개수 추출
  let totalCnt = $("#totcnt").val();
  console.log(totalCnt);
  // 페이지 네비게이션 생성
  var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSizeOrderList, pageBlockSizeOrderList, 'searchRefundDirectionList');
  console.log("paginationHtml : " + paginationHtml);

  $("#refundDirListPagination").empty().append(paginationHtml);

  // 현재 페이지 설정
  $("#currentPage").val(currentPage);
  
};


var allowRefundModal = new tingle.modal({
  footer: true,
  stickyFooter: false,
  closeMethods: ['button'],
  closeLabel: "Close",
  cssClass: ['custom-class-1', 'custom-class-2'],
  onOpen: function() {
      console.log('modal open');
  },
  onClose: function() {
      console.log('modal closed');
  },
  beforeClose: function() {
      // here's goes some logic
      // e.g. save content before closing the modal
      return true; // close the modal
      return false; // nothing happens
  }
});

allowRefundModal.setContent("<h1>승인 하시겠습니까?</h1>")

var orderCd = '';
//add a button
allowRefundModal.addFooterBtn('승인', 'tingle-btn tingle-btn--primary', function() {
  var param = {
      STTcd: 5,
      orderCode: orderCd
  }
  
  var resultCallback = function(data) {
    getUpdateMessage(data);
  }
  
  callAjax("/ecv/ecvApprove.do", "post", "json", true, param, resultCallback);
  allowRefundModal.close();
});

function getUpdateMessage(data) {
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

// add another button
allowRefundModal.addFooterBtn('취소', 'tingle-btn tingle-btn--danger', function() {
  allowRefundModal.close();
});

function allowRefund(orderCode) {
  orderCd = orderCode;
  
  allowRefundModal.open();
}

function searchRefundDirectionList(currentPage) {
  var param = $('#refundDirectionListForm').serialize();
  console.log(param);
  
  currentPage = currentPage || 1;
  
  param += "&currentPage="+currentPage;
  param += "&pageSize="+pageSizeOrderList;
  
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
    getRefundDirectionListResult(data, currentPage);
  };
  
  callAjax("/ecv/refundDirectionListInfo.do", "post", "text", true, param, resultCallback);
}

$('input[type="text"]').keydown(function(event) {
  if (event.keyCode === 13) {
    searchRefundDirectionList();
  };
});