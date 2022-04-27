package xyz.itwill.dto;

public class categoryDTO {

	private String categogyNo;
	private String categogyName;
	
	public categoryDTO() {
		// TODO Auto-generated constructor stub
	}
	public categoryDTO(String categogyNo, String categogyName) {
		super();
		this.categogyNo = categogyNo;
		this.categogyName = categogyName;
	}


	public String getCategogyNo() {
		return categogyNo;
	}


	public void setCategogyNo(String categogyNo) {
		this.categogyNo = categogyNo;
	}


	public String getCategogyName() {
		return categogyName;
	}


	public void setCategogyName(String categogyName) {
		this.categogyName = categogyName;
	}

	
}
