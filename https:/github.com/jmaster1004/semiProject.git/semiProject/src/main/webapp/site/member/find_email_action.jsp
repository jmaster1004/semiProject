<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%

String name=request.getParameter("member_name"); //받아온값 넣기

System.out.println(name);
String phone=request.getParameter("member_phone1")+"-"
	+request.getParameter("member_phone2")+"-"+request.getParameter("member_phone3");
String email=null;


MemberDTO member=MemberDAO.getDAO().serchEmailMember(name, phone);

if (member==null || !member.getMemberName().equals(name)){
	session.setAttribute("message", "입력된 정보가 없습니다.");
	out.println("<script type='text/javascript'>");
	out.println("alert('입력된 정보가 없습니다.');");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=member&work=find_email';");
	out.println("</script>");
	return;
} else if(!member.getMemberName().equals(name) && !member.getMemberPhone().equals(phone)) {
		session.setAttribute("name", name);
		session.setAttribute("phone", phone);
		session.setAttribute("message", "입력된 정보가 모두 일치하지 않습니다.");
		out.println("<script type='text/javascript'>");
		out.println("alert('입력된 정보를 다시 확인해 주세요.');");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=member&work=find_email';");
		out.println("</script>");
		return;
	} else if(!member.getMemberPhone().equals(phone)){
	session.setAttribute("phone", phone);
	session.setAttribute("message", "입력한 핸드폰번호가 존재하지 않습니다.");
	out.println("<script type='text/javascript'>");
	out.println("alert('입력한 핸드폰번호가 존재하지 않습니다.');");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=member&work=find_email';");
	out.println("</script>");
	return;
} else if(!member.getMemberName().equals(name)){
	session.setAttribute("name", name);
	session.setAttribute("message", "입력한 이름이 존재하지 않습니다.");
	out.println("<script type='text/javascript'>");
	out.println("alert('입력한 핸드폰번호가 존재하지 않습니다.');");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=member&work=find_eamil';");
	out.println("</script>");
	return;
}else{
	email=member.getMemberEmail();	
}

%>

<div id="wrap">
	<div class="site-wrap">

		<div class="path">
			<span>현재 위치</span>
			<ol>
				<li><a href="/">홈</a></li>
				<li title="현재 위치"><strong>이메일 찾기</strong></li>
			</ol>
		</div>

		<div class="titleArea">
			<% if(email != null) { %>
				<h2>회원님의 이메일을 찾았습니다.</h2>
				<% } else { %>
				<h2>회원님의 이메일을 찾지 못했습니다.</h2>
				<% } %>
			</div>
			<div>
				<% if(email != null) { %>
				<div>
					<li>회원님의 이메일은 <%=email%>입니다.</li>
				</div>
				<div>
					<a class="btnNormal sizeS" href="<%=request.getContextPath()%>/site/index.jsp?workgroup=member&work=find_passwd">비밀번호 변경</a>
				<div>
				</div>
				<% } else { %>
				<div>
					<li>회원님의 이메일을 찾지 못했습니다.</li>
				</div>
				<div>
					<a class="btnNormal sizeS" href="<%=request.getContextPath()%>/site/index.jsp?workgroup=member&work=find_email">다시찾기</a>
					<a class="btnNormal sizeS" href="<%=request.getContextPath()%>/site/index.jsp?workgroup=member&work=find_passwd">비밀번호 변경</a>
				</div>
				<% } %>
				<div>
					<a class="btnSubmitFix sizeM" href="<%=request.getContextPath()%>/site/index.jsp?workgroup=member&work=login">로그인</a>
					<a class="btnEmFix sizeM" href="<%=request.getContextPath()%>/site/index.jsp?workgroup=main&work=main">메인</a>
				</div>
			</div>
		</div>
	</div>
</div>
