package kr.happyjob.study.pcs.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pcs.model.PcsModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

public interface PcsService {
  /** 발주지시서 목록 조회 */
  public List<PcsModel> pcsOrderingOrder(Map<String, Object> paramMap);
  
  /** 발주지시서 목록 카운트 조회 */
  public int countPcsOrderingOrder(Map<String, Object> paramMap);
  
  /** 발주지시서 발주버튼 클릭시 조회 */
  public PcsModel selectPurchBtn(Map<String, Object> paramMap);
  
  /** 발주지시서 상태 변경 */
  public int updateState(Map<String, Object> paramMap);

  /** 발주서 목록 조회 */
  public List<PcsModel> pcsOrderForm(Map<String, Object> paramMap);
  
  /** 발주서 목록 카운트 조회 */
  public int countPcsOrderForm(Map<String, Object> paramMap);
  
  /** 발주서 상태 변경 */
  public int updateSTTcd(Map<String, Object> paramMap);
  
  /** 발주서 반품버튼 클릭시 조회 */
  public PcsModel selectRefundBtn(Map<String, Object> paramMap);
  
  /** 입고완료 누르면 재고 업데이트*/
  public int updateStock(Map<String, Object> paramMap);
}