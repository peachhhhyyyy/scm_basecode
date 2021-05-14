package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.SupplierInfoDao;
import kr.happyjob.study.scm.model.SupplierInfoModel;

@Service
public class SupplierInfoServiceImpl implements SupplierInfoService {
  @Autowired //service에서는 controller,DAO와 연결되어 있다.
  SupplierInfoDao supplierInfoDao;
  
  //공급처 목록 조회
  @Override
  public List<SupplierInfoModel> getSupplierInfo(Map<String, Object> paramMap) throws Exception {
    List<SupplierInfoModel> supplierList = supplierInfoDao.getSupplierInfo(paramMap);
    return supplierList;
  }
  //공급처 목록 카운트
  @Override
  public int countSupplierInfo(Map<String, Object> paramMap) throws Exception {
    int supllierCount = supplierInfoDao.countSupplierInfo(paramMap);
    return supllierCount;
  }
  
  //제품정보 목록 조회
  @Override
  public List<SupplierInfoModel> getSupplierProInfo(Map<String, Object> paramMap) throws Exception{
    List<SupplierInfoModel> supplierProList = supplierInfoDao.getSupplierProInfo(paramMap);
    return supplierProList;
  }
  //제품정보 목록 카운트
  @Override
  public int countSupplierProInfo(Map<String, Object>paramMap) throws Exception{
    int countSupplierProInfo = supplierInfoDao.countSupplierProInfo(paramMap);
    return countSupplierProInfo;
  }
  //공급처 단건 조회
  @Override
  public SupplierInfoModel selectDelivery(Map<String, Object> paramMap) throws Exception {
    SupplierInfoModel selectDelivery = supplierInfoDao.selectDelivery(paramMap);
    return selectDelivery;
  }
  
  //공급처 등록
  @Override
  public int insertDelivery(Map<String, Object> paramMap) throws Exception {
    int ret = supplierInfoDao.insertDelivery(paramMap);
    return ret;
  }
  //공급처 수정
  @Override
  public int updateDelivery(Map<String, Object> paramMap) throws Exception {
    int ret = supplierInfoDao.updateDelivery(paramMap);
    return ret;
  }

}
