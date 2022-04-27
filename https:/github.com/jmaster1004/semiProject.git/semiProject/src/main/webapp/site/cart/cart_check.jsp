<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dto.cartDTO"%>
<%@page import="xyz.itwill.dao.cartDAO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}	

	request.setCharacterEncoding("UTF-8");
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	if(loginMember==null) {//비로그인 사용자인 경우
		//request.getRequestURI() : 클라이언트가 요청한 URI 주소를 반환하는 메소드
		//ex) http://localhost:8000/jsp/site/index.jsp?workgroup=cart&work=cart_list
		// => URI 주소 - http://localhost:8000/jsp/site/index.jsp
		// => request.getRequestURI() : /jsp/site/index.jsp
/* 		String requestURI=request.getRequestURI();
		System.out.println("requestURI = "+requestURI); */
		
		//request.getQueryString() : 클라이언트가 요청한 URL 주소의 QueryString을 반환하는 메소드
		//ex) http://localhost:8000/jsp/site/index.jsp?workgroup=cart&work=cart_list
		// => request.getQueryString() : workgroup=cart&work=cart_list
		
/* 		String queryString=request.getQueryString();
 */		
		/* "workgroup=item&work=item_list"; */
/* 		System.out.println("queryString = "+queryString);
		
		if(queryString==null || queryString.equals("")) {
			queryString="";	
		} else {
			queryString="?"+queryString;
		} */
		
		//세션에 요청 페이지의 URL 주소를 저장
/* 		session.setAttribute("url", requestURI+queryString);
 */		
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=member&work=login';");
		out.println("</script>");
		return;
	}
	
	

	String buyItemCD = request.getParameter("buy_ItemCD");
	int each = Integer.parseInt(request.getParameter("buy_ItemEach"));
	
	int rows = cartDAO.getDAO().selectUnitCart(buyItemCD, loginMember.getMemberEmail());
	
	if(rows!=0){
		out.println("<script type='text/javascript'>");
		out.println("alert(\"이미 장바구니에 있는 상품입니다.\")");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=item&work=item_list'");
		out.println("</script>");
	} else {
		cartDTO cart = new cartDTO();
		cart.setMemberEmail(loginMember.getMemberEmail());
		cart.setItemCD(buyItemCD);
		cart.setCartEach(each);
		cartDAO.getDAO().insertCart(cart);
		System.out.println(buyItemCD);
		out.println("<script type='text/javascript'>");
		out.println("alert(\"장바구니 등록이 완료되었습니다.\")");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=cart&work=cart'");
		out.println("</script>");
	}
%>