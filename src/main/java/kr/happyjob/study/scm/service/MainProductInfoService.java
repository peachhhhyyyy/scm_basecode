package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.GetWarehouseModel;
import kr.happyjob.study.scm.model.MainProductInfoModel;

public interface MainProductInfoService {
  /* 제품 목록 조회 */
  public List<MainProductInfoModel> listMainProduct(Map<String, Object> paramMap) throws Exception;
  
  /* 제품 목록 카운트 조회 */
  public int totalCntMainProduct(Map<String, Object> paramMap) throws Exception;
  
  /* 제품 상세정보 조회*/
  public MainProductInfoModel selectMainProduct(Map<String, Object> paramMap) throws Exception;
  
  /* 창고정보 조회*/
  public GetWarehouseModel getWarehouseInfo(Map<String, Object> paramMap)throws Exception;
  /* 제품정보 저장 */
  public int insertMainProduct(Map<String, Object> paramMap) throws Exception;
  
  /* 제품정보 수정 */
  public int updateMainProduct(Map<String, Object> paramMap) throws Exception;
  
  /* 제품정보 삭제 */
  public int deleteMainProduct(Map<String, Object> paramMap) throws Exception;
}
