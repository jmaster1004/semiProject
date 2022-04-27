<%@page import="xyz.itwill.dao.OrdersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}	

	
	int cancelOrderNo = Integer.parseInt(request.getParameter("cancelOrderNo"));
	String cancelOrderStatus = request.getParameter("cancelOrderStatus");
	
	if(cancelOrderNo!=0) {
		OrdersDAO.getDAO().cancelOrderStatus(cancelOrderNo, "21");
	} 
	
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=order&work=order_list';");
	out.println("</script>");


%>