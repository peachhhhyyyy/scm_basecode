package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.SupplierInfoModel;

public interface SupplierInfoDao {
  /* 목록 조회 */
  public List<SupplierInfoModel> getSupplierInfo(Map<String, Object> paramMap) throws Exception;
  
  /* 목록 카운트 조회*/
  public List<SupplierInfoModel> countSupplierInfo(Map<String, Object> paramMap) throws Exception;
}
