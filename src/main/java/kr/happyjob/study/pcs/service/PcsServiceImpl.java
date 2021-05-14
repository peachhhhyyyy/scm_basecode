package kr.happyjob.study.pcs.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.pcs.dao.PcsDao;
import kr.happyjob.study.pcs.model.PcsModel;
import kr.happyjob.study.pcs.service.PcsService;
import kr.happyjob.study.system.model.ComnGrpCodModel;

@Service
public class PcsServiceImpl implements PcsService {

  // Set logger
  private final Logger logger = LogManager.getLogger(this.getClass());
  
  // Get class name for logger
  private final String className = this.getClass().toString();
  
  @Autowired
  PcsDao pcsDao;
  
  /** 발주지시서 목록 조회  */
  public List<PcsModel> pcsOrderingOrder(Map<String, Object> paramMap) {
    List<PcsModel> listPcsOrderingOrder = pcsDao.pcsOrderingOrder(paramMap);
    return listPcsOrderingOrder;
  }
  
  /** 발주지시서 목록 카운트 조회 */
  public int countPcsOrderingOrder(Map<String, Object> paramMap) {
    int totalCount = pcsDao.countPcsOrderingOrder(paramMap);
    return totalCount;
  }

  /** 발주서 전송 누르고 조회 */
  public PcsModel selectPurchBtn(Map<String, Object> paramMap) {
    PcsModel pcsmodel = pcsDao.selectPurchBtn(paramMap);
    return pcsmodel;
  }
  
  /** 발주서 목록 조회  */
  public List<PcsModel> pcsOrderForm(Map<String, Object> paramMap) {
    List<PcsModel> listPcsOrderForm = pcsDao.pcsOrderForm(paramMap);
    return listPcsOrderForm;
  }
  
  /** 발주서 목록 카운트 조회 */
  public int countPcsOrderForm(Map<String, Object> paramMap) {
    int totalCount = pcsDao.countPcsOrderForm(paramMap);
    return totalCount;
  }
  
  /** 발주서 상태 변경 */
  public int updateSTTcd(Map<String, Object> paramMap) {
    int pcsmodel = pcsDao.updateSTTcd(paramMap);
    return pcsmodel;
  }
}