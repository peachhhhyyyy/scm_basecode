package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.MainProductInfoDao;
import kr.happyjob.study.scm.model.MainProductInfoModel;

@Service
public class MainProductInfoServiceImpl implements MainProductInfoService{
  
  @Autowired
  MainProductInfoDao mainProductInfoDao;
  
//창고 목록 조회
 @Override
 public List<MainProductInfoModel> listMainProduct(Map<String, Object> paramMap) throws Exception {

   List<MainProductInfoModel> listMainProduct = mainProductInfoDao.listMainProduct(paramMap);
  return listMainProduct;
 }
 
 // 창고 카운트
 @Override
 public int totalCntMainProduct(Map<String, Object> paramMap) throws Exception {
   int totalCntMainProduct = mainProductInfoDao.totalCntMainProduct(paramMap);
   return totalCntMainProduct;
 }
}
