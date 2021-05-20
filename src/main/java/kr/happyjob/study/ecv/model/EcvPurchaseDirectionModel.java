package kr.happyjob.study.ecv.model;

public class EcvPurchaseDirectionModel {
	/*
	 * 발주지시서 (임원) 필요한 데이터 
	 * 
	 * 공급처코드 supply_cd
	 * 공급처명, suppy_cd로 join
	 * 제품명, product_cd로 join
	 * 제품수량, purch_qty 
	 * 합계 금액, purch_total_amt
	 * 담당자 이름, scm_id로 join
	 * 신청 일자, direction_date 
	 * 승인 (jsp단에서 버튼을 넣을 것임)
	 * 
	 */

	String supplyCode;
	String supplyName;
	String productName;
	int purchaseQty;
	int purchaseTotalAmount;
	String scmManager;
	String directionDate;
	int sttCode;
	String orderCode;

	public String getSupplyCode() {
		return supplyCode;
	}

	public void setSupplyCode(String supplyCode) {
		this.supplyCode = supplyCode;
	}

	public String getSupplyName() {
		return supplyName;
	}

	public void setSupplyName(String supplyName) {
		this.supplyName = supplyName;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getPurchaseQty() {
		return purchaseQty;
	}

	public void setPurchaseQty(int purchaseQty) {
		this.purchaseQty = purchaseQty;
	}

	public int getPurchaseTotalAmount() {
		return purchaseTotalAmount;
	}

	public void setPurchaseTotalAmount(int purchaseTotalAmount) {
		this.purchaseTotalAmount = purchaseTotalAmount;
	}

	public String getScmManager() {
		return scmManager;
	}

	public void setScmManager(String scmManager) {
		this.scmManager = scmManager;
	}

	public String getDirectionDate() {
		return directionDate;
	}

	public void setDirectionDate(String directionDate) {
		this.directionDate = directionDate;
	}

	public int getSttCode() {
		return sttCode;
	}

	public void setSttCode(int sttCode) {
		this.sttCode = sttCode;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}
	
}
