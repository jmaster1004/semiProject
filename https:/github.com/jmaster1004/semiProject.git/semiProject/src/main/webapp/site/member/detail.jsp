<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 현재 로그인 사용자의 정보를 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 비로그인 사용자가 JSP 문서를 요청한 경우 비정상적인 요청이므로 에러페이지로 이동 --%>
<%-- => [회원정보변경]을 클릭한 경우 비밀번호 입력페이지(password_confirm.jsp)로 이동 --%>
<%-- => [회원탈퇴]를 클릭한 경우 비밀번호 입력페이지(password_confirm.jsp)로 이동 --%>
<%--
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");

	if(loginMember==null) {//비로그인 사용자인 경우
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}
--%> 
<%-- include Directive를 이용하여 외부파일(JSPF)의 코드를 포함하여 처리 --%>
<%@include file="/site/security/login_check.jspf" %>

<style type="text/css">
#detail {
	width: 500px;
	margin: 0 auto;
	text-align: left;
}

#mypage {
	font-size: 1.1em;
}

#mypage a:hover {
	color: orange;
}
</style>

<h1>회원상세정보</h1>
<div id="detail">
	<ul>
		<li>이메일 = <%=loginMember.getMemberEmail() %></li>
		<li>이름 = <%=loginMember.getMemberName() %></li>
		<li>전화번호 = <%=loginMember.getMemberPhone() %></li>
		<li>주소 = [<%=loginMember.getMemberZipcode()%>]
			<%=loginMember.getMemberAddress1() %> <%=loginMember.getMemberAddress2() %></li>
	</ul>
</div>
	
<div id="mypage">
	<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=member&work=password_confirm&action=modify">[회원정보변경]</a>&nbsp;&nbsp;
	<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=member&work=password_confirm&action=remove">[회원탈퇴]</a>&nbsp;&nbsp;
</div>




