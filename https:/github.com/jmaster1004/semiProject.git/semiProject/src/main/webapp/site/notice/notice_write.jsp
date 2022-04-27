<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/site/security/login_check.jspf"%>

<%
	String pageNum="1";

	pageNum=request.getParameter("pageNum");
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
				method="post" enctype="multipart/form-data">

				<input type="hidden" name="pageNum" value="<%=pageNum%>">
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
										<input type="text" name="noticeTitle" id="noticeTitle" size="80">
										<input type="checkbox" name="noticeStatus" value="2">필독 
									</td>
								</tr>
								<tr class="">
									<th scope="row">작성자</th>
									<td><%=loginMember.getMemberName() %>
									<input name="writer" type="hidden" value="<%=loginMember.getMemberEmail() %>"></td>
								<tbody>
							<tbody class="">
								<tr>
									<th scope="row">첨부파일</th>
									<td><input name="image" type="file"></td>
								</tr>
							</tbody>
								<tr>
									<th><br>내용</th>
									<td>
										<textarea rows="25" cols="175" name="noticeContent" id="noticeContent" style="resize:none"></textarea>
									</td>
								</tr>								
						</table>
					</div>
					<br/>
					<div class="ec-base-button ">
<%-- 						<span class="gLeft"> <span class="displaynone"><a
								href="#none" class="btnNormal sizeS" onclick="">관리자 답변보기</a></span> 
								<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=notice&work=notice_list&pageNum=<%=pageNum %>" class="btnBasicFix sizeS" class="btnNormalFix sizeS">목록</a>
						</span> --%>
						<span class="gRight"> 
							 <button type="submit" class="btnSubmitFix sizeS">등록</button>
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
		alert("내을 입력해 주세요.");
/* 		$("#message").text("내용을 입력해 주세요.");
 */		$("#board_content").focus();
		return false;
	}
});

</script>





