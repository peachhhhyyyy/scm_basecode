package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ProdInfoModel;

public interface ProdInfoService {
  /** 지출결의 목록 조회 */
  public List<ProdInfoModel> listProdInfo(Map<String, Object> paramMap) throws Exception;
  
  /** 지출결의 목록 카운트 조회 */
  public int countListProdInfo(Map<String, Object> paramMap) throws Exception;
}
