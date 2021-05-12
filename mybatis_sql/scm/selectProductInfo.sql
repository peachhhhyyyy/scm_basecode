SELECT o.order_cd orderCode, 
  	   o.order_date orderDate,
       NOW() submitDate,
  	   prod.prod_nm productName,  
       mct.m_ct_nm middleCategory,
  	   prod.stock productCount, 
  	   o.order_cnt orderCount, 
  	   prod.purchase_price purchase_price
  FROM tb_order o
	LEFT JOIN tb_scm_product prod ON prod.product_cd = o.product_cd
  LEFT JOIN tb_scm_m_category mct ON mct.m_ct_cd = prod.m_ct_cd
  WHERE o.order_cd = #{ordercode}