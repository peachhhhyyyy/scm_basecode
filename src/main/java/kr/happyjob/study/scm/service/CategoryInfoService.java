package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.CategoryInfoModel;

public interface CategoryInfoService {
  /* 품목 목록 조회*/
  List<CategoryInfoModel> listLargeCategory(Map<String, Object> paramMap) throws Exception;
  /* 품목 목록 카운트 조회*/
  int totalCntLargeCategory(Map<String, Object> paramMap) throws Exception;
  
  /* 상호 목록 조회*/
  List<CategoryInfoModel> listMiddleCategory(Map<String, Object> paramMap) throws Exception;
  /* 상호 목록 카운트 조회*/
  int totalCntMiddleCategory(Map<String, Object> paramMap) throws Exception;
  
  /* 품목 단건 조회*/
  public CategoryInfoModel selectLargeCategory(Map<String, Object> paraMap) throws Exception;
}
