<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 회원정보를 전달받아 MEMBER 테이블에 저장된 회원정보를 변경하고 회원정보 출력페이지
(member_detail.jsp)로 이동하는 JSP 문서 --%>
<%-- => 비로그인 사용자가 JSP 문서를 요청한 경우 비정상적인 요청이므로 에러페이지로 이동 --%>
<%@include file="/site/security/login_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답처리 - 에러페이지 이동
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}

	//전달값을 반환받아 저장
	String memberemail=request.getParameter("member_email");
	String memberpasswd=request.getParameter("member_password");
	if(memberpasswd==null || memberpasswd.equals("")) {//비밀번호가 전달되지 않은 경우
		//로그인 사용자의 비밀번호를 변수에 저장 - 기존 비밀번호로 변경
		memberpasswd=loginMember.getMemberPassword();
	} else {
		//전달받은 비밀번호를 암호화 처리하여 변수에 저장 - 새로운 비밀번호로 변경
		memberpasswd=Utility.encrypt(memberpasswd);
	}
	String membername=request.getParameter("member_name");
	String memberphone=request.getParameter("member_phone1")+"-"
		+request.getParameter("member_phone2")+"-"+request.getParameter("member_phone3");
	String memberzipcode=request.getParameter("member_zipcode");
	String memberaddress1=request.getParameter("member_address1");
	String memberaddress2=Utility.stripTag(request.getParameter("member_address2"));
	
	//DTO 인스턴스를 생성하고 전달값으로 필드값 변경
	MemberDTO member=new MemberDTO();
	member.setMemberEmail(memberemail);
	member.setMemberPassword(memberpasswd);
	member.setMemberName(membername);
	member.setMemberPhone(memberphone);
	member.setMemberZipcode(memberzipcode);
	member.setMemberAddress1(memberaddress1);
	member.setMemberAddress2(memberaddress2);
	
	//회원정보를 전달받아 MEMBER 테이블에 저장된 회원정보를 변경하는 DAO 클래스의 메소드 호출
	MemberDAO.getDAO().updateMember(member);
	
	//세션에 저장된 권한 관련 정보(회원정보) 변경
	session.setAttribute("loginMember", MemberDAO.getDAO().selectEmailMember(memberemail));
	
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=member&work=mypage';");
	out.println("alert('정보수정이 완료되었습니다.');");
	out.println("</script>");
	
%>
