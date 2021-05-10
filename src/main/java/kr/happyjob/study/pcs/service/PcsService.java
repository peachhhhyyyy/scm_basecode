package kr.happyjob.study.pcs.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pcs.model.PcsModel;

public interface PcsService {
  /** 발주지시서 목록 조회 */
  public List<PcsModel> pcsOrderingOrder(Map<String, Object> paramMap) throws Exception;
  
  /** 발주지시서 목록 카운트 조회 */
  public int countPcsOrderingOrder(Map<String, Object> paramMap) throws Exception;
}