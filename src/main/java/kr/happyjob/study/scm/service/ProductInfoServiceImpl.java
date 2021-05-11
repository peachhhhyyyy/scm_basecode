package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.happyjob.study.scm.dao.ProductInfoDao;
import kr.happyjob.study.scm.model.ProductInfoModel;

@Service
public class ProductInfoServiceImpl implements ProductInfoService {
  
  @Autowired
  ProductInfoDao producInfoDao;
  
  @Override
  public List<ProductInfoModel> selectProductInfo(Map<String, Object> paramMap) throws Exception {
    List<ProductInfoModel> productList = producInfoDao.selectProductInfo(paramMap);
    return productList;
  }
  
  @Override
  public int countProductInfo(Map<String, Object> paramMap) throws Exception {
    int productCount = producInfoDao.countProductInfo(paramMap);
    return productCount;
  }
  
  @Override
  public List<ProductInfoModel> selectProductDetail(Map<String, Object> paramMap) throws Exception {
    List<ProductInfoModel> detail = producInfoDao.selectProductDetail(paramMap);
    return detail;
  }
  
  @Transactional
  @Override
  public boolean insertProduct(Map<String, Object> paramMap, HttpServletRequest request) {
    return true;
  }
  
  @Transactional
  @Override
  public boolean deleteProduct(Map<String, Object> paramMap, HttpServletRequest request) {
    return true;
  }
  
  @Override
  public boolean updateProduct(Map<String, Object> paramMap, HttpServletRequest request) {
    return true;
  }
  
}
