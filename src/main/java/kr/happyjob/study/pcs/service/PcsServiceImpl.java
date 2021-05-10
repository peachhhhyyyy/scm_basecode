package kr.happyjob.study.pcs.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.pcs.dao.PcsDao;
import kr.happyjob.study.pcs.model.PcsModel;

@Service
public class PcsServiceImpl implements PcsService {

  // Set logger
  private final Logger logger = LogManager.getLogger(this.getClass());
  
  // Get class name for logger
  private final String className = this.getClass().toString();
  
  @Autowired
  PcsDao pcsDao;
  
  /** 그룹코드 목록 조회 */
  public List<PcsModel> listComnGrpCod(Map<String, Object> paramMap) throws Exception {
    List<PcsModel> listComnGrpCod = pcsDao.listComnGrpCod2(paramMap);
    return listComnGrpCod;
  }
  
  /** 그룹코드 목록 카운트 조회 */
  public int countListComnGrpCod(Map<String, Object> paramMap) throws Exception {
    int totalCount = PcsDao.countListComnGrpCod2(paramMap);
    return totalCount;
  }

  @Override
  public List<PcsModel> listComnGrpCod2(Map<String, Object> paramMap) {
    // TODO Auto-generated method stub
    return null;
  }

  @Override
  public int countListComnGrpCod2(Map<String, Object> paramMap) throws Exception {
    // TODO Auto-generated method stub
    return 0;
  }
}
