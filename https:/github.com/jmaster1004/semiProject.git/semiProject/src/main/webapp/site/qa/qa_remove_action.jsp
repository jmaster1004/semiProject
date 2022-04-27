<%@page import="xyz.itwill.dao.QaDAO"%>
<%@page import="xyz.itwill.dto.QaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/site/security/login_check.jspf"%>
<%
	if(request.getParameter("num")==null){
		out.println("<script type='text/javscript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error404';");
		out.println("</script>");
		return;
	}
	int num=Integer.parseInt(request.getParameter("num"));
	
	QaDTO qa=QaDAO.getDAO().selectNoQa(num);
	
	if(qa==null || qa.getQaStatus()==0){
		out.println("<script type='text/javscript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error404';");
		out.println("</script>");
		return;
	}
	
	if(!loginMember.getMemberEmail().equals(qa.getMemberEmail()) && loginMember.getMemberStatus()!=9) {
		out.println("<script type='text/javscript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error404';");
		out.println("</script>");
		return;
	} 
	
	
	
	QaDAO.getDAO().deleteQa(num);

	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=qa&work=qa_list';");
	out.println("</script>");

%>
