package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.scm.model.ProductInfoModel;

public interface ProductInfoService {

  List<ProductInfoModel> selectProductInfo(Map<String, Object> paramMap) throws Exception;
  List<ProductInfoModel> selectProductDetail(Map<String, Object> paramMap) throws Exception;
  int countProductInfo(Map<String, Object> paramMap) throws Exception;
  boolean insertProduct(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
  boolean deleteProduct(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
  boolean updateProduct(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
}