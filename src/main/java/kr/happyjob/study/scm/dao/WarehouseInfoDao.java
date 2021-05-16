package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.WarehouseInfoModel;

public interface WarehouseInfoDao {
  //창고 목록 조회
  public List<WarehouseInfoModel> listWarehouse(Map<String, Object> paramMap) throws Exception;
  //창고 카운트
  public int totalCntWarehouse(Map<String, Object> paramMap) throws Exception;
}
