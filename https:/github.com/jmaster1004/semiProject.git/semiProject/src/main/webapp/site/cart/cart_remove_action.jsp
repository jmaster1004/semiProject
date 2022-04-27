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

	String[] cartno = request.getParameterValues("checkNo");
	

	for(String cartNO:cartno) {
		//아이디를 전달받아 MEMBER 테이블에 저장된 해당 아이디의 회원정보를 삭제하는 DAO 클래스의 메소드 호출
		cartDAO.getDAO().deleteCart(cartNO);
	}

	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=cart&work=cart'");
	out.println("</script>");
%>
