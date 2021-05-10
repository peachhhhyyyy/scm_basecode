package kr.happyjob.study.pcs.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.happyjob.study.pcs.model.PcsModel;

public interface PcsDao {
  /** 발주지시서 목록 조회 */
  public List<PcsModel> pcsOrderingOrder(Map<String, Object> paramMap);
  
  /** 발주지시서 목록 카운트 조회 */
  public int countPcsOrderingOrder(Map<String, Object> paramMap);
}