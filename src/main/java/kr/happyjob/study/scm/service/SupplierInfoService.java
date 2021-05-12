package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.SupplierInfoModel;

public interface SupplierInfoService {
  
  List<SupplierInfoModel> getSupplierInfo(Map<String, Object> paramMap) throws Exception;
  
  int countSupplierInfo(Map<String, Object> paramMap) throws Exception;
  
}
