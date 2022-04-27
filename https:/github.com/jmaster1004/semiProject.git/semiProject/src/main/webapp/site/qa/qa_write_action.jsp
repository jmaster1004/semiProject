
<%@page import="xyz.itwill.dao.QaDAO"%>
<%@page import="xyz.itwill.dto.QaDTO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}

	//전달값을 반환받아 저장
	int ref=Integer.parseInt(request.getParameter("ref"));
	int reOrder=Integer.parseInt(request.getParameter("reOrder"));
	int reLevel=Integer.parseInt(request.getParameter("reLevel"));
	String pageNum=request.getParameter("pageNum");
	
	String writer=request.getParameter("writer");

	//전달값에 태그 관련 기호가 있는 경우 회피문자로 변환하여 저장 - XSS 공격에 대한 방어
	String qaTitle=Utility.escapeTag(request.getParameter("qaTitle"));
	String qaContent=Utility.escapeTag(request.getParameter("qaContent"));
	
	int qaStatus=Integer.parseInt(request.getParameter("qaSecure"));//status=2;

	//BOARD_SEQ 시퀸스의 다음값을 검색하여 반환하는 DAO 클래스의 메소드 호출
	// => 새글 또는 답글의 글번호(num 컬럼값)로 저장
	int num=QaDAO.getDAO().selectNextNo();

	String ip=request.getRemoteAddr();
	
	if(ref==0) {//새글인 경우

		ref=num;
	} else {//답글인 경우 - ref,reStep,reLevel 변수에 부모글의 전달값이 저장

		QaDAO.getDAO().updateReOrder(ref, reOrder);

		reOrder++;
		reLevel++;
	}
	
	QaDTO qa=new QaDTO();
	qa.setQaNo(num);
	qa.setMemberEmail(writer);
	qa.setQaTitle(qaTitle);
	qa.setQaContent(qaContent);
	qa.setQaRef(ref);
	qa.setQaReOrder(reOrder);
	qa.setQaReLevel(reLevel);
	qa.setQaStatus(qaStatus);
	


	QaDAO.getDAO().insertQa(qa);
	

	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=qa&work=qa_list&pageNum="+pageNum+"';");
	out.println("</script>");
%>












