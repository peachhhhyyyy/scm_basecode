package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.model.ProdInfoModel;
import kr.happyjob.study.scm.service.ProdInfoService;
import kr.happyjob.study.scm.dao.ProdInfoDao;

@Service
public class ProdInfoServiceImpl implements ProdInfoService {
  @Autowired
  
  ProdInfoDao ProdInfoDao;
  
  
  public List<ProdInfoModel> listProdInfo(Map<String, Object> paramMap) throws Exception{
    
    List<ProdInfoModel> listProdInfo = ProdInfoDao.listProdInfo(paramMap);
    
    return listProdInfo;
    
  }
  
  public int countListProdInfo(Map<String, Object> paramMap) throws Exception{
    
      
      int totalCount = ProdInfoDao.countListProdInfo(paramMap);
      
      return totalCount;
    } 
}
