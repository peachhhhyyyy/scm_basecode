package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.CategoryInfoModel;

public interface CategoryInfoDao {
 //품목 목록 조회
 public List<CategoryInfoModel> listLargeCategory(Map<String, Object> paramMap) throws Exception;
 //품목 목록 갯수 조회
 public int totalCntLargeCategory(Map<String, Object> paramMap) throws Exception;
}
