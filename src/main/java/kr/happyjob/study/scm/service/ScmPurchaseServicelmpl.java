package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.ScmPurchaseDao;
import kr.happyjob.study.scm.model.ScmPurchaseModel;

@Service
public class ScmPurchaseServicelmpl implements ScmPurchaseService {
  
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
}