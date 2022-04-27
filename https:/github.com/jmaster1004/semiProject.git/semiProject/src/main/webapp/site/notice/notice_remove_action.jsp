<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/site/security/login_check.jspf"%>

<%
	if (request.getParameter("num") == null) {
		out.println("<script type='text/javscript'>");
		out.println("location.href='" + request.getContextPath() + "/site/index.jsp?workgroup=error&work=error404';");
		out.println("</script>");
		return;
	}
	int num = Integer.parseInt(request.getParameter("num"));
	
	NoticeDTO notice = NoticeDAO.getDAO().selectNoNotice(num);
	
	if (notice == null || notice.getNoticeStatus() == 0) {
		out.println("<script type='text/javscript'>");
		out.println("location.href='" + request.getContextPath() + "/site/index.jsp?workgroup=error&work=error404';");
		out.println("</script>");
		return;
	}
 	if(!loginMember.getMemberEmail().equals(notice.getMemberEmail()) && loginMember.getMemberStatus()!=9) {
		out.println("<script type='text/javscript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error404';");
		out.println("</script>");
		return;
	}
	
	NoticeDAO.getDAO().deleteNotice(num);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=notice&work=notice_list';");
	out.println("</script>");
	

%>
