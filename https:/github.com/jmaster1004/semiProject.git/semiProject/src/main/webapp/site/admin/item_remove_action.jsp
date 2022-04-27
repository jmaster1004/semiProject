<%@page import="java.io.File"%>
<%@page import="xyz.itwill.dao.ItemDAO"%>
<%@page import="xyz.itwill.dto.ItemDTO"%>
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
	
	ItemDTO item = ItemDAO.getDAO().selectNumItem(num);
	
	ItemDAO.getDAO().deleteItem(num);
	
	String saveDirectory=request.getServletContext().getRealPath("/site/item_image");

	new File(saveDirectory, item.getItemMainImage()).delete();
	new File(saveDirectory, item.getItemCttImage1()).delete();
	new File(saveDirectory, item.getItemCttImage2()).delete();
	new File(saveDirectory, item.getItemCttImage3()).delete();
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=admin&work=item_manager';");
	out.println("</script>");
	

%>
