<%@page import="xyz.itwill.dao.cartDAO"%>
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

	request.setCharacterEncoding("UTF-8");
	//String itemCD = (String)request.getParameter("ItemCD");
	//String each = (String)request.getParameter("each");
	
	String[] itemCD = request.getParameterValues("cart_ItemCD");
	String[] each = request.getParameterValues("cart_each");
	
	
	for(int i = 0; i<=(itemCD.length-1);i++){
		cartDAO.getDAO().updateCart(itemCD[i], each[i]);                
		                                                                
		//System.out.println(itemCD[i]+"\t"+each[i]); //점검용          
	}                                                                   
                                                                        
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=cart&work=cart'");
	out.println("</script>");
%>