<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}	

	String email=request.getParameter("member_email");
	String passwd=Utility.encrypt(request.getParameter("member_password"));
	
	
	MemberDTO member=MemberDAO.getDAO().selectEmailMember(email);
	if(member==null || member.getMemberStatus()==11) {//아이디에 대한 인증 실패가 발생한 경우
		session.setAttribute("member_email", email);
		session.setAttribute("message", "입력한 이메일이 존재하지 않습니다.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=member&work=login';");
		out.println("</script>");
		
		return;
	}
	
	if(!member.getMemberPassword().equals(passwd)) {//비밀번호에 대한 인증 실패가 발생한 경우
		session.setAttribute("member_email", email);
		session.setAttribute("message", "입력한 이메일이 없거나 비밀번호가 맞지 않습니다.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=member&work=login';");
		out.println("</script>");
		
		return;
	}
	
	session.setAttribute("loginMember", MemberDAO.getDAO().selectEmailMember(email));

	//세션에도 필요하면 추가해야함. 칼럼부터 추가 필요
	//MemberDAO.getDAO().updateLastLogin(email); 
	
	String url=(String)session.getAttribute("url");
	System.out.println("로그인 uri 체크 "+url);
	
	if(url==null) {//기존 요청 페이지가 없는 경우 - 메인페이지 이동
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=main&work=main';");
		out.println("</script>");
	} else {//기존 요청 페이지가 있는 경우 - 요청페이지 이동
		session.removeAttribute("url");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+url+"';");
		out.println("</script>");
	}
%>

