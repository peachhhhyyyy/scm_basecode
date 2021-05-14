package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.ScmOrderListDao;
import kr.happyjob.study.scm.model.DeliveryInfoModel;
import kr.happyjob.study.scm.model.ProductInfoModel;
import kr.happyjob.study.scm.model.ScmOrderListModel;

@Service
public class ScmOrderListServiceImpl implements ScmOrderListService {

	@Autowired
	ScmOrderListDao ScmOrderListDao;

	@Override
	public List<ScmOrderListModel> getOrderList(Map<String, Object> paramMap) throws Exception {
		return ScmOrderListDao.selectOrderList(paramMap);
	}
	
	@Override
	public int getOrderListCnt(Map<String, Object> paramMap) throws Exception {
		return ScmOrderListDao.selectOrderListCnt(paramMap);
	}
	
	@Override
	public ProductInfoModel getProductInfo(Map<String, Object> paramMap) throws Exception {
		return ScmOrderListDao.selectProductInfo(paramMap);
	}
	
	@Override
	public String getScmManagerName(Map<String, Object> paramMap) throws Exception {
		return ScmOrderListDao.selectScmManagerName(paramMap);
	}
	
	@Override
	public DeliveryInfoModel getDeliveryInfo(Map<String, Object> paramMap) throws Exception {
		return ScmOrderListDao.selectDeliveryInfo(paramMap);
	}
}
