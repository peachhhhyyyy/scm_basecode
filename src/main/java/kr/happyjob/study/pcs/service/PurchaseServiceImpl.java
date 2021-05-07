package kr.happyjob.study.pcs.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.pcs.dao.PurchaseDao;
import kr.happyjob.study.pcs.model.PurchaseModel;

@Service
public class PurchaseServiceImpl implements PurchaseService {
	
	@Autowired
	PurchaseDao purchaseDao;

	@Override
	public List<PurchaseModel> purchaseList(Map<String, Object> paramMap) {
		List<PurchaseModel> purchaseList=purchaseDao.purchaseList(paramMap);
		return purchaseList;
	}

//	@Override
//	public int noticeTotalCnt(Map<String, Object> paramMap) {
//		int noticeTotalCnt=noticeDDao.noticeTotalCnt(paramMap);
//		return noticeTotalCnt;
//	}
//
//	@Override
//	public NoticeDModel detailNotice(Map<String, Object> paramMap) {
//		 NoticeDModel detailNotice=noticeDDao.detailNotice(paramMap);
//		return detailNotice;
//	}
//
//

}