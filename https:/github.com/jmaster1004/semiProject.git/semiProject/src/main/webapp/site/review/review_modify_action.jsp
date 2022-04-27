<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@page import="xyz.itwill.dao.ReviewDAO"%>
<%@page import="xyz.itwill.dto.ReviewDTO"%>
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
	
	String saveDirectory=request.getServletContext().getRealPath("/site/review_image");
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	String currentImage=multipartRequest.getFilesystemName("currentImage");
	System.out.println("currentImage="+currentImage);

	
	
	int reviewNo=Integer.parseInt(multipartRequest.getParameter("reviewNo"));////테이블에 전달해서 실행해야 하기 때문에 정수값int로 가져옴
	String pageNum=multipartRequest.getParameter("pageNum");
	String search=multipartRequest.getParameter("search");
	String keyword=multipartRequest.getParameter("keyword");
	int reviewGrade=Integer.parseInt(multipartRequest.getParameter("reviewGrade"));
	//String reviewTitle=request.getParameter("reviewTitle");
	//String reviewContent=request.getParameter("reviewContent");
	String reviewImg=multipartRequest.getFilesystemName("reviewImg");
	
	System.out.println(reviewImg);
	
	String reviewTitle=Utility.escapeTag(multipartRequest.getParameter("reviewTitle"));
	String reviewContent=Utility.escapeTag(multipartRequest.getParameter("reviewContent"));
	
	//DTO 인스턴스를 생성하고 필드값 변경
	ReviewDTO review=new ReviewDTO();
	review.setReviewNo(reviewNo); ////글번호 비교하기 때문에
	review.setReviewTitle(reviewTitle); 
	review.setReviewContent(reviewContent);	
	review.setReviewGrade(reviewGrade);	
/* 	review.setReviewImg(reviewImg);	
 */	if(currentImage!=null){
		review.setReviewImg(reviewImg);
		new File(saveDirectory, currentImage).delete();
	} else {
		review.setReviewImg(reviewImg);
	}
	
	//게시글을 전달받아 BOARD 테이블에 저장된 게시글을 변경하는 DAO 클래스의 메소드 호출
	ReviewDAO.getDAO().updateReview(review);
	
	// 페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()
				+"/site/index.jsp?workgroup=review&work=review_detail&reviewNo="+reviewNo
				+"&pageNum="+pageNum+"&search="+search+"&keyword="+keyword+"';");
	out.println("</script>");
%>