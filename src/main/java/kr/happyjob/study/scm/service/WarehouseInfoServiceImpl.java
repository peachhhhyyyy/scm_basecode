package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.WarehouseInfoDao;
import kr.happyjob.study.scm.model.WarehouseInfoModel;

@Service
public class WarehouseInfoServiceImpl implements WarehouseInfoService {
  
  @Autowired // service에서는 controller,DAO와 연결되어 있다.
  WarehouseInfoDao warehouseInfoDao;
  
  // 창고 목록 조회
  @Override
  public List<WarehouseInfoModel> listWarehouse(Map<String, Object> paramMap) throws Exception {
    // 필요한 값
    List<WarehouseInfoModel> listWarehouse = warehouseInfoDao.listWarehouse(paramMap);
    // List는 쇼핑백 <>사이는 봉투 List에 <>내용을 담은 후에 리턴해준다. <> 내용에는 우측항의 Dao의 내용
    // 빈 List<WarehouseInfoVO> listWarehouseInfo 라는 그릇에 warehouseInfoDao.listWarehouseInfo(paramMap) 라는 계란을 담고 리턴
    return listWarehouse;
  }
  
  // 창고 카운트
  @Override
  public int totalCntWarehouse(Map<String, Object> paramMap) throws Exception {
    int totalCntWarehouse = warehouseInfoDao.totalCntWarehouse(paramMap);
    return totalCntWarehouse;
  }
}
