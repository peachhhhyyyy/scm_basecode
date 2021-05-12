package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.SupplierInfoModel;

public interface SupplierInfoDao {
  public List<SupplierInfoModel> getSupplierInfo(Map<String, Object> paramMap) throws Exception;
  
  public int countSupplierInfo(Map<String, Object> paramMap) throws Exception;
}
