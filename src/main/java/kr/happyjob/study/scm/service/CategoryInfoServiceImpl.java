package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.CategoryInfoDao;
import kr.happyjob.study.scm.model.CategoryInfoModel;

@Service
public class CategoryInfoServiceImpl implements CategoryInfoService{
  @Autowired //service에서는 controller,DAO와 연결되어 있다.
  CategoryInfoDao categoryInfoDao;
  
  //품목 목록 조회
  @Override
  public List<CategoryInfoModel> listLargeCategory(Map<String, Object> paramMap) throws Exception {
    List<CategoryInfoModel> listLargeCategory = categoryInfoDao.listLargeCategory(paramMap);
    return listLargeCategory;
  }
  //품목 목록 카운트
  @Override
  public int totalCntLargeCategory(Map<String, Object> paramMap) throws Exception {
    int totalCntLargeCategory = categoryInfoDao.totalCntLargeCategory(paramMap);
    return totalCntLargeCategory;
  }
  
  //상호 목록 조회
  @Override
  public List<CategoryInfoModel> listMiddleCategory(Map<String, Object> paramMap) throws Exception {
    List<CategoryInfoModel> listMiddleCategory = categoryInfoDao.listMiddleCategory(paramMap);
    return listMiddleCategory;
  }
  //상호 목록 카운트
  @Override
  public int totalCntMiddleCategory(Map<String, Object> paramMap) throws Exception {
    int totalCntMiddleCategory = categoryInfoDao.totalCntMiddleCategory(paramMap);
    return totalCntMiddleCategory;
  }
}
