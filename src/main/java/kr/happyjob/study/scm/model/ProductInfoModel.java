package kr.happyjob.study.scm.model;

public class ProductInfoModel {
	/*
	 * 발주지시서에 나타날 데이터 목록 SCM관리자 주문번호 제출일자 (SQL에서 NOW()함수 사용하기) 제품명 품목명 총 재고 개수
	 * 고객 주문 개수 장비구매액 (제품 수량) jsp 단에서 input으로 갯수를 받을 것임 (합계) jsp 단에서 장비구매액 * 제품
	 * 수량을 계산해서 받을 것임
	 */

	private String scmManager;
	private String orderCode;
	private String orderDate;
	private String submitDate;
	private String productName;
	private String middleCategory;
	private int productCount;
	private int orderCount;
	private int purchasePrice;
	private String supplyCode;
	private String productCode;
	private String supplyName;

	public String getScmManager() {
		return scmManager;
	}

	public void setScmManager(String scmManager) {
		this.scmManager = scmManager;
	}

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

	public String getSubmitDate() {
		return submitDate;
	}

	public void setSubmitDate(String submitDate) {
		this.submitDate = submitDate;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getMiddleCategory() {
		return middleCategory;
	}

	public void setMiddleCategory(String middleCategory) {
		this.middleCategory = middleCategory;
	}

	public int getProductCount() {
		return productCount;
	}

	public void setProductCount(int productCount) {
		this.productCount = productCount;
	}

	public int getorderCount() {
		return orderCount;
	}

	public void setorderCount(int orderCount) {
		this.orderCount = orderCount;
	}

	public int getpurchasePrice() {
		return purchasePrice;
	}

	public void setpurchasePrice(int purchasePrice) {
		this.purchasePrice = purchasePrice;
	}

	public String getSupplyCode() {
		return supplyCode;
	}

	public void setSupplyCode(String supplyCode) {
		this.supplyCode = supplyCode;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getSupplyName() {
		return supplyName;
	}

	public void setSupplyName(String supplyName) {
		this.supplyName = supplyName;
	}

}
