package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.CusInfoDao;
import kr.happyjob.study.scm.model.CusInfoModel;

@Service
public class CusInfoServiceImpl implements CusInfoService{
	
	@Autowired
	CusInfoDao cusInfoDao;

	@Override
	public List<CusInfoModel> cusList(Map<String, Object> paramMap) throws Exception {
		return cusInfoDao.cusList(paramMap);
	}

	@Override
	public int cusListCnt(Map<String, Object> paramMap) throws Exception {
		return cusInfoDao.cusListCnt(paramMap);
	}
  
}
