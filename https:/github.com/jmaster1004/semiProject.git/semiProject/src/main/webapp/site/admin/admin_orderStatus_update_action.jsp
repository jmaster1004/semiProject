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

	String status = request.getParameter("cago_update_val");
	String orderNo = request.getParameter("orderNO");
	int rows;
	
	
	rows = OrdersDAO.getDAO().updateOrderStatus(orderNo, status);
	
	if(rows==1){
		out.println("<script type='text/javascript'>");
		out.println("alert(\"정보가 수정되었습니다.\")");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=admin&work=admin_order_list'");
		out.println("</script>");
	} else {
		out.println("<script type='text/javascript'>");
		out.println("alert(\"뭔가 잘못됐음.\")");
		out.println("</script>");
	}
	

%>