package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.SupplierInfoModel;

public interface SupplierInfoService {
  /* 공급처 목록 조회*/
  List<SupplierInfoModel> listSupplier(Map<String, Object> paramMap) throws Exception;
  /* 공급처 목록 카운트 조회*/
  int totalCntSupplier(Map<String, Object> paramMap) throws Exception;
  /* 제품정보 목록 조회*/
  List<SupplierInfoModel> listSupplierProduct(Map<String, Object> paraMap) throws Exception;
  /* 제품정보 목록 카운트 조회*/
  int totalCntProduct(Map<String, Object> paramMap) throws Exception;
  /* 공급처 단건 조회*/
  public SupplierInfoModel selectSupplier(Map<String, Object> paraMap) throws Exception;
  /* 공급처 등록*/
  int insertSupplier(Map<String, Object> paramMap) throws Exception;
  /* 공급처 수정*/
  int updateSupplier(Map<String, Object> paramMap) throws Exception;
  /* 공급처 삭제*/
  int deleteSupplier(Map<String, Object> paramMap) throws Exception;
}
