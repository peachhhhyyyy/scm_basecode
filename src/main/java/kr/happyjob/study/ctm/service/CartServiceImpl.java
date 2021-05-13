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
	
	
	public List<CartModel> listCart(Map<String, Object> paramMap) throws Exception{
		
		List<CartModel> listCart = CartDao.listCart(paramMap);
		
		return listCart;
		
	}
	
	public int countListCart(Map<String, Object> paramMap) throws Exception{
		
			
			int totalCount = CartDao.countListCart(paramMap);
			
			return totalCount;
		}	
	}
	
	
	

