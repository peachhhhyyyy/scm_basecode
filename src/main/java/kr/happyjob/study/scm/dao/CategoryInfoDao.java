package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.CategoryInfoModel;

public interface CategoryInfoDao {
 //품목 목록 조회
 public List<CategoryInfoModel> listLargeCategory(Map<String, Object> paramMap) throws Exception;
 //품목 목록 갯수 조회
 public int totalCntLargeCategory(Map<String, Object> paramMap) throws Exception;
 
 //상호 목록 조회
 public List<CategoryInfoModel> listMiddleCategory(Map<String, Object> paramMap) throws Exception;
 //상호 목록 갯수 조회
 public int totalCntMiddleCategory(Map<String, Object> paramMap) throws Exception;
 
 //품목 단건 조회
 public CategoryInfoModel selectLargeCategory(Map<String, Object> paraMap) throws Exception;
 /* 품목 등록*/
 int insertLargeCategory(Map<String, Object> paramMap) throws Exception;
 /* 품목 수정*/
 int updateLargeCategory(Map<String, Object> paramMap) throws Exception;
 /* 품목 삭제*/
 int deleteLargeCategory(Map<String, Object> paramMap) throws Exception;
 //상호 단건 조회
 public CategoryInfoModel selectMiddleCategory(Map<String, Object> paraMap) throws Exception;
 /* 상호 등록*/
 int insertMiddleCategory(Map<String, Object> paramMap) throws Exception;
 /* 상호 수정*/
 int updateMiddleCategory(Map<String, Object> paramMap) throws Exception;
 /* 상호 삭제*/
 int deleteMiddleCategory(Map<String, Object> paramMap) throws Exception;
}
