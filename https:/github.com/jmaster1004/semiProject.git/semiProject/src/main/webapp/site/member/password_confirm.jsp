<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 회원정보변경 또는 회원탈퇴를 위해 비밀번호를 입력하는 JSP 문서 --%>
<%-- => 비로그인 사용자가 JSP 문서를 요청한 경우 비정상적인 요청이므로 에러페이지로 이동 --%>
<%-- => 전달값에 비교하여 form 태그의 요청 JSP 문서를 구분 --%>
<%@include file="/site/security/login_check.jspf" %>
<%
	//전달값을 반환받아 저장
	String action=request.getParameter("action");
	
	//전달값이 없거나 비정상적인 값이 전달된 경우 에러페이지로 이동
	if(action==null || !action.equals("modify") && !action.equals("remove")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}
	
	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
%>

<div id="wrap">
	<div class="site-wrap">
	
		<div class="path">
			<span>현재 위치</span>
			<ol>
				<li><a href="/">홈</a></li>
				<li title="현재 위치"><strong>회원 탈퇴 확인</strong></li>
			</ol>
		</div>

		<div class="titleArea">
			<h2><% if(action.equals("modify")) { %>
				<h2>회원정보변경</h2>
				<% } else { %>
				<h2>회원탈퇴</h2>
				<% } %>
			</h2>
			<ul>
				<% if(action.equals("modify")) { %>
				<li>회원정보 변경이 가능합니다.</li>
				<li>회원정보변경을 위해 비밀번호를 입력해 주세요.</li>
				<% } else { %>
				<li>회원 탈퇴가 가능합니다.</li>
				<li>회원탈퇴를 위해 비밀번호를 입력해 주세요.</li>
				<% } %>
			</ul>
		</div>

		<form id="passwordForm" name="passwordForm" method="post">
			<div class="xans-element- xans-member xans-member-findpasswd ec-base-box typeThin "  align="center">
				<div  align="center">
				 <fildset>
				 	<legend>비밀번호 찾기</legend>
						<ul class="ec-base-desc">
							<li></li>
							
							<li class="gBlank20">
						
							<span class="desc" align="center">
								<input type="password" name="member_password" placeholder="현재 비밀번호" >
							</span>
							</li>
						</ul>
						<p id="message" style="color: red;"><%=message %></p>
						<div>
							<button class="btnSubmitFix sizeM" type="button" onclick="submitCheck();">입력완료</button>
							<a class="btnEmFix sizeM" href="<%=request.getContextPath()%>/site/index.jsp?workgroup=member&work=mypage">취소</a>
						</div>
					</fildset>
				</div>			
			</div>
		</form>
	</div>
</div>
<script type="text/javascript">
passwordForm.member_password.focus();

function submitCheck() {
	if(passwordForm.member_password.value=="") {
		document.getElementById("message").innerHTML="비밀번호를 입력해 주세요.";
		passwordForm.member_password.focus();
		return;
	}
	
	<% if(action.equals("modify")) {//회원정보변경인 경우 %>
		passwordForm.action="<%=request.getContextPath()%>/site/index.jsp?workgroup=member&work=modify"
	<% } else {//회원탈퇴인 경우 %>
		passwordForm.action="<%=request.getContextPath()%>/site/index.jsp?workgroup=member&work=remove_action"
	<% } %>
	
	passwordForm.submit();
}
</script>
