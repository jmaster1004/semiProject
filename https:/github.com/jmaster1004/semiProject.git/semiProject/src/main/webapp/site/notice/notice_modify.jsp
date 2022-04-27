<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/site/security/login_check.jspf"%>
 <%
 	if(request.getParameter("num")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;	
	}
	
	int num=Integer.parseInt(request.getParameter("num"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	NoticeDTO notice=NoticeDAO.getDAO().selectNoNotice(num);

	if(notice==null || notice.getNoticeStatus()==0) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;	
	}
	
	//로그인 사용자가 게시글 작성자가 아니거나 관리자가 아닌 경우 => 비정상적인 요청에 대한 응답 처리 
	if(loginMember.getMemberStatus()!=9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;	
	} 
%>
	
<div id="wrap">
	<div class="site-wrap">


		<div
			class="xans-element- xans-board xans-board-writepackage-4 xans-board-writepackage xans-board-4 ">
			<div
				class="xans-element- xans-board xans-board-title-4 xans-board-title xans-board-4 ">
				<div class="path">
					<span>현재 위치</span>
					<ol>
						<li><a href="/">홈</a></li>
						<li><a href="/board/index.html">게시판</a></li>
						<li title="현재 위치"><strong>공지사항</strong></li>
					</ol>
				</div>
				<div class="titleArea">
					<h2>
						<font color="333333">공지사항</font>
					</h2>
	  					<p>공지사항입니다.</p>
				</div>
			</div>
			<form id="noticeForm" name="" action="<%=request.getContextPath()%>/site/index.jsp?workgroup=notice&work=notice_write_action"
				method="post" enctype="multipart/form-data" id="noticeForm" accept-charset="utf-8">

				<input type="hidden" name="num" value="<%=num%>">
				<input type="hidden" name="pageNum" value="<%=pageNum%>">
				<input type="hidden" name="search" value="<%=search%>">
				<input type="hidden" name="keyword" value="<%=keyword%>">
				<input type="hidden" name="currentImage" value="<%=notice.getNoticeImage()%>">
				<div
					class="xans-element- xans-board xans-board-write-4 xans-board-write xans-board-4">
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
										<input type="text" name="noticeTitle" id="noticeTitle" size="80" value=<%=notice.getNoticeTitle() %>>
										<input type="checkbox" name="noticeStatus" value="2"
											<% if(notice.getNoticeStatus()==2) { %> checked="checked" <% } %>>필독
									</td>
								</tr>
								<tr class="">
									<th scope="row">작성자</th>
									<td><%=notice.getMemberName() %></td>
								<tbody>
							<tbody class="">
								<tr>
									<th scope="row">첨부파일</th>
									<td>
										<%if(notice.getNoticeImage()!=null){ %>
											<img alt="<%=notice.getNoticeImage() %>" src="<%=request.getContextPath()%>/site/notice_image/<%=notice.getNoticeImage() %>" width="50">
											<br>
											<span style="color: red;">이미지를 변경하지 않을 경우 입력하지 마세요.</span>		
											<br>									
										<%} %>										
										<input name="image" type="file" value=<%=notice.getNoticeTitle() %>>
									</td>
								</tr>
							</tbody>
								<tr>
									<th><br>내용</th>
									<td>
										<textarea rows="25" cols="175" name="noticeContent" id="noticeContent" style="resize:none" ><%=notice.getNoticeContent() %></textarea>
									</td>
								</tr>								
						</table>
					</div>
					<br/>
					<div class="ec-base-button ">
						<span class="gRight"> 
							 <button type="submit" class="btnSubmitFix sizeS">수정</button>
							 <a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=notice&work=notice_list&pageNum=<%=pageNum %>" class="btnBasicFix sizeS">취소</a>
						</span>
					</div>
				</div>
			</form>
		</div>

	</div>
</div>
<script type="text/javascript">
$("#title").focus();

$("#noticeForm").submit(function() {
	if($("#noticeTitle").val()=="") {
		alert("제목을 입력해 주세요.");
/* 		$("#message").text("제목을 입력해 주세요.");
 */		$("#subject").focus();
		return false;
	}
	
	if($("#noticeContent").val()=="") {
		alert("내용을 입력해 주세요.");
/* 		$("#message").text("내용을 입력해 주세요.");
 */		$("#board_content").focus();
		return false;
	}
});

</script>