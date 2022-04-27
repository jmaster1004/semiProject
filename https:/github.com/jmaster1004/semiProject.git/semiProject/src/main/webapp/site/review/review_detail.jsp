<%@page import="xyz.itwill.dao.OrdersDAO"%>
<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@page import="xyz.itwill.dao.ReviewDAO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="xyz.itwill.dto.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("reviewNo")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}

	//전달값을 반환받아 저장
	int reviewNo=Integer.parseInt(request.getParameter("reviewNo"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	String orderItem=request.getParameter("orderItem");
	
	//글번호를 전달받아 BOARD 테이블에 저장된 해당 글번호의 게시글을 검색하여 반환하는 DAO 클래스의 메소드를 호출
	ReviewDTO review=ReviewDAO.getDAO().selectNoReview(reviewNo);
	
	//검색된 게시글이 없거나 삭제글인 경우에 대한 응답처리 => 비정상적인 요청에 대한 응답 처리
	if(review==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}
	
	//세션에 저장된 권한 관련 정보(회원정보)를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	//글번호를 전달받아 BOARD 테이블에 저장된 해당 글번호의 게시글에 조회수를 증가하는 DAO 클래스의 메소드 호출
	ReviewDAO.getDAO().updateReviewCount(reviewNo);
	
	
%> 

<div id="wrap">
	<div class="site-wrap">
		<div class="xans-element- xans-board xans-board-readpackage-4 xans-board-readpackage xans-board-4 ">
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
					<br>
					<h2>
						<font color="333333">상품리뷰</font>
					</h2>
					<p>상품 리뷰입니다.</p>
				</div>
			</div>
				<div
					class="xans-element- xans-board xans-board-read-4 xans-board-read xans-board-4">
			<div class="ec-base-table typeWrite ">
						<table border="1" summary="">
							<caption>상품 게시판 상세</caption>
							<colgroup>
								<col style="width: 130px;">
								<col style="width: auto;">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">상품명</th>
									<td><%=review.getItemNm() %></td>
								</tr>
								<tr>
									<th scope="row">제목</th>
									<td>
										<%=review.getReviewTitle() %>
									</td>
								</tr>
								<tr>
									<th scope="row">작성자</th>
									<td><%=MemberDAO.getDAO().selectEmailMember(review.getMemberEmail()).getMemberName() %> </td>
								</tr>
								<tr>
									<th scope="row">작성일</th>
									<td><%=review.getReviewDate().substring(0, 10) %> &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
									 	조회수 &emsp; <%=review.getReviewCount() %> &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
									 	평점 &emsp; <% if(review.getReviewGrade()==1) {	%>
													★
												<% } else if(review.getReviewGrade()==2){%>
													★★
												<% } else if(review.getReviewGrade()==3) {%>
													★★★
												<% } else if (review.getReviewGrade()==4) {%>
													★★★★
												<% } else if (review.getReviewGrade()==5) {%>
													★★★★★
												<% } %>
								</tr>
								<tr>
									<th><br>내용</th>
									
									<td>	
										<br>									
										<%=review.getReviewContent().replace("\n", "<br>") %>
										<br>
										<br>
									</td>
								</tr>
								<tr>
									<th scope="row">이미지</th>
									<% if(review.getReviewImg()==null) { %>
										<td>&nbsp;</td>
									<% } else { %>
									<td><img alt="<%=request.getContextPath()%>/site/review_image/<%=review.getReviewImg() %>" src="<%=request.getContextPath()%>/site/review_image/<%=review.getReviewImg() %>" width="250"></td>
									<% } %>
								</tr>

							</tbody>
						</table>
					</div>
					<div class="ec-base-button ">
						<span class="gLeft">
						<% String reviewURL=(String)session.getAttribute("reviewURL"); %>
							<%if(reviewURL!=null) { %>
								 <a href=<%=reviewURL %> class="btnNormalFix sizeS" id="listBtn">목록</a>
								 <%session.removeAttribute("reviewURL"); %>
							<%}else { %>
								 <a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_list&pageNum=<%=pageNum %>" class="btnNormalFix sizeS" id="listBtn">목록</a>
							<% } %>			
						</span> 
						<span class="gRight"> 
						
						<% if(loginMember!=null && (loginMember.getMemberEmail().equals(review.getMemberEmail())
								||loginMember.getMemberStatus()==9)) { %>
							<button type="button" id="removeBtn" class="btnNormalFix sizeS displaynone">삭제</button>
							<button type="button" id="modifyBtn" class="btnEmFix sizeS displaynone">수정</button>
						<% } %>
						</span>
					</div>
				</div>
		</div>
		<div>
			<form id="reviewForm" method="post">
				<%-- 글 삭제와 글변경을 클릭한 경우 요청 JSP 문서에 전달되는 값  --%>
				<input type="hidden" name="review_no" value="<%=review.getReviewNo()%>"> 
				
				<%-- [글목록]을 클릭한 경우 요청 JSP 문서에 전달되는 값 --%>
				<input type="hidden" name="pageNum" value="<%=pageNum %>">
				<input type="hidden" name="search" value="<%=search %>">
				<input type="hidden" name="keyword" value="<%=keyword %>">
			</form>
		</div>

	</div>
</div>
	
<script type="text/javascript">
$("#removeBtn").click(function () {
	if(confirm("게시글을 삭제 하시겠습니까?")) {
		$("#reviewForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_remove_action");
	 	$("#reviewForm").submit();
	}
});	

$("#modifyBtn").click(function () {
	$("#reviewForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_modify");
 	$("#reviewForm").submit();
});	

$("#listBtn").click(function () {
	$("#reviewForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_list");
 	$("#reviewForm").submit();
});	

</script>