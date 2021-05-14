package kr.happyjob.study.pcs.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pcs.model.RefundDetailModel;
import kr.happyjob.study.pcs.model.RefundListModel;

public interface RefundDao {
  
  // 반품서 목록 조회(기본)
  public List<RefundDetailModel> selectRefundList(Map<String, Object> paramMap);
 
  // 반품서 목록 총 개수 조회
  public int countRefundList();
  
  // 반품서 단건 조회
  public RefundDetailModel selectOneRefund(int refund_list_no);
  
  // 반품 완료 처리
  public int insertReturnDate(int purch_list_no);

}
