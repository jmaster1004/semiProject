package xyz.itwill.dto;

//이름             널?       유형              
//-------------- -------- --------------- 
//NOTICE_NO      NOT NULL NUMBER(10)      
//NOTICE_TITLE   NOT NULL VARCHAR2(100)   
//NOTICE_CONTENT NOT NULL NVARCHAR2(2000) 
//NOTICE_IMAGE            VARCHAR2(500)   
//NOTICE_REGDATE NOT NULL DATE            
//NOTICE_HIT     NOT NULL NUMBER(10)      


public class NoticeDTO {

	private int noticeNo;
	private String memberEmail;
	private String memberName;
	private String noticeTitle;
	private String noticeContent;
	private String noticeImage;
	private String noticeRegDate;
	private int noticeHit;
	private int noticeStatus;
	
	public NoticeDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	
	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	public String getNoticeImage() {
		return noticeImage;
	}

	public void setNoticeImage(String noticeImage) {
		this.noticeImage = noticeImage;
	}

	public String getNoticeRegDate() {
		return noticeRegDate;
	}

	public void setNoticeRegDate(String noticeRegDate) {
		this.noticeRegDate = noticeRegDate;
	}

	public int getNoticeHit() {
		return noticeHit;
	}

	public void setNoticeHit(int noticeHit) {
		this.noticeHit = noticeHit;
	}

	public int getNoticeStatus() {
		return noticeStatus;
	}

	public void setNoticeStatus(int noticeStatus) {
		this.noticeStatus = noticeStatus;
	}	
}
