<%@page import="xyz.itwill.dao.QaDAO"%>
<%@page import="xyz.itwill.dto.QaDTO"%>
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
	
	QaDTO qa=QaDAO.getDAO().selectNoQa(num);

	if(qa==null || qa.getQaStatus()==0) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;	
	}
	
	//로그인 사용자가 게시글 작성자가 아니거나 관리자가 아닌 경우 => 비정상적인 요청에 대한 응답 처리 
	if(!loginMember.getMemberEmail().equals(qa.getMemberEmail()) && loginMember.getMemberStatus()!=9) {
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
						<li title="현재 위치"><strong>상품 Q&amp;A</strong></li>
					</ol>
				</div>
				<div class="titleArea">
					<h2>
						<font color="333333">상품 Q&amp;A</font>
					</h2>
				</div>
			</div>
			<form id="qaForm" name="" action="<%=request.getContextPath()%>/site/index.jsp?workgroup=qa&work=qa_modify_action"
				method="post">

				<input type="hidden" name="num" value="<%=num%>">
				<input type="hidden" name="pageNum" value="<%=pageNum%>">
				<input type="hidden" name="search" value="<%=search%>">
				<input type="hidden" name="keyword" value="<%=keyword%>">
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
										<input type="text" name="qaTitle" id="qaTitle" size="80" value=<%=qa.getQaTitle() %>>
									</td>
								</tr>
								<tr class="">
									<th scope="row">작성자</th>
									<td><%=qa.getMemberName() %></td>
									<!-- <input id="writer" name="writer" fw-filter="isFill"
										fw-label="작성자" fw-msg="" class="inputTypeText" placeholder=""
										maxlength="50" value="" type="text">
								</tr> -->
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
<!-- 							<td>
								<input type="text" name="subject" id="subject" size="40">
								<input type="checkbox" name="secret" value="2">비밀글
							</td> -->
							</tbody>
								<tr>
									<th><br>내용</th>
									<td>
										<textarea rows="25" cols="175" name="qaContent" id="qaContent" style="resize:none"><%=qa.getQaContent() %></textarea>
									</td>
								</tr>								
<!-- 							<tbody class="">
								<tr>
									<th scope="row">첨부파일1</th>
									<td><input name="image1" type="file"></td>
								</tr>
								<tr>
									<th scope="row">첨부파일2</th>
									<td><input name="image2" type="file"></td>
								</tr>
								<tr>
									<th scope="row">첨부파일3</th>
									<td><input name="image3" type="file"></td>
								</tr>
							</tbody> -->
						</table>
					</div>
					<br/>
					<div class="ec-base-button ">
						<span class="gLeft"> <span class="displaynone"><a
								href="#none" class="btnNormal sizeS" onclick="">관리자 답변보기</a></span> 
								<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=qa&work=qa_list&pageNum=<%=pageNum %>" class="btnBasicFix sizeS" class="btnNormalFix sizeS">목록</a>
						</span>
						<span class="gRight"> <!-- <a href="#none"
							class="btnSubmitFix sizeS"
							onclick="BOARD_WRITE.form_submit('boardWriteForm');">등록</a>
							  -->
							 <button type="submit" class="btnSubmitFix sizeS">등록</button>
							 <a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=qa&work=qa_list&pageNum=<%=pageNum %>" class="btnBasicFix sizeS">취소</a>
						</span>
<!-- 					<div class="ec-base-button ">
						<span class="gLeft"> <span class="displaynone"><a
								href="#none" class="btnNormal sizeS" onclick="">관리자 답변보기</a></span> <a
							href="/board/상품-qa/6/" class="btnNormalFix sizeS">목록</a>
						</span> <span class="gRight"> <a href="#none"
							class="btnSubmitFix sizeS"
							onclick="BOARD_WRITE.form_submit('boardWriteForm');">등록</a> <a
							href="/board/상품-qa/6/" class="btnBasicFix sizeS">취소</a>
						</span> -->
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
		alert("내을 입력해 주세요.");
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