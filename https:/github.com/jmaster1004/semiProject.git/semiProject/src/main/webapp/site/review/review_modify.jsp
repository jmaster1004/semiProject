<%@page import="xyz.itwill.dao.ReviewDAO"%>
<%@page import="xyz.itwill.dto.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/site/security/login_check.jspf"%>
    
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("review_no")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;	
	}

	//전달값을 반환받아 저장 
	int reviewNo=Integer.parseInt(request.getParameter("review_no"));
	////변경에는 사용 안하는데 detail페이지에서 list페이지로 넘어갈때 필요
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	
	//글번호를 전달받아 BOARD 테이블에 저장된 해당 글번호의 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	ReviewDTO review=ReviewDAO.getDAO().selectNoReview(reviewNo);
	//검색된 게시글이 없거나 삭제글인 경우 => 비정상적인 요청에 대한 응답 처리
	if(review==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;	
	}
	//로그인 사용자가 게시글 작성자가 아니거나 관리자가 아닌 경우 => 비정상적인 요청에 대한 응답 처리 
	if(!loginMember.getMemberEmail().equals(review.getMemberEmail()) && loginMember.getMemberStatus()!=9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;	
	}


%>
<div id="wrap">
	<div class="site-wrap">
		<div class="xans-element- xans-board xans-board-writepackage-4 xans-board-writepackage xans-board-4 ">
			<div class="xans-element- xans-board xans-board-title-4 xans-board-title xans-board-4 ">
				<div class="path">
					<span>현재 위치</span>
					<ol>
						<li><a href="/">홈</a></li>
						<li><a href="/board/index.html">게시판</a></li>
						<li title="현재 위치"><strong>상품리뷰</strong></li>
					</ol>
				</div>
				<div class="titleArea">
					<h2>
						<font color="333333">상품리뷰</font>
					</h2>
				</div>
			</div>
			<form id="reviewForm" name="reviewForm" action="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_modify_action"
				method="post" enctype="multipart/form-data">
				
			<input type="hidden" name="currentImage" value="<%=review.getReviewImg() %>">
			<input type="hidden" name="reviewNo" value="<%=reviewNo %>">
			<input type="hidden" name="pageNum" value="<%=pageNum %>">
			<input type="hidden" name="search" value="<%=search %>">
			<input type="hidden" name="keyword" value="<%=keyword %>">
				<div class="xans-element- xans-board xans-board-write-4 xans-board-write xans-board-4">
					<div class="ec-base-table typeWrite ">
						<table border="1" summary="">
							<caption>글쓰기 폼</caption>
							<colgroup>
								<col style="width: 130px;">
								<col style="width: auto;">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">제목</th>
									<td>
										<input type="text" name="reviewTitle" id="reviewTitle" size="80" value=<%=review.getReviewTitle() %>>
									</td>
								</tr>
								<tr class="">
									<th scope="row">작성자</th>
									<td><%=loginMember.getMemberName() %></td>
								<tbody>
							</tbody>
							<tr class="">
									<th scope="row">평점</th>
									<td>
										<input type="radio" name="reviewGrade" id="reviewGrade" value="1" <% if(review.getReviewGrade()==1) { %> checked <%} %>>★
										<input type="radio" name="reviewGrade" id="reviewGrade" value="2" <% if(review.getReviewGrade()==2) { %> checked <%} %>>★★
										<input type="radio" name="reviewGrade" id="reviewGrade" value="3" <% if(review.getReviewGrade()==3) { %> checked <%} %>>★★★
										<input type="radio" name="reviewGrade" id="reviewGrade" value="4" <% if(review.getReviewGrade()==4) { %> checked <%} %>>★★★★
										<input type="radio" name="reviewGrade" id="reviewGrade" value="5" <% if(review.getReviewGrade()==5) { %> checked <%} %>>★★★★★
									</td>
							</tr>		
								<tr>
									<th><br>내용</th>
									<td>
										<textarea rows="25" cols="175" name="reviewContent" id="reviewContent" style="resize:none"><%=review.getReviewContent() %></textarea>
									</td>
								</tr>
								<tr>
									<th scope="row">이미지첨부</th>
									<td>
										<%if(review.getReviewImg()!=null){ %>
											<img alt="<%=review.getReviewImg() %>" src="<%=request.getContextPath()%>/site/review_image/<%=review.getReviewImg() %>" width="50">
											<br>
											<span style="color: red;">이미지를 변경하지 않을 경우 입력하지 마세요.</span>		
											<br>									
										<%} %>										
										<input name="reviewImg" type="file" value=<%=review.getReviewImg() %>>
									</td>	
								</tr>								
						</table>
					</div>
					<br/>
					<div class="ec-base-button ">
						<span class="gLeft"> 
								<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_list&pageNum=<%=pageNum %>" class="btnBasicFix sizeS" class="btnNormalFix sizeS">목록</a>
						</span>
						<span class="gRight"> <!-- <a href="#none"
							class="btnSubmitFix sizeS"
							onclick="BOARD_WRITE.form_submit('boardWriteForm');">등록</a>
							  -->
							 <button type="submit" class="btnSubmitFix sizeS" id="reviewSubmit" name="reviewSubmit">등록</button>
							 <a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_list&pageNum=<%=pageNum %>" class="btnBasicFix sizeS">취소</a>
						</span>
					</div>
				</div>
			</form>
		</div>

	</div>
</div>
<div id="message" style="color: red;"></div>

<script type="text/javascript">
$("#reviewTitle").focus();
	
$("#reviewForm").submit(function() {
	if($("#reviewTitle").val()=="") {
		$("#message").text("제목을 입력해주세요.");
		$("#reviewTitle").focus();
		return false;
	}
	
	if($("#reviewContent").val()=="") {
		$("#message").text("내용을 입력해주세요.");
		$("#reviewContent").focus();
		return false;
	}
});	

$("#resetBtn").click(function() { ////reset 누르면 메세지 초기화
	$("#reviewTitle").focus();
	$("#message").text("");
});
var reviewGrade = document.getElementsByName('reviewGrade');
var reviewGradeCheck;
for(var i=1; i<reviewGrade.length; i++) {
    if(reviewGrade[i].checked) {
        reviewGradeCheck = reviewGrade[i].value;
    }
}

$(document).ready(function () {
    $('#reviewSubmit').click(function () {
      var reviewGradeVal = $('input[name="reviewGrade"]:checked').val();
    });
  });
</script>
