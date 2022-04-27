
<%@page import="xyz.itwill.dao.QaDAO"%>
<%@page import="xyz.itwill.dto.QaDTO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/site/security/login_check.jspf"%>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}

	//전달값을 반환받아 저장
	
	int num=Integer.parseInt(request.getParameter("num"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	//전달값에 태그 관련 기호가 있는 경우 회피문자로 변환하여 저장 - XSS 공격에 대한 방어
	String qaTitle=Utility.escapeTag(request.getParameter("qaTitle"));
	String qaContent=Utility.escapeTag(request.getParameter("qaContent"));
	
	int qaStatus=Integer.parseInt(request.getParameter("qaSecure"));//status=2;
	
	QaDTO qa=new QaDTO();
	qa.setQaNo(num);
 	qa.setQaTitle(qaTitle);
	qa.setQaContent(qaContent);
	qa.setQaStatus(qaStatus);
	
	QaDAO.getDAO().updateQa(qa);
		
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+
			"/site/index.jsp?workgroup=qa&work=qa_detail&num="+num
			+"&pageNum="+pageNum+"&search="+search+"&keyword="+keyword+"';");
	out.println("</script>");
%>












