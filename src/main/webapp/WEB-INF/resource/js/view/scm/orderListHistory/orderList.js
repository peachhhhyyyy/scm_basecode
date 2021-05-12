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
  swal("아직 입금이 완료되지 않았습니다.");
  return;
};

function fnotEnoughStock() {
  swal("재고량이 주문 수량보다 적습니다. \n발주를 진행하여 재고 입고를 진행해주세요.");
  return;
};

// 모달창 만들기
// instanciate new modal
// 구매버튼 모달창 만들기
var purchaseModal = new tingle.modal({
    footer: true,
    stickyFooter: false,
    closeMethods: ['overlay', 'button', 'escape'],
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

// add a button
purchaseModal.addFooterBtn('승인요청', 'tingle-btn tingle-btn--primary', function() {
    // here goes some logic
  purchaseModal.close();
});

// add another button
purchaseModal.addFooterBtn('취소', 'tingle-btn tingle-btn--danger', function() {
  purchaseModal.close();
});

function purchaseModalOpen() {
  //set content
  purchaseModal.setContent(getPurchaseDirectionPage());
  // 모달창 열기
  purchaseModal.open();
}

function getPurchaseDirectionPage() {
  console.log("통과");
  return "Hi";
}