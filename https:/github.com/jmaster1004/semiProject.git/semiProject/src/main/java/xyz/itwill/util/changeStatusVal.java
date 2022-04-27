package xyz.itwill.util;



public class changeStatusVal {
	
	
	private static changeStatusVal _dao;

	public changeStatusVal() {
		// TODO Auto-generated constructor stub
		
	}
	static {
		_dao=new changeStatusVal();
	}
	
	public static changeStatusVal getUtil() {
		return _dao;
	}

	
	public String changeStatus(int sta) {
		String statusName = ""; 
		if(sta==1) { statusName ="입금 대기";}
		else if(sta==2) {statusName ="입금 완료";}
		else if(sta==11) {statusName ="배송 준비중";}
		else if(sta==12) {statusName ="배송 중";}
		else if(sta==13) {statusName ="배송 완료";}
		else if(sta==21) {statusName ="취소 신청";}
		else if(sta==22) {statusName ="취소 완료";}
		else if(sta==23) {statusName ="교환 신청";}
		else if(sta==24) {statusName ="교환 완료";}
		else if(sta==25) {statusName ="반품 신청";}
		else if(sta==26) {statusName ="반품 완료";}
		else if(sta==27) {statusName ="환불 신청";}
		else if(sta==28) {statusName ="환불 완료";}
		else {statusName ="모르겠어요ㅠㅠ";}
		return statusName;
	}
	
	public int changeStatus(String sta) {
		int statusVal =1; 
		if(sta.contentEquals("입금 대기")) { statusVal =1;}
		else if(sta.contentEquals("입금 완료")) {statusVal =2;}
		else if(sta.contentEquals("배송 준비중")) {statusVal =11;}
		else if(sta.contentEquals("배송 중")) {statusVal =12;}
		else if(sta.contentEquals("배송 완료")) {statusVal =3;}
		else if(sta.contentEquals("취소 신청")) {statusVal =21;}
		else if(sta.contentEquals("취소 완료")) {statusVal =22;}
		else if(sta.contentEquals("교환 신청")) {statusVal =23;}
		else if(sta.contentEquals("교환 완료")) {statusVal =24;}
		else if(sta.contentEquals("반품 신청")) {statusVal =25;}
		else if(sta.contentEquals("반품 완료")) {statusVal =26;}
		else if(sta.contentEquals("환불 신청")) {statusVal =27;}
		else if(sta.contentEquals("환불 신청")) {statusVal =28;}
		return statusVal;
	}

}
