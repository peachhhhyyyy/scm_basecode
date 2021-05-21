package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.SupplierInfoModel;

public interface SupplierInfoDao {
  
  // 공급처 목록 조회
  public List<SupplierInfoModel> listSupplier(Map<String, Object> paramMap) throws Exception;
  // 공급처 목록 갯수 조회
  public int totalCntSupplier(Map<String, Object> paramMap) throws Exception;
  
  // 제품정보 목록 조회
  public List<SupplierInfoModel> listSupplierProduct(Map<String, Object> paraMap) throws Exception;
  // 제품정보 목록 갯수 조회
  public int totalCntProduct(Map<String, Object> paramMap) throws Exception;
  
  // 공급처 단건 조회
  public SupplierInfoModel selectSupplier(Map<String, Object> paramMap) throws Exception;
  
  // 공급처 추가
  public int insertSupplier(Map<String, Object> paramMap) throws Exception;
  // 공급처 수정
  public int updateSupplier(Map<String, Object> paramMap) throws Exception;
  // 공급처 삭제
  public int deleteSupplier(Map<String, Object> paramMap) throws Exception;
}
