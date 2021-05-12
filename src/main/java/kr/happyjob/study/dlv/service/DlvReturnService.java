package kr.happyjob.study.dlv.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dlv.model.DlvReturnDetailModel;
import kr.happyjob.study.dlv.model.DlvReturnModel;

public interface DlvReturnService {
	//반품 리스트 조회
	public List<DlvReturnModel> returnList(Map<String, Object> paramMap) throws Exception;
	//반품 리스트 카운트 조회
	public int returnlistCnt(Map<String, Object> paramMap) throws Exception;
	//반품 상세페이지 리스트 조회
	public List<DlvReturnDetailModel> returnDetailList(Map<String, Object> paramMap) throws Exception;
	//반품 상세페이지 업데이트
	public int returnDetailInfo(Map<String, Object> paramMap) throws Exception;
}
