package xyz.itwill.dto;

public class cartDTO {
	private int cartNo; //장바구니 번호
	private String memberEmail;	// 회원 이메일(아이디)
	private String itemCD;//(상품 번호)
	private String itemMainImage;// 이미지
	private String itemNM;// 상품정보(이름)
	private int item_price;// 판매가
	private int cartEach;// 수량
	
	public cartDTO() {
		// TODO Auto-generated constructor stub
	}

	
	
	public int getCartNo() {
		return cartNo;
	}


	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}


	public String getMemberEmail() {
		return memberEmail;
	}


	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}


	public String getItemCD() {
		return itemCD;
	}


	public void setItemCD(String itemCD) {
		this.itemCD = itemCD;
	}


	public String getItemMainImage() {
		return itemMainImage;
	}


	public void setItemMainImage(String itemMainImage) {
		this.itemMainImage = itemMainImage;
	}


	public String getItemNM() {
		return itemNM;
	}


	public void setItemNM(String itemNM) {
		this.itemNM = itemNM;
	}


	public int getItem_price() {
		return item_price;
	}


	public void setItem_price(int item_price) {
		this.item_price = item_price;
	}


	public int getCartEach() {
		return cartEach;
	}


	public void setCartEach(int cartEach) {
		this.cartEach = cartEach;
	}


}
