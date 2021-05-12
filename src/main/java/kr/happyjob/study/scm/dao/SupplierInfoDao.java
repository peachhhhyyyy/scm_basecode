package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.SupplierInfoModel;

public interface SupplierInfoDao {
  
  // 공급처 목록 조회
  public List<SupplierInfoModel> getSupplierInfo(Map<String, Object> paramMap) throws Exception;
  // 공급처 목록 갯수 조회
  public int countSupplierInfo(Map<String, Object> paramMap) throws Exception;
  
  // 제품정보 목록 조회
  public List<SupplierInfoModel> supplierProList(Map<String, Object> paraMap) throws Exception;
  // 제품정보 목록 갯수 조회
  public int totalCntProduct(Map<String, Object> paramMap) throws Exception;
}
