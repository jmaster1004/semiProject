<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String email=request.getParameter("member_email"); //받아온값 넣기
String name=request.getParameter("member_name"); //받아온값 넣기
String phone=request.getParameter("member_phone1")+"-"
	+request.getParameter("member_phone2")+"-"+request.getParameter("member_phone3");
String repasswd=null;

MemberDTO member=MemberDAO.getDAO().serchPasswdMember(email, name, phone);

if(member==null){
	session.setAttribute("message", "입력하신 정보를 확인해 주세요.");
	out.println("<script type='text/javascript'>");
	out.println("alert('입력하신 정보를 확인해 주세요.');");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=member&work=find_passwd';");
	out.println("</script>");
	return;
}else if(!member.getMemberEmail().equals(email) || !member.getMemberPhone().equals(phone) || !member.getMemberName().equals(name)){
	session.setAttribute("email", email);
	session.setAttribute("name", name);
	session.setAttribute("phone", phone);
	session.setAttribute("message", "입력된 정보를 다시 확인해 주세요.");
	out.println("<script type='text/javascript'>");
	out.println("alert('입력된 정보를 다시 확인해 주세요');");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=member&work=find_passwd';");
	out.println("</script>");
	return;
}else{
	repasswd=member.getMemberPassword();
}


%>

<div id="wrap">
	<div class="site-wrap">

		<div class="path">
			<span>현재 위치</span>
			<ol>
				<li><a href="/">홈</a></li>
				<li title="현재 위치"><strong>비밀번호 변경</strong></li>
			</ol>
		</div>

		<div class="titleArea">
				<h2>비밀번호 변경</h2>
		</div>
		<div style="text-align:center">
			<form class="joinForm" id="repasswdForm" name="repasswdForm" action="<%=request.getContextPath() %>/site/index.jsp?workgroup=member&work=repassword" method="post">
				<input id="member_email" name="member_email" value="<%=email%>" type="hidden">
				<input id="member_name" name="member_name" value="<%=name%>" type="hidden">
				<input id="member_phone" name="member_phone" value="<%=phone%>" type="hidden">
				
				<div>
					<input type="password" name="member_repassword" id="member_repassword" size="30" placeholder="영어 대소문자/숫자 6~20자">
				</div>
				<div>
					<input type="password" name="repw" id="repw" size="30"  placeholder="비밀번호 확인">
				</div>
				<div id="Msg" class="error"></div>
				<br>
				<div>
					<button type="submit" id="repasswd" name="repasswd" class="btnSubmitFix sizeM">확인</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">

$("#repasswdForm").submit(function() {
	var submitResult=true;
	
	var pwReg=/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,20}$/g;
	if($("#member_repassword").val()=="") {
		$("#Msg").text("비밀번호를 입력해 주세요.");
		submitResult=false;
	} else if(!pwReg.test($("#member_repassword").val())) {
		$("#Msg").text("영어 대소문자/숫자 포함 6~20자리");
		submitResult=false;
	} 
	
	if($("#repw").val()=="") {
		$("#Msg").text("비밀번호 확인을 입력해 주세요.");
		submitResult=false;
	} else if($("#member_repassword").val()!=$("#repw").val()) {
		$("#hMsg").text("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
		submitResult=false;
	}
	return submitResult;
});
</script>
<style>
.error {
	color: red;
	position: relative;
	left: 160px;
	display: none;
}
</style>