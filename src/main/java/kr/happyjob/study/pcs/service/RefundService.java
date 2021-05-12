package kr.happyjob.study.pcs.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pcs.model.RefundModel;

public interface RefundService {
  
  // 반품서 목록 조회(기본)
  public List<RefundModel> selectRefundList(Map<String, Object> paramMap) throws Exception;
 
  // 반품서 목록 총 개수 조회
  public int countRefundList() throws Exception;
  
  // 반품서 단건 조회
  public RefundModel selectOneRefund(String refund_list_no) throws Exception;
}
