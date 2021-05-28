package kr.happyjob.study.ctm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.ctm.dao.OrderListDao;
import kr.happyjob.study.ctm.model.OrderListModel;

@Service
public class OrderListServiceImpl implements OrderListService {
  @Autowired //service에서는 controller,DAO와 연결되어 있다.
  OrderListDao OrderListDao;
  
  //주문이력 조회
  @Override
  public List<OrderListModel> orderHisList(Map<String, Object> paramMap) throws Exception {
    List<OrderListModel> orderHisList = OrderListDao.orderHisList(paramMap);
    return orderHisList;
  }
  //주문이력 카운트
  @Override
  public int totalCntOrder(Map<String, Object> paramMap) throws Exception {
    int totalCntOrder = OrderListDao.totalCntOrder(paramMap);
    return totalCntOrder;
  }
}