package kr.happyjob.study.ctm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ctm.model.OrderListModel;

public interface OrderListDao {
  
  // 주문이력 조회
  public List<OrderListModel> orderHisList(Map<String, Object> paramMap) throws Exception;
  // 주문이력 갯수 조회
  public int totalCntOrder(Map<String, Object> paramMap) throws Exception;

}