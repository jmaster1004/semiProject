<%@page import="xyz.itwill.dao.categoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}	

	String name = request.getParameter("cago_delete_val");

	int rows = categoryDAO.getDAO().deleteCategory(name);
	
	if(rows!=1){
		out.println("<script type='text/javascript'>");
		out.println("alert(\"뭔가 잘못된듯?\")");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=admin&work=admin_category'");
		out.println("</script>");
	} else {
		out.println("<script type='text/javascript'>");
		out.println("alert(\"삭제했슴다\")");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=admin&work=admin_category'");
		out.println("</script>");
	}
	
%>
