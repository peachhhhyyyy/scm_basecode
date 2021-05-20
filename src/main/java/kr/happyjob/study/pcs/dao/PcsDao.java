package kr.happyjob.study.pcs.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pcs.model.PcsModel;

public interface PcsDao {
  /** 발주지시서 목록 조회 */
  public List<PcsModel> pcsOrderingOrder(Map<String, Object> paramMap);
  
  /** 발주지시서 목록 카운트 조회 */
  public int countPcsOrderingOrder(Map<String, Object> paramMap);
  
  /** 발주지시서 발주버튼 클릭시 조회 */
  public PcsModel selectPurchBtn(Map<String, Object> paramMap);
  
  /** 발주서 목록 조회 */
  public List<PcsModel> pcsOrderForm(Map<String, Object> paramMap);
  
  /** 발주서 목록 카운트 조회 */
  public int countPcsOrderForm(Map<String, Object> paramMap);
  
  /** 발주서 상태 변경 */
  public int updateSTTcd(Map<String, Object> paramMap);
  
  /** 발주서 검색 */
  public List<PcsModel> searchOrderForm(Map<String, Object> paramMap);
  
  /** 발주서 검색 카운트 조회 */
  public int searchOrderFormCnt(Map<String, Object> paramMap);
}