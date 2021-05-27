package kr.happyjob.study.ctm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.ctm.dao.OrderDao;
import kr.happyjob.study.ctm.model.OrderModel;

@Service
public class OrderServiceImpl implements OrderService {
  @Autowired //service에서는 controller,DAO와 연결되어 있다.
  OrderDao OrderDao;
  
  //공급처 목록 조회
  @Override
  public List<OrderModel> listProduct(Map<String, Object> paramMap) throws Exception {
    List<OrderModel> listProduct = OrderDao.listProduct(paramMap);
    return listProduct;
  }
  //공급처 목록 카운트
  @Override
  public int totalCntProduct(Map<String, Object> paramMap) throws Exception {
    int totalCntProduct = OrderDao.totalCntProduct(paramMap);
    return totalCntProduct;
  }
}