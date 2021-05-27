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
  
  //공급처 목록 조회
  @Override
  public List<OrderListModel> listProduct(Map<String, Object> paramMap) throws Exception {
    List<OrderListModel> listProduct = OrderListDao.listProduct(paramMap);
    return listProduct;
  }
  //공급처 목록 카운트
  @Override
  public int totalCntProduct(Map<String, Object> paramMap) throws Exception {
    int totalCntProduct = OrderListDao.totalCntProduct(paramMap);
    return totalCntProduct;
  }
}