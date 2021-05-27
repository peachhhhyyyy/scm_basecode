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
  
  //공급처 단건 조회
  @Override
  public OrderModel selectProduct(Map<String, Object> paramMap) throws Exception {
    OrderModel selectProduct = OrderDao.selectProduct(paramMap);
    return selectProduct;
  }
  
  //공급처 등록
  @Override
  public int insertProduct(Map<String, Object> paramMap) throws Exception {
    int ret = OrderDao.insertProduct(paramMap);
    return ret;
  }
  //공급처 수정
  @Override
  public int updateProduct(Map<String, Object> paramMap) throws Exception {
    int ret = OrderDao.updateProduct(paramMap);
    return ret;
  }
  //공급처 삭제
  @Override
  public int deleteProduct(Map<String, Object> paramMap) throws Exception {
    int ret = OrderDao.deleteProduct(paramMap);
    return ret;
  }

}