<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="xyz.itwill.dto.ReviewDTO"%>
<%@page import="xyz.itwill.dao.ReviewDAO"%>
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
	String saveDirectory=request.getServletContext().getRealPath("/site/review_image");
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	String pageNum=multipartRequest.getParameter("pageNum");
	
	String orderItem=multipartRequest.getParameter("orderItem");
	String orderItemCD=multipartRequest.getParameter("orderItemCD");

	
	String reviewWriter=multipartRequest.getParameter("reviewWriter");
	//전달값에 태그 관련 기호가 있는 경우 회피문자로 변환하여 저장 - XSS 공격에 대한 방어 
	String reviewTitle=Utility.escapeTag(multipartRequest.getParameter("reviewTitle"));
	String reviewContent=Utility.escapeTag(multipartRequest.getParameter("reviewContent"));
	
	int reviewGrade=Integer.parseInt(multipartRequest.getParameter("reviewGrade"));
	String reviewImg=multipartRequest.getFilesystemName("reviewImg");
	//BOARD_SEQ 시퀀스의 다음 값을 검색하여 반환하는 DAO 클래스의 메소드를 호출
	// => 새글 또는 답글의 글번호(num 컬럼값)로 저장
	int reviewNo=ReviewDAO.getDAO().selectNextNo(); 
	

	//DTO 인스턴스를 생성하고 필드값 변경
	ReviewDTO review=new ReviewDTO();
	review.setReviewNo(reviewNo);
	review.setItemCd(orderItemCD);
	review.setItemNm(orderItem);
	review.setMemberEmail(reviewWriter);
	//review.setMemberEmail(loginMember.getEmail());
	review.setReviewTitle(reviewTitle);
	review.setReviewContent(reviewContent);
	review.setReviewGrade(reviewGrade);
	review.setReviewImg(reviewImg);
	//review.setMemberName(memberName);
	//review.setMemberName(loginMember.getName());
	
	//게시글을 전달받아 BOARD 테이블에 저장하는 DAO 클래스의 메소드 호출
	ReviewDAO.getDAO().insertReview(review);
	
	//페이지이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=review&work=review_list&pageNum"+pageNum+"';");
	out.println("</script>");


%>