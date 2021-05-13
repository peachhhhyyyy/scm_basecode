package kr.happyjob.study.ctm.service;


import java.util.List;
import java.util.Map;

import kr.happyjob.study.ctm.model.CartModel;


public interface CartService{

	/** 지출결의 목록 조회 */
	public List<CartModel> listCart(Map<String, Object> paramMap) throws Exception;
	
	/** 지출결의 목록 카운트 조회 */
	public int countListCart(Map<String, Object> paramMap) throws Exception;
	
	
}