package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.WarehouseInfoModel;

public interface WarehouseInfoService {
  /* 창고 목록 조회 */
  public List<WarehouseInfoModel> listWarehouse(Map<String, Object> paramMap) throws Exception;
  
  /* 창고 목록 카운트 조회 */
  public int totalCntWarehouse(Map<String, Object> paramMap) throws Exception;
  
  /* 제품 목록 조회 */
  public List<WarehouseInfoModel> listWarehouseProduct(Map<String, Object> paramMap) throws Exception;
  
  /* 제품 목록 카운트 조회 */
  public int totalCntProduct(Map<String, Object> paramMap) throws Exception;
}
