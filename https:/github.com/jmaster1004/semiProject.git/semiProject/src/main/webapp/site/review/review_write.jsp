<%@page import="org.apache.catalina.storeconfig.StoreRegistry"%>
<%@page import="xyz.itwill.dao.OrdersDAO"%>
<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/site/security/login_check.jspf"%>
    
<%
String pageNum="1";
pageNum=request.getParameter("pageNum");

String orderItem=request.getParameter("orderItem");
String orderItemCD=request.getParameter("orderItemCD");
%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<div id="wrap">
	<div class="site-wrap">
		<div class="xans-element- xans-board xans-board-writepackage-4 xans-board-writepackage xans-board-4 ">
			<div class="xans-element- xans-board xans-board-title-4 xans-board-title xans-board-4 ">
				<div class="path">
					<span>현재 위치</span>
					<ol>
						<li><a href="/">홈</a></li>
						<li><a href="/board/index.html">게시판</a></li>
						<li title="현재 위치"><strong>상품 Q&amp;A</strong></li>
					</ol>
				</div>
			</div>
			<form id="reviewForm" name="reviewForm" action="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_write_action" method="post" enctype="multipart/form-data">
				<input type="hidden" name="pageNum" value="<%=pageNum%>">
				<div class="xans-element- xans-board xans-board-write-4 xans-board-write xans-board-4">
					<div class="ec-base-table typeWrite ">
						<table border="1" summary="">
							<caption>리뷰작성</caption>
							<colgroup>
								<col style="width: 130px;">
								<col style="width: auto;">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">상품명</th>
									<td>
										<input type="text" name="orderItem" id="orderItem" size="80" readonly="readonly" value="<%=orderItem %>">
										<input type="hidden" name="orderItemCD" id="orderItemCD" size="80" value="<%=orderItemCD %>">
										
									</td>
								</tr>
								<tr>
									<th scope="row">제목</th>
									<td>
										<input type="text" name="reviewTitle" id="reviewTitle" size="80">
									</td>
								</tr>
								<tr class="">
									<th scope="row">작성자</th>
									<td><%=loginMember.getMemberName() %>
									<input id="reviewWriter" name="reviewWriter" type="hidden" value="<%=loginMember.getMemberEmail() %>"></td>
									
								<tbody>
								<tr class="">
									<th scope="row">평점</th>
									<td>
										<input type="radio" name="reviewGrade" id="reviewGrade" value="1">★
										<input type="radio" name="reviewGrade" id="reviewGrade" value="2">★★
										<input type="radio" name="reviewGrade" id="reviewGrade" value="3">★★★
										<input type="radio" name="reviewGrade" id="reviewGrade" value="4">★★★★
										<input type="radio" name="reviewGrade" id="reviewGrade" value="5" checked>★★★★★
									</td>
									
								<tbody>

							</tbody>
								<tr>
									<th><br>내용</th>
									<td>
										<textarea rows="25" cols="175" name="reviewContent" id="reviewContent" style="resize:none"></textarea>
									</td>
								</tr>								
							<tbody class="">
								<tr>
									<th scope="row">이미지첨부</th>
									<td><input type="file" name="reviewImg" id="reviewImg"></td>
								</tr>
							</tbody>
						</table>
					</div>
					<br/>
					<div class="ec-base-button ">
						<span class="gRight"> 
						<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_list&pageNum=<%=pageNum %>" class="btnBasicFix sizeS" class="btnNormalFix sizeS">목록</a>
						
							 <button type="submit" class="btnSubmitFix sizeS" id="reviewSubmit">등록</button>
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
//review_grade
var reviewGrade = document.getElementsByName('reviewGrade');
var reviewGradeCheck;
for(var i=1; i<reviewGrade.length; i++) {
    if(reviewGrade[i].checked) {
        reviewGradeCheck = reviewGrade[i].value;
    }
}

$("#reviewTitle").focus();
	
$("#reviewForm").submit(function() {
	if($("#reviewTitle").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#reviewTitle").focus();
		return false;
	}

	if($("#reivewContent").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#reivewContent").focus();
		return false;
	}
});	

$("#resetBtn").click(function() { 
	$("#subject").focus();
	$("#message").text("");
});

$(document).ready(function () {
    $('#reviewSubmit').click(function () {
      var reviewGradeVal = $('input[name="reviewGrade"]:checked').val();
    });
  });

</script>


