package kr.happyjob.study.pcs.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pcs.model.PcsModel;

public interface PcsService {
  /** 그룹코드 목록 조회 */
  public List<PcsModel> listComnGrpCod2(Map<String, Object> paramMap);
  
  /** 그룹코드 목록 카운트 조회 */
  public int countListComnGrpCod2(Map<String, Object> paramMap) throws Exception;
}