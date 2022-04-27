<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String workgroup =request.getParameter("workgroup");
	if(workgroup==null) workgroup="main";
	
	String work=request.getParameter("work");
	if(work==null) work="main";
	
	String headerPath="header.jsp";
	if(workgroup.equals("admin")) {//관리자 페이지를 요청한 경우
		headerPath="admin/admin_header.jsp";
	}
	
	String contentPath=workgroup+"/"+work+".jsp";
	request.setAttribute("contentPath", contentPath);
	/*
	*/
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">

<%if(contentPath.equals("order/order_join.jsp")||contentPath.equals("order/order_item_join.jsp")){ %>
	<link rel="stylesheet" type="text/css" href="css/order.css">
<% } else {%>
<link rel="stylesheet" type="text/css" href="css/all.css">
<link rel="stylesheet" type="text/css" href="css/optimizer.css">
<%}%>


<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<title>bag&bag</title>
</head>
<body>
<%if(contentPath.equals("order/order_join.jsp")||contentPath.equals("order/order_item_join.jsp")||contentPath.equals("order/order_payment.jsp")){ %>
	<div id="content">
		<jsp:include page="<%= contentPath %>"/>
	</div>
<% } else {%>


	<div id="header">
		<jsp:include page="<%=headerPath%>"/>
	</div>
	
	<div id="content">
		<jsp:include page="<%=contentPath %>"/>
	</div>
	
	<div id="footer">
		<jsp:include page="footer.jsp"/>
	</div>
<%}%>
</body>
</html>