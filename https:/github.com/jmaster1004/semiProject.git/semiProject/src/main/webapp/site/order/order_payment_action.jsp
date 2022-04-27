<%@page import="xyz.itwill.dao.OrdersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%

	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}	


	String a = request.getParameter("payment2");
	String b = request.getParameter("payment3");
	String orderNo = request.getParameter("payment4");
	
	if(a.contentEquals(b)){
		OrdersDAO.getDAO().updateOrderStatus(orderNo, "2");
		out.println("<script type='text/javascript'>");
		out.println("alert(\"정보가 수정되었습니다.\")");
		//out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=order&work=order_list'");
		
		out.println("opener.document.location.reload();");
		out.println("self.close();");
		out.println("</script>");
	} else {
		out.println("<script type='text/javascript'>");
		out.println("alert(\"뭔가 잘못됐음.\")");
		out.println("self.close();");
		out.println("</script>");
	}
%>
