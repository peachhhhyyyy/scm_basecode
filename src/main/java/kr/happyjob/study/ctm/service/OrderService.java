package kr.happyjob.study.ctm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ctm.model.OrderModel;

public interface OrderService {
  /* 공급처 목록 조회*/
  List<OrderModel> listProduct(Map<String, Object> paramMap) throws Exception;
  /* 공급처 목록 카운트 조회*/
  int totalCntProduct(Map<String, Object> paramMap) throws Exception;
  /* 공급처 단건 조회*/
  public OrderModel selectProduct(Map<String, Object> paraMap) throws Exception;
  /* 공급처 등록*/
  int insertProduct(Map<String, Object> paramMap) throws Exception;
  /* 공급처 수정*/
  int updateProduct(Map<String, Object> paramMap) throws Exception;
  /* 공급처 삭제*/
  int deleteProduct(Map<String, Object> paramMap) throws Exception;
}
