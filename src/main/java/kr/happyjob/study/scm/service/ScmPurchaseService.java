package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ScmPurchaseModel;

public interface ScmPurchaseService {
  /** 발주지시서 목록 조회 */
  public List<ScmPurchaseModel> scmPcsOrderingOrder(Map<String, Object> paramMap);
  
  /** 발주지시서 목록 카운트 조회 */
  public int countScmPcsOrderingOrder(Map<String, Object> paramMap);
}
