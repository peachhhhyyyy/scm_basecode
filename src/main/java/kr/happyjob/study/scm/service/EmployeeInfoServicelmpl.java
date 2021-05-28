package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.EmployeeInfoDao;
import kr.happyjob.study.scm.model.EmployeeInfoModel;

@Service
public class EmployeeInfoServicelmpl implements EmployeeInfoService {
  
  // Set logger
  private final Logger logger = LogManager.getLogger(this.getClass());
  
  // Get class name for logger
  private final String className = this.getClass().toString();
  
  @Autowired
  EmployeeInfoDao employeeInfoDao;
  
  /** 직원정보관리 목록 조회  */
  public List<EmployeeInfoModel> employeeInfo(Map<String, Object> paramMap) {
    List<EmployeeInfoModel> employeeInfo = employeeInfoDao.employeeInfo(paramMap);
    return employeeInfo;
  }

  /** 직원정보관리 목록 카운트 조회 */
  public int countEmployeeInfo(Map<String, Object> paramMap) {
    int totalCount = employeeInfoDao.countEmployeeInfo(paramMap);
    return totalCount;
  }
  
  /** 직원정보관리 단건 조회 */
  public EmployeeInfoModel selectSubmitBtn(Map<String, Object> paramMap) {
    EmployeeInfoModel employeeInfoModel = employeeInfoDao.selectSubmitBtn(paramMap);
    return employeeInfoModel;
  }
}