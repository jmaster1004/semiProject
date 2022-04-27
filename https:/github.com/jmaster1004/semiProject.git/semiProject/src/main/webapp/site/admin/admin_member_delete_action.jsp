<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}	


	String email = request.getParameter("delete_email");
	String email_data = request.getParameter("email_data");
	System.out.println(email);
	System.out.println(email_data);
	if(email.contentEquals(email_data)){
		int rows = MemberDAO.getDAO().deleteMember(email);

		if(rows==1){
		out.println("<script type='text/javascript'>");
		out.println("alert(\"회원 정보가 비활성화되었습니다.\")");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=admin&work=admin_member_list'");
		out.println("</script>");
		} else{
			out.println("<script type='text/javascript'>");
			out.println("alert(\"뭔가 잘못됐음.\")");
			out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=admin&work=admin_member_list'");
			out.println("</script>");
		}
	} else {
		out.println("<script type='text/javascript'>");
		out.println("alert(\"아이디 틀렸쥬.\")");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=admin&work=admin_member_list'");
		out.println("</script>");
	}

	
%>