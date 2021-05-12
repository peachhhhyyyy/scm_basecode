SELECT o.order_cd orderCode, 
   o.order_date orderDate, 
   ui.name customerName, 
   prod.prod_nm productName, 
   prod.stock productCount, 
   prod.price productPrice, 
   o.order_cnt orderCount, 
   o.amount orderAmount, 
   o.tax orderTax, 
   o.deposit_yn depositState, 
   o.state state 
FROM tb_order o 
JOIN (
		SELECT name, loginID 
		FROM tb_userinfo
	 ) ui ON ui.loginID = o.loginID 
LEFT JOIN (
			SELECT prod_nm, product_cd, stock, price 
			FROM tb_scm_product
		  ) prod ON prod.product_cd = o.product_cd
LIMIT #{pageIndex}, #{pageSize}