package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.MainProductInfoDao;
import kr.happyjob.study.scm.model.GetWarehouseModel;
import kr.happyjob.study.scm.model.MainProductInfoModel;

@Service
public class MainProductInfoServiceImpl implements MainProductInfoService {
  
  @Autowired
  MainProductInfoDao mainProductInfoDao;
  
  // 제품 목록 조회
  @Override
  public List<MainProductInfoModel> listMainProduct(Map<String, Object> paramMap) throws Exception {
    List<MainProductInfoModel> listMainProduct = mainProductInfoDao.listMainProduct(paramMap);
    return listMainProduct;
  }
  
  // 제품 카운트
  @Override
  public int totalCntMainProduct(Map<String, Object> paramMap) throws Exception {
    int totalCntMainProduct = mainProductInfoDao.totalCntMainProduct(paramMap);
    return totalCntMainProduct;
  }
  
  // 제품정보 상세조회
  @Override
  public MainProductInfoModel selectMainProduct(Map<String, Object> paramMap) throws Exception {
    MainProductInfoModel selectMainProduct = mainProductInfoDao.selectMainProduct(paramMap);
    return selectMainProduct;
  }
  
  // 창고정보 조회
  @Override
  public  GetWarehouseModel getWarehouseInfo(Map<String, Object> paramMap) throws Exception {
    GetWarehouseModel getWarehouseInfo = mainProductInfoDao.getWarehouseInfo(paramMap);
    return getWarehouseInfo;
  };
  
  // 제품정보 저장
  @Override
  public int insertMainProduct(Map<String, Object> paramMap) throws Exception {
    int ret = mainProductInfoDao.insertMainProduct(paramMap);
    return ret;
  };
  
  // 제품정보 수정
  @Override
  public int updateMainProduct(Map<String, Object> paramMap) throws Exception {
    int ret = mainProductInfoDao.updateMainProduct(paramMap);
    return ret;
  };
  
  // 제품정보 삭제
  @Override
  public int deleteMainProduct(Map<String, Object> paramMap) throws Exception {
    int ret = mainProductInfoDao.deleteMainProduct(paramMap);
    return ret;
  };
}
