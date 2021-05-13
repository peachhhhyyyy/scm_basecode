package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.ScmReturnListDao;
import kr.happyjob.study.scm.model.ScmReturnListModel;

@Service
public class ScmReturnServicelmpl implements ScmReturnService {

	@Autowired
	ScmReturnListDao srlDao;
	
	@Override
	public List<ScmReturnListModel> getReturnList(Map<String, Object> paramMap) throws Exception {
		return srlDao.selectReturnList(paramMap);
	}

}
