<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%

 
 
String rePassword=Utility.encrypt(request.getParameter("member_repassword"));
String email=request.getParameter("member_email");
String name=request.getParameter("member_name");
String phone=request.getParameter("member_phone");
 
 MemberDTO member=new MemberDTO();
 member.setMemberPassword(rePassword);
 member.setMemberEmail(email);
 member.setMemberName(name);
 member.setMemberPhone(phone);
 
 

 
	 MemberDAO.getDAO().updatePasswdMember(member);

 	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=member&work=login';");
	out.println("alert('비밀번호 변경이 완료되었습니다.');");
	out.println("</script>");
 %>