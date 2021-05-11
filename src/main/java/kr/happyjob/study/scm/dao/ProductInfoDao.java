package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ProductInfoModel;

public interface ProductInfoDao {
  /** 목록 조회 */
  public List<ProductInfoModel> selectProductInfo(Map<String, Object> paramMap) throws Exception;
  
  
  public List<ProductInfoModel> selectProductDetail(Map<String, Object> paramMap) throws Exception;
  /** 목록 카운트 조회 */
  public int countProductInfo(Map<String, Object> paramMap) throws Exception;
  
  public int insertProdInfo(Map<String, Object> paramMap) throws Exception;
  
  public int deleteProdInfo(Map<String, Object> paramMap) throws Exception;
  
  public int updateProdInfo(Map<String, Object> paramMap) throws Exception;
  
}
