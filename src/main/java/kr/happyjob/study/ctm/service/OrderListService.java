package kr.happyjob.study.ctm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ctm.model.OrderListModel;

public interface OrderListService {
  /* 주문이력 조회*/
  List<OrderListModel> orderHisList(Map<String, Object> paramMap) throws Exception;
  /* 주문이력 카운트 조회*/
  int totalCntOrder(Map<String, Object> paramMap) throws Exception;
}
