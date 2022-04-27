package xyz.itwill.dto;
/*
이름             널?       유형             
-------------- -------- -------------- 
ORDER_NO       NOT NULL NUMBER(20)     
ITEM_CD        NOT NULL VARCHAR2(10)   
MEMBER_EMAIL   NOT NULL VARCHAR2(50)   
ORDER_DATE     NOT NULL DATE           
ORDER_STATUS   NOT NULL NUMBER(2)      
ORDER_QUANTITY NOT NULL NUMBER(4)      
ORDER_ADDRESS  NOT NULL VARCHAR2(100)  
ORDER_ZIPCODE  NOT NULL NUMBER(10)     
ORDER_PHONE    NOT NULL VARCHAR2(20)   
ORDER_NAME     NOT NULL VARCHAR2(20)   
ORDER_MEMO              NVARCHAR2(500) 
ORDER_ADDRESS2 NOT NULL VARCHAR2(100)  

MEMBER_NAME     NOT NULL VARCHAR2(20)  
ITEM_NM         NOT NULL VARCHAR2(50)  
ITEM_PRICE      NOT NULL NUMBER(20)
 * */

public class OrdersDTO {
	private String memberEmail;
	private String orderDate;
	private int orderNo;
	private String itemCd;
	private int orderStatus;
	private int orderQuantity;
	private String orderAddress1;
	private String orderAddress2;
	private String orderZipcode;
	private String orderPhone;
	private String orderName;
	private String orderMemo;
	private String memberName;
	private String itemNm;
	private int itemPrice;
	
	public OrdersDTO() {
		// TODO Auto-generated constructor stub
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public String getItemCd() {
		return itemCd;
	}

	public void setItemCd(String itemCd) {
		this.itemCd = itemCd;
	}

	public int getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(int orderStatus) {
		this.orderStatus = orderStatus;
	}

	public int getOrderQuantity() {
		return orderQuantity;
	}

	public void setOrderQuantity(int orderQuantity) {
		this.orderQuantity = orderQuantity;
	}

	public String getOrderAddress1() {
		return orderAddress1;
	}

	public void setOrderAddress1(String orderAddress1) {
		this.orderAddress1 = orderAddress1;
	}
			
	public String getOrderAddress2() {
		return orderAddress2;
	}

	public void setOrderAddress2(String orderAddress2) {
		this.orderAddress2 = orderAddress2;
	}

	public String getOrderZipcode() {
		return orderZipcode;
	}
	
	public void setOrderZipcode(String orderZipcode) {
		this.orderZipcode = orderZipcode;
	}	
	
	public String getOrderPhone() {
		return orderPhone;
	}

	public void setOrderPhone(String orderPhone) {
		this.orderPhone = orderPhone;
	}

	public String getOrderName() {
		return orderName;
	}

	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}

	public String getOrderMemo() {
		return orderMemo;
	}

	public void setOrderMemo(String orderMemo) {
		this.orderMemo = orderMemo;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}


	public String getItemNm() {
		return itemNm;
	}

	public void setItemNm(String itemNm) {
		this.itemNm = itemNm;
	}

	public int getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(int itemPrice) {
		this.itemPrice = itemPrice;
	}


	
	
	
	
}
