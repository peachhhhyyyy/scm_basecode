package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.EmployeeInfoModel;

public interface EmployeeInfoService {
  /** 발주지시서 목록 조회 */
  public List<EmployeeInfoModel> employeeInfo(Map<String, Object> paramMap);
  
  /** 발주지시서 목록 카운트 조회 */
  public int countEmployeeInfo(Map<String, Object> paramMap);
  
  /** 발주지시서 발주버튼 클릭시 조회 */
  public EmployeeInfoModel selectSubmitBtn(Map<String, Object> paramMap);
}
