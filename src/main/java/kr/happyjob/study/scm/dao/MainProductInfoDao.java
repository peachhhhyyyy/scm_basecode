package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.MainProductInfoModel;

public interface MainProductInfoDao {
  //제품 목록 조회
  public List<MainProductInfoModel> listMainProduct(Map<String, Object> paramMap) throws Exception;
  //제품 카운트
  public int totalCntMainProduct(Map<String, Object> paramMap) throws Exception;
  
}
