package xyz.itwill.dto;

//ITEM_CD          NOT NULL VARCHAR2(10)  
//ITEM_NM          NOT NULL VARCHAR2(50)  
//ITEM_QTY         NOT NULL VARCHAR2(10)  
//ITEM_PRICE       NOT NULL NUMBER(20)    
//CATEGORY_NO               NUMBER(5)     
//ITEM_MAIN_IMAGE  NOT NULL VARCHAR2(200) 
//ITEM_CTT_IMAGE_1 NOT NULL VARCHAR2(200) 
//ITEM_CTT_IMAGE_2          VARCHAR2(200) 
//ITEM_CTT_IMAGE_3          VARCHAR2(200) 



public class ItemDTO {
	private int itemCd;
	private String itemNm;
	private String itemQty;
	private int itemPrice;
	private int categoryNo;
	private String categoryName;	
	private String itemMainImage;
	private String itemCttImage1;
	private String itemCttImage2;
	private String itemCttImage3;
	
	public ItemDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getItemCd() {
		return itemCd;
	}

	public void setItemCd(int itemCd) {
		this.itemCd = itemCd;
	}

	public String getItemNm() {
		return itemNm;
	}

	public void setItemNm(String itemNm) {
		this.itemNm = itemNm;
	}

	public String getItemQty() {
		return itemQty;
	}

	public void setItemQty(String itemQty) {
		this.itemQty = itemQty;
	}

	public int getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(int itemPrice) {
		this.itemPrice = itemPrice;
	}

	public int getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getItemMainImage() {
		return itemMainImage;
	}

	public void setItemMainImage(String itemMainImage) {
		this.itemMainImage = itemMainImage;
	}

	public String getItemCttImage1() {
		return itemCttImage1;
	}

	public void setItemCttImage1(String itemCttImage1) {
		this.itemCttImage1 = itemCttImage1;
	}

	public String getItemCttImage2() {
		return itemCttImage2;
	}

	public void setItemCttImage2(String itemCttImage2) {
		this.itemCttImage2 = itemCttImage2;
	}

	public String getItemCttImage3() {
		return itemCttImage3;
	}

	public void setItemCttImage3(String itemCttImage3) {
		this.itemCttImage3 = itemCttImage3;
	}

	
}
