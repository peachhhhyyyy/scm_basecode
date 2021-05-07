package kr.happyjob.study.pcs.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pcs.model.PcsModel;

public interface PcsDao {

  /** 그룹코드 목록 조회 */
  public List<PcsModel> listComnGrpCod(Map<String, Object> paramMap) throws Exception;
}