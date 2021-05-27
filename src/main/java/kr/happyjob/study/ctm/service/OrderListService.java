package kr.happyjob.study.ctm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ctm.model.OrderListModel;

public interface OrderListService {
  /* 공급처 목록 조회*/
  List<OrderListModel> listProduct(Map<String, Object> paramMap) throws Exception;
  /* 공급처 목록 카운트 조회*/
  int totalCntProduct(Map<String, Object> paramMap) throws Exception;
}
