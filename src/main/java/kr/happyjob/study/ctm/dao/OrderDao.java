package kr.happyjob.study.ctm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ctm.model.OrderModel;

public interface OrderDao {
  
  // 공급처 목록 조회
  public List<OrderModel> listProduct(Map<String, Object> paramMap) throws Exception;
  // 공급처 목록 갯수 조회
  public int totalCntProduct(Map<String, Object> paramMap) throws Exception;
  
  // 공급처 단건 조회
  public OrderModel selectProduct(Map<String, Object> paramMap) throws Exception;
  
  // 공급처 추가
  public int insertProduct(Map<String, Object> paramMap) throws Exception;
  // 공급처 수정
  public int updateProduct(Map<String, Object> paramMap) throws Exception;
  // 공급처 삭제
  public int deleteProduct(Map<String, Object> paramMap) throws Exception;
}