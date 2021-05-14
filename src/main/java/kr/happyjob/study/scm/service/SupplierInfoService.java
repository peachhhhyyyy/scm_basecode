package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.SupplierInfoModel;

public interface SupplierInfoService {
  /* 공급처 목록 조회*/
  List<SupplierInfoModel> getSupplierInfo(Map<String, Object> paramMap) throws Exception;
  /* 공급처 목록 카운트 조회*/
  int countSupplierInfo(Map<String, Object> paramMap) throws Exception;
  /* 제품정보 목록 조회*/
  List<SupplierInfoModel> getSupplierProInfo(Map<String, Object> paraMap) throws Exception;
  /* 제품정보 목록 카운트 조회*/
  int countSupplierProInfo(Map<String, Object> paramMap) throws Exception;
  /* 공급처 단건 조회*/
  public SupplierInfoModel selectDelivery(Map<String, Object> paraMap) throws Exception;
  /* 공급처 등록*/
  int insertDelivery(Map<String, Object> paramMap) throws Exception;
  /* 공급처 수정*/
  int updateDelivery(Map<String, Object> paramMap) throws Exception;
}
