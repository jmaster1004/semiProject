<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/site/security/login_check.jspf"%>
<%

	String ref="0",reOrder="0",reLevel="0";
	String pageNum="1";
	
	if(request.getParameter("ref")!=null) {//전달값이 있는 경우 - 답글
		 ref=request.getParameter("ref");
		 reOrder=request.getParameter("reOrder");
		 reLevel=request.getParameter("reLevel");
	}
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
						<li title="현재 위치"><strong>상품 Q&amp;A</strong></li>
					</ol>
				</div>
				<div class="titleArea">
					<h2>
						<font color="333333">상품 Q&amp;A</font>
					</h2>
<!-- 					<p>상품 Q&amp;A입니다.</p>
 -->					<% if(ref.equals("0")) {//새글인 경우 %>
							<p>새글입니다.</p>
						<% } else {//답글인 경우 %>
							<p>답글입니다.</p>
						<% } %>	
				</div>
			</div>
			<form id="qaForm" name="" action="<%=request.getContextPath()%>/site/index.jsp?workgroup=qa&work=qa_write_action"
				method="post">

				<input type="hidden" name="ref" value="<%=ref%>">
				<input type="hidden" name="reOrder" value="<%=reOrder%>">
				<input type="hidden" name="reLevel" value="<%=reLevel%>">
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
										<input type="text" name="qaTitle" id="qaTitle" size="80">
									</td>
								</tr>
								<tr class="">
									<th scope="row">작성자</th>
									<td><%=loginMember.getMemberName() %>
									<input name="writer" type="hidden" value="<%=loginMember.getMemberEmail() %>"></td>
								<tbody>
								<tr class="">
									<th scope="row">공개여부</th>
									<td><input id="secure0" name="qaSecure" fw-filter="isFill"
										fw-label="비밀글설정" fw-msg="" value="1"			 type="radio"
										checked="checked">
										<label for="secure0">공개글</label> 
										<input id="secure1" name="qaSecure" fw-filter="isFill" fw-label="비밀글설정"
										fw-msg="" value="2" type="radio">
										<label for="secure1">비밀글</label></td>
								</tr>
							</tbody>
								<tr>
									<th><br>내용</th>
									<td>
										<textarea rows="25" cols="175" name="qaContent" id="qaContent" style="resize:none"></textarea>
									</td>
								</tr>								

						</table>
					</div>
					<br/>
					<div class="ec-base-button ">
						<span class="gLeft"> <span class="displaynone"><a
								href="#none" class="btnNormal sizeS" onclick="">관리자 답변보기</a></span> 
								<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=qa&work=qa_list&pageNum=<%=pageNum %>" class="btnBasicFix sizeS" class="btnNormalFix sizeS">목록</a>
						</span>
						<span class="gRight">
							 <button type="submit" class="btnSubmitFix sizeS">등록</button>
							 <a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=qa&work=qa_list&pageNum=<%=pageNum %>" class="btnBasicFix sizeS">취소</a>
						</span>
					</div>
				</div>
			</form>
		</div>

	</div>
</div>
<script type="text/javascript">
$("#title").focus();

$("#qaForm").submit(function() {
	if($("#qaTitle").val()=="") {
		alert("제목을 입력해 주세요.");
/* 		$("#message").text("제목을 입력해 주세요.");
 */		$("#subject").focus();
		return false;
	}
	
	if($("#qaContent").val()=="") {
		alert("내용을 입력해 주세요.");
/* 		$("#message").text("내용을 입력해 주세요.");
 */		$("#board_content").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#subject").focus();
	$("#message").text("");	
});
</script>





