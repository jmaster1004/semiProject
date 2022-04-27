<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="xyz.itwill.dao.QaDAO"%>
<%@page import="xyz.itwill.dto.QaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
 	if(request.getParameter("num")==null){
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

	if(qa==null || qa.getQaStatus()==0){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;		
	} 

 	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");

 	if(qa.getQaStatus()==2){
		if(loginMember==null || !loginMember.getMemberEmail().equals(qa.getMemberEmail()) && loginMember.getMemberStatus()!=9){
			out.println("<script type='text/javascript'>");
			out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
			out.println("</script>");
			return;		
		}
	} 

	QaDAO.getDAO().updateHit(num);
 
%>

<div id="wrap">
	<div class="site-wrap">


		<div
			class="xans-element- xans-board xans-board-readpackage-4 xans-board-readpackage xans-board-4 ">
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
					<br>
					<h2>
						<font color="333333">상품 Q&amp;A</font>
					</h2>
					<p>상품 Q&amp;A입니다.</p>
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
									<th scope="row">제목</th>
									<td>
<%-- 										<% if(qa.getQaStatus()==2){ %>
											[비밀글]
										<% } %> --%>
										<%=qa.getQaTitle() %>
									</td>
								</tr>
								<tr>
									<th scope="row">작성자</th>
									<td><%=qa.getMemberName() %></td>
								</tr>
								<tr>
									<th scope="row">작성일</th>
									<td><%=qa.getQaDate() %> &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
									 	조회수 &emsp; <%=qa.getQaHit() %> </td>
								</tr>
								<tr>
									<th><br>내용</th>
									
									<td>	
										<br>									
										<%=qa.getQaContent().replace("\n", "<br>") %>
										<br>
										<br>
									</td>
								</tr>

							</tbody>
						</table>
					</div>
					<div class="ec-base-button ">
						<span class="gLeft">
						<% String postURL=(String)session.getAttribute("postURL"); %>
							<%if(postURL!=null) { %>
								 <a href=<%=postURL %> class="btnNormalFix sizeS" id="listBtn">목록</a>
								 <%session.removeAttribute("postURL"); %>
							<%}else { %>
								 <a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=qa&work=qa_list&pageNum=<%=pageNum %>" class="btnNormalFix sizeS">목록</a>
							<% } %>		
						</span> 
						<span class="gRight"> 
						<% if(loginMember!=null && (loginMember.getMemberEmail().equals(qa.getMemberEmail())
								||loginMember.getMemberStatus()==9)) { %>
							<button type="button" id="removeBtn" class="btnNormalFix sizeS displaynone">삭제</button>
							<button type="button" id="modifyBtn" class="btnEmFix sizeS displaynone">수정</button>
						<% } %>
						<% if(loginMember!=null&&loginMember.getMemberStatus()==9) { %>
							<button type="button" id="replyBtn" class="btnSubmitFix sizeS displaynone">답변</button>							
						<% } %>
						</span>
					</div>
				</div>
		</div>
		<div>
			<form id="qaForm" method="post">
				<%-- 글 삭제와 글변경을 클릭한 경우 요청 JSP 문서에 전달되는 값  --%>
				<input type="hidden" name="num" value="<%=qa.getQaNo()%>"> 
				
			<%-- 답글쓰기를 클릭한 경우 요청 JSP 문서에 전달되는 값  --%>
				<input type="hidden" name="ref" value="<%=qa.getQaRef()%>"> 
				<input type="hidden" name="reOrder" value="<%=qa.getQaReOrder()%>"> 
				<input type="hidden" name="reLevel" value="<%=qa.getQaReLevel()%>"> 
				
			<%-- 답글쓰기를 클릭한 경우 요청 JSP 문서에 전달되는 값  --%>
				<input type="hidden" name="pageNum" value="<%=pageNum%>"> 
				<input type="hidden" name="search" value="<%=keyword%>"> 
				<input type="hidden" name="keyword" value="<%=search%>"> 
			</form>
		</div>

	</div>
</div>
<script type="text/javascript">
$("#removeBtn").click(function(){
	if(confirm("게시글을 삭제 하시겠습니까?")){
		$("#qaForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=qa&work=qa_remove_action");
		$("#qaForm").submit();
	}
})

$("#modifyBtn").click(function(){
	$("#qaForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=qa&work=qa_modify");
	$("#qaForm").submit();
})

$("#replyBtn").click(function(){
	$("#qaForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=qa&work=qa_write");
	$("#qaForm").submit();
})

$("#listBtn").click(function(){
	$("#qaForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=qa&work=qa_list");
	$("#qaForm").submit();
})

</script>











