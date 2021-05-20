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
  
//제품 목록 조회
 @Override
 public List<MainProductInfoModel> listMainProduct(Map<String, Object> paramMap) throws Exception {
  List<MainProductInfoModel> listMainProduct = mainProductInfoDao.listMainProduct(paramMap);
  return listMainProduct;
 }
 
 //제품 카운트
 @Override
 public int totalCntMainProduct(Map<String, Object> paramMap) throws Exception {
   int totalCntMainProduct = mainProductInfoDao.totalCntMainProduct(paramMap);
   return totalCntMainProduct;
 }
 
 //제품정보 상세조회
 @Override
 public MainProductInfoModel selectMainProduct(Map<String, Object> paramMap) throws Exception {
   MainProductInfoModel selectMainProduct = mainProductInfoDao.selectMainProduct(paramMap);
   return selectMainProduct;
 }
 
 //제품정보 저장
 public int insertMainProduct(Map<String, Object> paramMap) throws Exception {
   int insertMainProduct = mainProductInfoDao.insertMainProduct(paramMap);
   return insertMainProduct;
 };
 
 //제품정보 수정
 public int updateMainProduct(Map<String, Object> paramMap) throws Exception {
   int updateMainProduct = mainProductInfoDao.updateMainProduct(paramMap);
   return updateMainProduct;
 };
 
 //제품정보 삭제
 public int deleteMainProduct(Map<String, Object> paramMap) throws Exception {
   int deleteMainProduct = mainProductInfoDao.deleteMainProduct(paramMap);
   return deleteMainProduct;
 };
}
