<%@page import="xyz.itwill.dto.cartDTO"%>
<%@page import="xyz.itwill.dao.cartDAO"%>
<%@page import="xyz.itwill.dao.OrdersDAO"%>
<%@page import="xyz.itwill.dto.OrdersDTO"%>
<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}	

	String buyItemCD = request.getParameter("buy_ItemCD");
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	OrdersDTO orders =null;
	if(buyItemCD!=null){
		int each = Integer.parseInt(request.getParameter("buy_ItemEach"));
		orders = new OrdersDTO();
		orders.setMemberEmail((String)loginMember.getMemberEmail());
		orders.setItemCd(buyItemCD);
		orders.setOrderStatus(1);
		orders.setOrderQuantity(each);
		orders.setOrderAddress1(request.getParameter("address"));
		orders.setOrderAddress2(request.getParameter("detailAddress"));
		orders.setOrderZipcode(request.getParameter("zipCode"));
		orders.setOrderPhone(request.getParameter("phone"));
		orders.setOrderName(request.getParameter("rname"));
		orders.setOrderMemo(request.getParameter("memo"));
		OrdersDAO.getDAO().insertOrders(orders);
	} else {
		String[] cartNo = request.getParameterValues("cartNo");
		String[] itemCd = request.getParameterValues("cart_ItemCD"); //아이템 코드
		String[] each = request.getParameterValues("cart_Each");
		int[] orderQuantity= new int[itemCd.length];
		
		List<cartDTO> cartList=null;
		for(int i=0; i<itemCd.length; i++){
			orderQuantity[i] =Integer.parseInt(each[i]);
			orders = new OrdersDTO();
			orders.setMemberEmail((String)loginMember.getMemberEmail());
			orders.setItemCd(itemCd[i]);
			orders.setOrderStatus(1);
			orders.setOrderQuantity(orderQuantity[i]);
			orders.setOrderAddress1(request.getParameter("address"));
			orders.setOrderAddress2(request.getParameter("detailAddress"));
			orders.setOrderZipcode(request.getParameter("zipCode"));
			orders.setOrderPhone(request.getParameter("phone"));
			orders.setOrderName(request.getParameter("rname"));
			orders.setOrderMemo(request.getParameter("memo"));
			OrdersDAO.getDAO().insertOrders(orders);
		}

		for(int i=0; i<cartNo.length;i++){
			System.out.println(cartNo[i]);
			cartDAO.getDAO().deleteCart(cartNo[i]);
	
		}
	}
	
	out.println("<script type='text/javascript'>");
	out.println("alert(\"주문 등록이 완료되었습니다.\")");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=order&work=order_list'");
	out.println("</script>");
%>