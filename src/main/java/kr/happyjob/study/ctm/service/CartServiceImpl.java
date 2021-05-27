package kr.happyjob.study.ctm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.ctm.model.CartModel;
import kr.happyjob.study.ctm.service.CartService;
import kr.happyjob.study.ctm.dao.CartDao;

@Service
public class CartServiceImpl implements CartService{

	@Autowired
	CartDao CartDao;
	
	/** 장바구니 조회 */
	public List<CartModel> listCart(Map<String, Object> paramMap) throws Exception{
		
		List<CartModel> listCart = CartDao.listCart(paramMap);
		
		return listCart;
		
	}
	
	/** 장바구니 카운트 조회 */
	public int countListCart(Map<String, Object> paramMap) throws Exception{
		
			int totalCount = CartDao.countListCart(paramMap);
			
			return totalCount;
		}	
	
	/** 장바구니 삭제 */
	public int deleteCartItem(Map<String, Object> paramMap) throws Exception {
		
		int ret = CartDao.deleteCartItem(paramMap);
		
		return ret;
	}
	
	/** 장바구니 수량변경 */
	public int changeQty(Map<String, Object> paramMap) throws Exception {
		
		int cgq = CartDao.changeQty(paramMap);
		
		return cgq;
	}
	
	
	/** 장바구니 총 합계 금액 출력 */
	public Integer totalCartPrice(Map<String, Object> paramMap) throws Exception {
		
		int totalPrice = CartDao.totalCartPrice(paramMap);
		
		return totalPrice;
	}
	
	/** 장바구니 주문 */
	public int orderCartItem(Map<String, Object> paramMap) throws Exception {
		
		int cto = CartDao.orderCartItem(paramMap);
		
		return cto;
	}
	
		
}

	
	
	

