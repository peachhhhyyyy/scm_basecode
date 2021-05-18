package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.MainProductInfoModel;

public interface MainProductInfoService {
  /* 제품 목록 조회 */
  public List<MainProductInfoModel> listMainProduct(Map<String, Object> paramMap) throws Exception;
  
  /* 제품 목록 카운트 조회 */
  public int totalCntMainProduct(Map<String, Object> paramMap) throws Exception;
  
  /* 제품 상세정보 조회*/
  public MainProductInfoModel selectMainProduct(Map<String, Object> paramMap) throws Exception;
}
