<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>

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

	NoticeDTO notice=NoticeDAO.getDAO().selectNoNotice(num); 

	if(notice==null || notice.getNoticeStatus()==0){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;		
	} 

 	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
 
	if(notice.getNoticeStatus()==0){
		if(loginMember==null || 
		!loginMember.getMemberEmail().equals(notice.getMemberEmail()) && loginMember.getMemberStatus()!=9){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;		
		}
	} 

	NoticeDAO.getDAO().updateHit(num);
 
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
						<li title="현재 위치"><strong>공지사항</strong></li>
					</ol>
				</div>
				<div class="titleArea">
					<h2>
					<br>
						<font color="333333">공지사항</font>
					</h2>
					<p>공지사항입니다.</p>
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
										<%=notice.getNoticeTitle() %>
									</td>
								</tr>
								<tr>
									<th scope="row">작성자</th>
									<td><%=notice.getMemberName() %></td>
								</tr>
								<tr>
									<th scope="row">작성일</th>
									<td><%=notice.getNoticeRegDate() %>
									 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
									 	조회수 &emsp; <%=notice.getNoticeHit() %> </td>
								</tr>
								<tr>
									<th><br>내용</th>
									
									<td style="text-align:center;">	
										<br>									
											<%=notice.getNoticeContent().replace("\n", "<br>") %>
										<br>
										<br>
										<%if(notice.getNoticeImage()!=null) {%>										
											<img alt="<%=request.getContextPath()%>/site/notice_image/<%=notice.getNoticeImage()%>" src="<%=request.getContextPath()%>/site/notice_image/<%=notice.getNoticeImage()%>" width="200">
										<br>
										<br>	
										<% } %>																			
									</td>
								</tr>

							</tbody>
						</table>
					</div>
					<div class="ec-base-button ">
						<span class="gLeft">
						 <a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=notice&work=notice_list&pageNum=<%=pageNum %>" class="btnNormalFix sizeS">목록</a>
						</span> 
						<% if(loginMember!=null && (loginMember.getMemberEmail().equals(notice.getMemberEmail())
								||loginMember.getMemberStatus()==9)) { %>
						<span class="gRight"> 
							<button type="button" id="removeBtn" class="btnNormalFix sizeS displaynone">삭제</button>
							<button type="button" id="modifyBtn" class="btnEmFix sizeS displaynone">수정</button>
						</span>
						<% } %>
					</div>
				</div>
		</div>
		<div>
			<form id="noticeForm" method="post">
				<%-- 글 삭제와 글변경을 클릭한 경우 요청 JSP 문서에 전달되는 값  --%>
				<input type="hidden" name="num" value="<%=notice.getNoticeNo()%>"> 
				
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
		$("#noticeForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=notice&work=notice_remove_action");
		$("#noticeForm").submit();
	}
})

$("#modifyBtn").click(function(){
	$("#noticeForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=notice&work=notice_modify");
	$("#noticeForm").submit();
})

$("#listBtn").click(function(){
	$("#noticeForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=notice&work=notice_list");
	$("#noticeForm").submit();
})

</script>











