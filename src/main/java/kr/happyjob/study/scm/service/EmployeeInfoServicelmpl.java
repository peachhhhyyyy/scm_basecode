package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.ScmPurchaseDao;
import kr.happyjob.study.scm.model.EmployeeInfoModel;
import kr.happyjob.study.scm.model.ScmPurchaseModel;

@Service
public class EmployeeInfoServicelmpl implements EmployeeInfoService {
  
  // Set logger
  private final Logger logger = LogManager.getLogger(this.getClass());
  
  // Get class name for logger
  private final String className = this.getClass().toString();
  
  @Autowired
  ScmPurchaseDao scmPurchaseDao;

  /** 발주지시서 목록 조회  */
  public List<ScmPurchaseModel> scmPcsOrderingOrder(Map<String, Object> paramMap) {
    List<ScmPurchaseModel> listPcsOrderingOrder = scmPurchaseDao.scmPcsOrderingOrder(paramMap);
    return listPcsOrderingOrder;
  }

  /** 발주지시서 목록 카운트 조회 */
  public int countScmPcsOrderingOrder(Map<String, Object> paramMap) {
    int totalCount = scmPurchaseDao.countScmPcsOrderingOrder(paramMap);
    return totalCount;
  }
  
  /** 발주서 전송 누르고 조회 */
  public ScmPurchaseModel selectPurchBtn(Map<String, Object> paramMap) {
    ScmPurchaseModel scmPurchaseModel = scmPurchaseDao.selectPurchBtn(paramMap);
    return scmPurchaseModel;
  }

  @Override
  public List<EmployeeInfoModel> employeeInfo(Map<String, Object> paramMap) {
    // TODO Auto-generated method stub
    return null;
  }

  @Override
  public int countEmployeeInfo(Map<String, Object> paramMap) {
    // TODO Auto-generated method stub
    return 0;
  }

  @Override
  public EmployeeInfoModel selectSubmitBtn(Map<String, Object> paramMap) {
    // TODO Auto-generated method stub
    return null;
  }
}