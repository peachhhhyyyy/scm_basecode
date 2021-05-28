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
  
  //품목 단건 조회
  @Override
  public CategoryInfoModel selectLargeCategory(Map<String, Object> paramMap) throws Exception {
    CategoryInfoModel selectLargeCategory = categoryInfoDao.selectLargeCategory(paramMap);
    return selectLargeCategory;
  } 
  //품목 등록
  @Override
  public int insertLargeCategory(Map<String, Object> paramMap) throws Exception {
    int ret = categoryInfoDao.insertLargeCategory(paramMap);
    return ret;
  }
  //품목 수정
  @Override
  public int updateLargeCategory(Map<String, Object> paramMap) throws Exception {
    int ret = categoryInfoDao.updateLargeCategory(paramMap);
    return ret;
  }
  //품목 삭제
  @Override
  public int deleteLargeCategory(Map<String, Object> paramMap) throws Exception {
    int ret = categoryInfoDao.deleteLargeCategory(paramMap);
    return ret;
  }
  //상호 단건 조회
  @Override
  public CategoryInfoModel selectMiddleCategory(Map<String, Object> paramMap) throws Exception {
    CategoryInfoModel selectMiddleCategory = categoryInfoDao.selectMiddleCategory(paramMap);
    return selectMiddleCategory;
  } 
  //품목 등록
  @Override
  public int insertMiddleCategory(Map<String, Object> paramMap) throws Exception {
    int ret = categoryInfoDao.insertMiddleCategory(paramMap);
    return ret;
  }
  //품목 수정
  @Override
  public int updateMiddleCategory(Map<String, Object> paramMap) throws Exception {
    int ret = categoryInfoDao.updateMiddleCategory(paramMap);
    return ret;
  }
  //품목 삭제
  @Override
  public int deleteMiddleCategory(Map<String, Object> paramMap) throws Exception {
    int ret = categoryInfoDao.deleteMiddleCategory(paramMap);
    return ret;
  }
}
