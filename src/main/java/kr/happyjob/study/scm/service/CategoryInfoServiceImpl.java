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
  
  //공급처 목록 조회
  @Override
  public List<CategoryInfoModel> listLargeCategory(Map<String, Object> paramMap) throws Exception {
    List<CategoryInfoModel> listLargeCategory = categoryInfoDao.listLargeCategory(paramMap);
    return listLargeCategory;
  }
  //공급처 목록 카운트
  @Override
  public int totalCntLargeCategory(Map<String, Object> paramMap) throws Exception {
    int totalCntLargeCategory = categoryInfoDao.totalCntLargeCategory(paramMap);
    return totalCntLargeCategory;
  }
}
