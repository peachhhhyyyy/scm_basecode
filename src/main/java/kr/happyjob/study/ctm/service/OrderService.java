package kr.happyjob.study.ctm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ctm.model.OrderModel;

public interface OrderService {
  /* 공급처 목록 조회*/
  List<OrderModel> productList(Map<String, Object> paramMap) throws Exception;
  /* 공급처 목록 카운트 조회*/
  int totalCntProduct(Map<String, Object> paramMap) throws Exception;
}
