package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.SupplierInfoDao;
import kr.happyjob.study.scm.model.SupplierInfoModel;

@Service
public class SupplierInfoServiceImpl implements SupplierInfoService {
  
  @Autowired
  SupplierInfoDao supplierInfoDao;
  
  @override
  public List<SupplierInfoModel> getSupplierInfo (Map<String, Object> paramMap) throws Exception {
    List<SupplierInfoModel> supplierList = supplierInfoDao.getSupplerInfo(paramMap);
    return supplierList;
  }
  
  @override
  public int countSupplierInfo(Map<String, Object> paramMap) throws Exception {
    int supplierCount = supplierInfoDao.countsupplierInfo(paramMap);
    return supplierCount;
  }
}
