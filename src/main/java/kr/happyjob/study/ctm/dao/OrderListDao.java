package kr.happyjob.study.ctm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ctm.model.OrderListModel;

public interface OrderListDao {
  
  // 공급처 목록 조회
  public List<OrderListModel> listProduct(Map<String, Object> paramMap) throws Exception;
  // 공급처 목록 갯수 조회
  public int totalCntProduct(Map<String, Object> paramMap) throws Exception;

}