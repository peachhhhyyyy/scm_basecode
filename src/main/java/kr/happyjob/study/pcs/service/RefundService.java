package kr.happyjob.study.pcs.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pcs.model.RefundDetailModel;

public interface RefundService {
  
  // 반품서 목록 조회(기본)
  public List<RefundDetailModel> selectRefundList(Map<String, Object> param) throws Exception;
 
  // 반품서 목록 총 개수 조회
  public int countRefundList() throws Exception;
  
  // 반품서 검색 목록 총 개수 조회
  public int countConditionList(Map<String, Object> param) throws Exception;
  
  // 반품서 단건 조회
  public RefundDetailModel selectOneRefund(int refund_list_no) throws Exception;
  
  // 반품 완료 처리
  public int insertReturnDate(int purch_list_no) throws Exception;

  // 환불액 입금 처리
  public int insertAmt(Map<String, Object> param) throws Exception;

}
