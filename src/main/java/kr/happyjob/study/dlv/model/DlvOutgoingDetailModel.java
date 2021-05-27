package kr.happyjob.study.dlv.model;

public class DlvOutgoingDetailModel {
	
	// 배송접수일자
	private String order_date;
	// 배송지시서번호
	private String ship_list_no;
	// 주문코드
	private String order_cd;
	// 카테고리명(중분류)
	private String l_ct_nm;
	// 제품명
	private String prod_nm;
	// 수량
	private String order_cnt;
	// 고객명
	private String name_customer;
	// 고객연락처
	private String tel_customer;
	// 배송주소
	private String addr;
	// SCM담당자명
	private String name_scm;
	// 배송사원명
	private String name_delivery;
	// 배송사원연락처
	private String tel_delivery;
	// 창고명
	private String warehouse_nm;
	// 도착일자
	private String arr_prev_date;
	// 도착예정일자
	private String arr_date;
	// 상태
	private String state ;
	// 요청사항
	private String request ;
	// 오프라인여부
	private String offline;
	
	public String getShip_list_no() {
		return ship_list_no;
	}
	public void setShip_list_no(String ship_list_no) {
		this.ship_list_no = ship_list_no;
	}
	public String getOrder_cd() {
		return order_cd;
	}
	public void setOrder_cd(String order_cd) {
		this.order_cd = order_cd;
	}
	public String getL_ct_nm() {
		return l_ct_nm;
	}
	public void setL_ct_nm(String l_ct_nm) {
		this.l_ct_nm = l_ct_nm;
	}
	public String getProd_nm() {
		return prod_nm;
	}
	public void setProd_nm(String prod_nm) {
		this.prod_nm = prod_nm;
	}
	public String getOrder_cnt() {
		return order_cnt;
	}
	public void setOrder_cnt(String order_cnt) {
		this.order_cnt = order_cnt;
	}
	public String getName_customer() {
		return name_customer;
	}
	public void setName_customer(String name_customer) {
		this.name_customer = name_customer;
	}
	public String getTel_customer() {
		return tel_customer;
	}
	public void setTel_customer(String tel_customer) {
		this.tel_customer = tel_customer;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getName_scm() {
		return name_scm;
	}
	public void setName_scm(String name_scm) {
		this.name_scm = name_scm;
	}
	public String getName_delivery() {
		return name_delivery;
	}
	public void setName_delivery(String name_delivery) {
		this.name_delivery = name_delivery;
	}
	public String getTel_delivery() {
		return tel_delivery;
	}
	public void setTel_delivery(String tel_delivery) {
		this.tel_delivery = tel_delivery;
	}
	public String getWarehouse_nm() {
		return warehouse_nm;
	}
	public void setWarehouse_nm(String warehouse_nm) {
		this.warehouse_nm = warehouse_nm;
	}
	public String getArr_prev_date() {
		return arr_prev_date;
	}
	public void setArr_prev_date(String arr_prev_date) {
		this.arr_prev_date = arr_prev_date;
	}
	
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getRequest() {
		return request;
	}
	public void setRequest(String request) {
		this.request = request;
	}
	public String getArr_date() {
		return arr_date;
	}
	public void setArr_date(String arr_date) {
		this.arr_date = arr_date;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public String getOffline() {
		return offline;
	}
	public void setOffline(String offline) {
		this.offline = offline;
	}
	@Override
	public String toString() {
		return "DlvOutgoingDetailModel [order_date=" + order_date + ", ship_list_no=" + ship_list_no + ", order_cd="
				+ order_cd + ", l_ct_nm=" + l_ct_nm + ", prod_nm=" + prod_nm + ", order_cnt=" + order_cnt
				+ ", name_customer=" + name_customer + ", tel_customer=" + tel_customer + ", addr=" + addr
				+ ", name_scm=" + name_scm + ", name_delivery=" + name_delivery + ", tel_delivery=" + tel_delivery
				+ ", warehouse_nm=" + warehouse_nm + ", arr_prev_date=" + arr_prev_date + ", arr_date=" + arr_date
				+ ", state=" + state + ", request=" + request + ", offline=" + offline + "]";
	}
	
	
	
}
