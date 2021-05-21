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
  public List<SupplierInfoModel> listSupplier(Map<String, Object> paramMap) throws Exception {
    List<SupplierInfoModel> listSupplier = supplierInfoDao.listSupplier(paramMap);
    return listSupplier;
  }
  //공급처 목록 카운트
  @Override
  public int totalCntSupplier(Map<String, Object> paramMap) throws Exception {
    int totalCntSupplier = supplierInfoDao.totalCntSupplier(paramMap);
    return totalCntSupplier;
  }
  
  //제품정보 목록 조회
  @Override
  public List<SupplierInfoModel> listSupplierProduct(Map<String, Object> paramMap) throws Exception{
    List<SupplierInfoModel> listSupplierProduct = supplierInfoDao.listSupplierProduct(paramMap);
    return listSupplierProduct;
  }
  //제품정보 목록 카운트
  @Override
  public int totalCntProduct(Map<String, Object>paramMap) throws Exception{
    int totalCntProduct = supplierInfoDao.totalCntProduct(paramMap);
    return totalCntProduct;
  }
  //공급처 단건 조회
  @Override
  public SupplierInfoModel selectSupplier(Map<String, Object> paramMap) throws Exception {
    SupplierInfoModel selectSupplier = supplierInfoDao.selectSupplier(paramMap);
    return selectSupplier;
  }
  
  //공급처 등록
  @Override
  public int insertSupplier(Map<String, Object> paramMap) throws Exception {
    int ret = supplierInfoDao.insertSupplier(paramMap);
    return ret;
  }
  //공급처 수정
  @Override
  public int updateSupplier(Map<String, Object> paramMap) throws Exception {
    int ret = supplierInfoDao.updateSupplier(paramMap);
    return ret;
  }
  //공급처 삭제
  @Override
  public int deleteSupplier(Map<String, Object> paramMap) throws Exception {
    int ret = supplierInfoDao.deleteSupplier(paramMap);
    return ret;
  }

}
