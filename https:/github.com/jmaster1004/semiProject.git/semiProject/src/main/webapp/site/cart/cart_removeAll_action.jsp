<%@page import="xyz.itwill.dao.cartDAO"%>
<%@page import="xyz.itwill.dto.cartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}	


String id ="redmango1446@gmail.com";
	cartDAO.getDAO().deleteAllCart(id);
	

	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=cart&work=cart'");
	out.println("</script>");
%>