package kr.happyjob.study.pcs.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.pcs.dao.RefundDao;
import kr.happyjob.study.pcs.model.RefundDetailModel;

@Service
public class RefundServiceImpl implements RefundService {
  
  @Autowired
  RefundDao refundDao;
  
  // 반품서 목록 조회(기본)
  @Override
  public List<RefundDetailModel> selectRefundList(Map<String, Object> paramMap) throws Exception {
    return refundDao.selectRefundList(paramMap);
  }
  
  // 반품서 목록 총 개수 조회
  @Override
  public int countRefundList() throws Exception {
    return refundDao.countRefundList();
  }

  // 반품서 단건 조회
  @Override
  public RefundDetailModel selectOneRefund(int refund_list_no) throws Exception {
    // TODO Auto-generated method stub
    return refundDao.selectOneRefund(refund_list_no);
  }

  // 반품 완료 처리
  @Override
  public int insertReturnDate(int purch_list_no) throws Exception {
    // TODO Auto-generated method stub
    return refundDao.insertReturnDate(purch_list_no);
  }

  
}
