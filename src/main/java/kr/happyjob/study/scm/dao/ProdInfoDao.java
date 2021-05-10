package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ProdInfoModel;

public interface ProdInfoDao {
  /** 목록 조회 */
  public List<ProdInfoModel> listProdInfo(Map<String, Object> paramMap);
  
  /** 목록 카운트 조회 */
  public int countListProdInfo(Map<String, Object> paramMap);
  
  
}
