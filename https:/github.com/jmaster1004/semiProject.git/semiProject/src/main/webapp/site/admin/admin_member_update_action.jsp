<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
if(request.getMethod().equals("GET")) {
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
	out.println("</script>");
	return;
}	


	int status = Integer.parseInt(request.getParameter("member_status"));

	MemberDTO member = new MemberDTO();
	member.setMemberEmail(request.getParameter("member_email"));
	member.setMemberName(request.getParameter("member_name"));
	member.setMemberPhone(request.getParameter("member_phone1") +"-"+ request.getParameter("member_phone2") +"-"+ request.getParameter("member_phone3"));
	member.setMemberZipcode(request.getParameter("member_zipcode"));
	member.setMemberAddress1(request.getParameter("member_address1"));
	member.setMemberAddress2(request.getParameter("member_address2"));
	member.setMemberStatus(status);
	
	int rows = MemberDAO.getDAO().updateMember(member);

	if(rows==1){
		out.println("<script type='text/javascript'>");
		out.println("alert(\"회원 정보가 수정되었습니다.\")");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=admin&work=admin_member_list'");
		out.println("</script>");
	} else {
		out.println("<script type='text/javascript'>");
		out.println("alert(\"뭔가 잘못됐음.\")");
		out.println("</script>");
	}
%>