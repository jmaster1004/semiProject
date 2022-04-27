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
	
	//전달값 저장
	String memberEmail=request.getParameter("member_email");
	String memberPassword=Utility.encrypt(request.getParameter("member_password")); //암호화
	String memberName=request.getParameter("member_name");
	String memberPhone=request.getParameter("member_phone1")+"-"
		+request.getParameter("member_phone2")+"-"+request.getParameter("member_phone3");
	String memberZipcode=request.getParameter("member_zipcode");
	String memberAddress1=request.getParameter("member_address1");
	String memberAddress2=Utility.stripTag(request.getParameter("member_address2"));
	
	MemberDTO member=new MemberDTO();
	member.setMemberEmail(memberEmail);
	member.setMemberPassword(memberPassword);
	member.setMemberName(memberName);
	member.setMemberPhone(memberPhone);
	member.setMemberZipcode(memberZipcode);
	member.setMemberAddress1(memberAddress1);
	member.setMemberAddress2(memberAddress2);
	
	MemberDAO.getDAO().insertMember(member);
	
	out.println("<script type='text/javascript'>");
	out.println("alert('가입이 완료 되었습니다.');");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=member&work=login';");
	out.println("</script>");
%>