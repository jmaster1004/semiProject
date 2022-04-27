<%@page import="java.io.File"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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

	String saveDirectory=request.getServletContext().getRealPath("/site/notice_image");
	
	MultipartRequest multipartRequest= new MultipartRequest(request, saveDirectory
			, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());

	int num=Integer.parseInt(multipartRequest.getParameter("num"));
	String currentImage=multipartRequest.getFilesystemName("currentImage");	
	String pageNum=multipartRequest.getParameter("pageNum");
	String noticeTitle=Utility.escapeTag(multipartRequest.getParameter("noticeTitle"));
	String noticeContent=Utility.escapeTag(multipartRequest.getParameter("noticeContent"));
	String image=multipartRequest.getFilesystemName("image");	
	int noticeStatus=1;
	if(multipartRequest.getParameter("noticeStatus")!=null) {
		noticeStatus=Integer.parseInt(multipartRequest.getParameter("noticeStatus"));
	}
	
		
	
	NoticeDTO notice=new NoticeDTO();
	notice.setNoticeNo(num);
	notice.setMemberEmail("jmaster1020@gmail.com");
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	if(image!=null){
		notice.setNoticeImage(image);
		new File(saveDirectory, currentImage).delete();
	} else {
		notice.setNoticeImage(currentImage);
	}
	notice.setNoticeStatus(noticeStatus);	

	NoticeDAO.getDAO().insertNotice(notice);
		
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=notice&work=notice_detail&num="+num+"';");
	out.println("</script>");
%>












