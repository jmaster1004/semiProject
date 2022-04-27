<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(request.getParameter("email")==null){
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}
	String email=request.getParameter("email");
	
	MemberDTO member=MemberDAO.getDAO().selectEmailMember(email);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bag&Bag</title>
<style type="text/css">
div {
	text-align: center;
	margin: 10px;
}	

.id { color: red; }
</style>
</head>
<body>
	<% if(member==null) { //사용가능%>
		<div>입력한 <span class="member_email">[<%=email %>]</span>는 사용 가능한 이메일입니다.</div>
		<div>
			<button type="button" onclick="windowClose();">이메일 사용</button>
		</div>
		
		<script type="text/javascript">
		function windowClose() {
			opener.joinForm.member_email.value="<%=email%>";
			opener.joinForm.emailCheckResult.value=1;
			window.close();
		}
		</script>
	<% } else { //사용불가능%>
		<div id="message">입력한 <span class="member_email">[<%=email %>]</span>는 이미 사용중인 이메일입니다.
			<br>다른 이메일을 입력하고 [확인] 버튼을 눌러주세요.
		</div>
		
		<div>
			<form name="chekcForm">
				<input type="text" name="email">
				<button type="button" id="btn">확인</button>
			</form>
		</div>
		
		<script type="text/javascript">
		document.getElementByEamil("btn").onclick=function() {
			var email=chekcForm.email.value;
			if(email=="") {
				document.getElementById("message").innerHTML="이메일을 입력해 주세요.";
				document.getElementById("message").style="color:red;";
				return;
			}
			
			var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
			if(!emailReg.test(member_email)) {
				document.getElementById("message").innerHTML="이메일 형식으로만 가능합니다.";
				document.getElementById("message").style="color:red;";
				return;	
			}
			
			chekcForm.submit();
		}
		</script>
	<% } %>
</body>
</html>