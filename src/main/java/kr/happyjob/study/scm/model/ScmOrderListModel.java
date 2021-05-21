package kr.happyjob.study.scm.model;

public class ScmOrderListModel {
	/*
	 * 수주내역 조회 테이블 컬럼
	 * 
	 * 주문코드 string 주문일자 string 기업고객명 string 주문 제품명 string 총 재고 개수, int,
	 * tb_scm_product, stock 단가, int, tb_scm_product, price 주문 개수, int,
	 * tb_order, order_cnt 총액, int, tb_order, amount 부가세, int, tb_order, tax
	 * 임급여부, char, tb_order, deposit_yn 상태, string, tb_order, state 배송버튼 발주버튼
	 * 
	 */

	private String orderCode;
	private String orderDate;
	private String customerName;
	private String productName;
	private int productCount;
	private int productPrice;
	private int orderCount;
	private int orderAmount;
	private int orderTax;
	private String depositState;
	private String state;
	private int STTcd;

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getProductCount() {
		return productCount;
	}

	public void setProductCount(int productCount) {
		this.productCount = productCount;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public int getOrderCount() {
		return orderCount;
	}

	public void setOrderCount(int orderCount) {
		this.orderCount = orderCount;
	}

	public int getOrderAmount() {
		return orderAmount;
	}

	public void setOrderAmount(int orderAmount) {
		this.orderAmount = orderAmount;
	}

	public int getOrderTax() {
		return orderTax;
	}

	public void setOrderTax(int orderTax) {
		this.orderTax = orderTax;
	}

	public String getDepositState() {
		return depositState;
	}

	public void setDepositState(String depositState) {
		this.depositState = depositState;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public int getSTTcd() {
		return STTcd;
	}

	public void setSTTcd(int sTTcd) {
		STTcd = sTTcd;
	}

}
