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

@Service
public class PcsServiceImpl implements PcsService {

  // Set logger
  private final Logger logger = LogManager.getLogger(this.getClass());
  
  // Get class name for logger
  private final String className = this.getClass().toString();
  
  @Autowired
  PcsDao pcsDao;
  
  /** 발주지시서 목록 조회 
   * @throws Exception */
  public List<PcsModel> pcsOrderingOrder(Map<String, Object> paramMap) throws Exception {
    List<PcsModel> listPcsOrderingOrder = pcsDao.pcsOrderingOrder(paramMap);
    return listPcsOrderingOrder;
  }
  
  /** 발주지시서 목록 카운트 조회 */
  public int countPcsOrderingOrder(Map<String, Object> paramMap) throws Exception {
    int totalCount = pcsDao.countPcsOrderingOrder(paramMap);
    return totalCount;
  }
}