package kr.happyjob.study.pcs.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pcs.model.RefundModel;

public interface RefundDao {
  
  // 반품서 목록 조회(기본)
  public List<RefundModel> selectList(Map<String, Object> paramMap);
 
  // 반품서 목록 총 개수 조회
  public int countList();
}
