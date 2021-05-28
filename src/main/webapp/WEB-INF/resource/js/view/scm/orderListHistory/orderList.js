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
  currentPage : currentPage,
  pageSize : pageSizeOrderList
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
  // 기존 목록 삭제
  $('#orderListHistory').empty().append(data);

  // 총 개수 추출
  var totalCnt = $("#totcnt").val();
  console.log(totalCnt);
  // 페이지 네비게이션 생성
  var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSizeOrderList, pageBlockSizeOrderList, 'searchOrderList');

  $("#orderListPagination").empty().append(paginationHtml);

  // 현재 페이지 설정
  $("#currentPage").val(currentPage);

};

// 입금대기 상태일때 배송,발주 버튼 클릭할 때 나타나는 경고창
function fnotYetDeposit() {
  swal("아직 입금이 완료되지 않았습니다.");
  return;
};

// 재고량이 주문량보다 적을 때, 배송버튼 누르면 나타나는 경고창
function fnotEnoughStock() {
  swal("발주버튼을 눌러 재고 입고를 진행해주세요.");
  return;
};

function fgoToDeliveryBtn() {
  swal("배송버튼을 눌러 배송을 진행해주세요.");
  return;
};

function fgoToDeliveryBtn2() {
  swal("배송버튼을 눌러 배송을 진행해주세요.");
  return;
};

// 모달창 만들기
// instanciate new modal
// 구매버튼 모달창 만들기
var purchaseModal = new tingle.modal({
footer : true,
stickyFooter : false,
closeMethods : [ 'button' ],
closeLabel : "Close",
cssClass : [ 'custom-class-1', 'custom-class-2' ],
onOpen : function() {
  console.log('modal open');
},
onClose : function() {
  console.log('modal closed');
},
beforeClose : function() {
  // here's goes some logic
  // e.g. save content before closing the modal
  return true; // close the modal
  return false; // nothing happens
}
});

// add a button
purchaseModal.addFooterBtn('승인요청', 'tingle-btn tingle-btn--primary', function() {
  // here goes some logic
  console.log($("#purchaseDirectionInfo"));
  var param = $("#purchaseDirectionInfo").serialize();

  console.log(param);
  var resultCallback = function(data) {
    getUpdateMessage(data);
  }

  callAjax("/scm/sendPurchaseDirection.do", "post", "json", true, param, resultCallback);
  purchaseModal.close();
});

// add another button
purchaseModal.addFooterBtn('취소', 'tingle-btn tingle-btn--danger', function() {
  purchaseModal.close();
});

function purchaseModalOpen(orderCode) {
  // set content
  // 앞에서 한 것들과 다르게 결과 데이터를 아이디를 가지고 있는 태그에  append하는게 아닌 html을
  // return해서 setContent 안에 넣어야함.
  makePurchaseDirection(orderCode)
  // 금액 (숫자, 한글) 바로 나오도록
  // 모달창 열기
  purchaseModal.open();
}

function makePurchaseDirection(orderCode) {
  console.log("=== 1.발주지시서 모달창에 뿌릴 데이터 가져오기 시작 ===");

  var param = {
    orderCode : orderCode
  };

  var resultCallback = function(data) {
    makePurchaseDirectionResult(data);
  };

  // Ajax 실행 방식
  // callAjax("Url", type, return, async or sync방식, 넘겨준거, Callback함수 이름)
  // html로 받을거라 text
  callAjax("/scm/productInfo.do", "post", "text", true, param, resultCallback);
}

function makePurchaseDirectionResult(data) {
  purchaseModal.setContent(data);
  return;
}

function purchaseMultiply() {
  var price = parseInt($("input[name=hidden_purchasePrice]").val());
  var cnt = $("#purchaseCount").val();
  var result = price * cnt;

  $("#sumAmt").empty().append("합계 (원) : " + result.toLocaleString('ko-KR'));
  $("#sumAmt-han").empty().append(num2han(result) + "원");
  $("input[name=purchaseCount").empty().val(cnt);
  $("input[name=totalAmount]").empty().val(result);
  return;
}

//숫자를 한글로
//출처: https://sub0709.tistory.com/93 [쓸데없는 코딩하기]
function num2han(num) {
  num = parseInt((num + '').replace(/[^0-9]/g, ''), 10) + ''; // 숫자/문자/돈 을 숫자만
  // 있는 문자열로 변환
  if (num == '0')
    return '영';
  var number = [ '영', '일', '이', '삼', '사', '오', '육', '칠', '팔', '구' ];
  var unit = [ '', '만', '억', '조' ];
  var smallUnit = [ '천', '백', '십', '' ];
  var result = []; // 변환된 값을 저장할 배열
  var unitCnt = Math.ceil(num.length / 4); // 단위 갯수. 숫자 10000은 일단위와 만단위 2개이다.
  num = num.padStart(unitCnt * 4, '0') // 4자리 값이 되도록 0을 채운다
  var regexp = /[\w\W]{4}/g; // 4자리 단위로 숫자 분리
  var array = num.match(regexp);
  // 낮은 자릿수에서 높은 자릿수 순으로 값을 만든다(그래야 자릿수 계산이 편하다)
  for (var i = array.length - 1, unitCnt = 0; i >= 0; i--, unitCnt++) {
    var hanValue = _makeHan(array[i]); // 한글로 변환된 숫자
    if (hanValue == '') // 값이 없을땐 해당 단위의 값이 모두 0이란 뜻.
      continue;
    result.unshift(hanValue + unit[unitCnt]); // unshift는 항상 배열의 앞에 넣는다.
  }
  // 여기로 들어오는 값은 무조건 네자리이다. 1234 -> 일천이백삼십사
  function _makeHan(text) {
    var str = '';
    for (var i = 0; i < text.length; i++) {
      var num = text[i];
      if (num == '0') // 0은 읽지 않는다
        continue;
      str += number[num] + smallUnit[i];
    }
    return str;
  }
  return result.join('');
}

/* 
 * 배송지시서 화면
 */
var deliveryModal = new tingle.modal({
footer : true,
stickyFooter : false,
closeMethods : [ 'button' ],
closeLabel : "Close",
cssClass : [ 'custom-class-1', 'custom-class-2' ],
onOpen : function() {
  console.log('modal open');
},
onClose : function() {
  console.log('modal closed');
},
beforeClose : function() {
  // here's goes some logic
  // e.g. save content before closing the modal
  return true; // close the modal
  return false; // nothing happens
}
});

//add a button
deliveryModal.addFooterBtn('요청', 'tingle-btn tingle-btn--primary', function() {
  var param = $("#deliveryDirectionInfo").serialize();

  var resultCallback = function(data) {
    getUpdateMessage(data);
  }

  callAjax("/scm/sendDeliveryDirection.do", "post", "json", true, param, resultCallback);
  deliveryModal.close();
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
deliveryModal.addFooterBtn('취소', 'tingle-btn tingle-btn--danger', function() {
  deliveryModal.close();
});

function deliveryModalOpen(orderCode) {
  // set content
  // 앞에서 한 것들과 다르게 결과 데이터를 아이디를 가지고 있는 태그에  append하는게 아닌 html을
  // return해서 setContent 안에 넣어야함.
  makeDeliveryDirection(orderCode)
  // 모달창 열기
  deliveryModal.open();
}

function makeDeliveryDirection(orderCode) {
  console.log("=== 1.배송지시서 모달창에 뿌릴 데이터 가져오기 시작 ===");

  var param = {
    orderCode : orderCode
  };

  var resultCallback = function(data) {
    makeDeliveryDirectionResult(data);
  };

  callAjax("/scm/deliveryInfo.do", "post", "text", true, param, resultCallback);
  return;
}

function makeDeliveryDirectionResult(data) {
  // callAjax에서 받은 html data string을 모달창에 입력
  deliveryModal.setContent(data);
  return;
}

// 수주내역 검색 기능
function searchOrderList(currentPage) {
  var param = $('#orderListForm').serialize();
  
  currentPage = currentPage || 1;
  
  param += "&currentPage="+currentPage;
  param += "&pageSize="+pageSizeOrderList;
  
  var startD = $('#startDate').val();
  var endD = $('#endDate').val();
  
  // 날짜 에러 있을 때, 경고창 띄우고 refresh
  if (startD > endD) {
    swal("시작일자가 종료일자보다 뒤에 있을 수 없습니다.\n날짜를 다시 지정해주세요.").then(function() {
      window.location.reload();
    });
    return 0;
  } 
  
//  else if (startD == '' || endD == '') {
//    swal("날짜를 입력해주세요.").then(function() {
//      window.location.reload();
//    });
//
//  }

  var resultCallback = function(data) {
    // 수주내역 기본 조회 result 함수를 그대로 사용. HTML 내용만 바꿔주는 것이기 때문
    // pagenation도 그대로 사용 할 수 있음
    forderListHistoryResult(data, currentPage);
  };
  
  callAjax("/scm/listInfo.do", "post", "text", true, param, resultCallback);
}

