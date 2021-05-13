package kr.happyjob.study.ctm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ctm.model.CartModel;

public interface CartDao {

	/** 장바구니 목록 조회 */
	public List<CartModel> listCart(Map<String, Object> paramMap);
	
	/** 장바구니 목록 카운트 조회 */
	public int countListCart(Map<String, Object> paramMap);
	
}
