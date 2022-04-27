<%@page import="java.util.Date"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String search=request.getParameter("search");
	if(search==null){
		search="";
	}
	
	String keyword=request.getParameter("keyword");
	if(keyword==null){
		keyword="";
	}
	
	int pageNum=1;
	
	if(request.getParameter("pageNum")!=null){
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	int pageSize=10;
	
	int totalNotice=NoticeDAO.getDAO().selectNoticeCount(search, keyword);
	
	int totalPage=(int)Math.ceil((double)totalNotice/pageSize);
	
	if(pageNum<=0 || pageNum>totalPage) {
		pageNum=1;
	}
	
	int startRow=(pageNum-1)*pageSize+1;
	
	int endRow=pageNum*pageSize;
	
	if(endRow>totalNotice){
		endRow=totalNotice;
	}
	
	List<NoticeDTO> noticeList=NoticeDAO.getDAO().selectAllList(startRow, endRow, search, keyword);
	
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
		
	int number=totalNotice-(pageNum-1)*pageSize;
	
	String currentDate=new SimpleDateFormat("yyy-MM-dd").format(new Date());

%>
<div id="wrap">
	<div class="site-wrap">
		<div
			class="xans-element- xans-board xans-board-listpackage-1002 xans-board-listpackage xans-board-1002 ">
			<div
				class="xans-element- xans-board xans-board-title-1002 xans-board-title xans-board-1002 ">
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
				<p class="imgArea"></p>
			</div>
			<div class="boardSort">
				<span
					class="xans-element- xans-board xans-board-replysort-1002 xans-board-replysort xans-board-1002 "></span>
			</div>
			<div>
				공지글 갯수 :
				<%=totalNotice %>개
			</div>
			<div class="ec-base-table typeList gBorder">
				<table border="1" summary="">
					<caption>게시판 목록</caption>
					<colgroup
						class="xans-element- xans-board xans-board-listheader-1002 xans-board-listheader xans-board-1002 ">
						<col style="width: 120px;">
						<col style="width: auto;">
						<col style="width: 104px;">
						<col style="width: 55px;" class="">
						<col style="width: 160px;" class="">
					</colgroup>
					<thead
						class="xans-element- xans-board xans-board-listheader-1002 xans-board-listheader xans-board-1002 ">
						<tr style="">
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col" class="">조회수</th>
							<th scope="col" class="">작성일</th>
						</tr>
					</thead>
					<tbody
						class="xans-element- xans-board xans-board-notice-1002 xans-board-notice xans-board-1002 center">

					<% if(totalNotice==0) { %>
						<tr style="background-color: #FFFFFF; color: #555555;"
							class="xans-record-">
							<td colspan="5">검색된 게시글이 하나도 없습니다.</td>
						</tr>
						<% } else { %>
						<% for(NoticeDTO notice:noticeList) { %>
												
						<tr>
							<%if(notice.getNoticeStatus()==2){ %>
								<td style="display:none"><%=number %></td>
								<td><strong>공지</strong></td>
							<%} else { %>
								<td><%=number %></td>
							<% } %>

							<%-- 제목 --%>
							<td class="subject" style="text-align:left">
								<% if(notice.getNoticeStatus()==1) {//삭제 게시글이 아닌 경우 %>
									<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=notice&work=notice_detail&num=<%=notice.getNoticeNo() %>&pageNum=<%=pageNum %>&search=<%=search%>&keyword=<%=keyword%>"><%=notice.getNoticeTitle() %></a>
									<% if(notice.getNoticeImage()!=null) { %>
										<img src="<%=request.getContextPath()%>/site/img/ico_attach.gif" alt="IMAGE" class="ec-common-rwd-image">
									<% } %>
									
									<% if(currentDate.equals(notice.getNoticeRegDate().substring(0, 10))) { %>
										<img src="<%=request.getContextPath()%>/site/img/ico_new.gif" alt="NEW" class="ec-common-rwd-image">
									<% } %>		
								<% } else if(notice.getNoticeStatus()==2) { %>
									<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=notice&work=notice_detail&num=<%=notice.getNoticeNo() %>&pageNum=<%=pageNum %>&search=<%=search%>&keyword=<%=keyword%>"><strong>공지) <%=notice.getNoticeTitle() %></strong></a>
									<% if(notice.getNoticeImage()!=null) { %>
										<img src="<%=request.getContextPath()%>/site/img/ico_attach.gif" alt="IMAGE" class="ec-common-rwd-image">
									<% } %>
									
									<% if(currentDate.equals(notice.getNoticeRegDate().substring(0, 10))) { %>
										<img src="<%=request.getContextPath()%>/site/img/ico_new.gif" alt="NEW" class="ec-common-rwd-image">
								<% } %>	
							<% } %>
															
							</td>

							<td><%=notice.getMemberName()%></td>

							<td><%=notice.getNoticeHit()%></td>

							<td>
								<%-- 게시글 작성날짜와 시스템 날짜가 같은 경우 --%> 
								<% if(currentDate.equals(notice.getNoticeRegDate().substring(0, 10))) { %>
								<%=notice.getNoticeRegDate().substring(11) %> 
								<% } else { //게시글 작성날짜와 시스템 날짜가 다른 경우 %>
								<%=notice.getNoticeRegDate() %> <% } %>
							</td>

						</tr>

						<% number--; %>
						<% } %>
						<% } %>

					</tbody>
				</table>
				<p
					class="xans-element- xans-board xans-board-empty-4 xans-board-empty xans-board-4 message displaynone "></p>
			</div>
		<% if(loginMember!=null && loginMember.getMemberStatus()==9) { %>
			
			<div
				class="xans-element- xans-board xans-board-buttonlist-4 xans-board-buttonlist xans-board-4  ec-base-button typeBG ">
				<span class="gRight"> <a
					href="<%=request.getContextPath()%>/site/index.jsp?workgroup=notice&work=notice_write&pageNum=<%=pageNum %>"
					class="btnSubmitFix sizeS ">글쓰기</a>
				</span>
			</div>
		<% } %>	
		</div>

		<%
		int blockSize=5;

		int startPage=(pageNum-1)/blockSize*blockSize+1; 

		int endPage=startPage+blockSize-1;
		
		if(endPage>totalPage) {
			endPage=totalPage;
		}
		%>
		<div
			class="xans-element- xans-board xans-board-paging-4 xans-board-paging xans-board-4 ec-base-paginate">
				<% if(startPage>blockSize) { %>
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=notice&work=notice_list&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>"><img
					src="_wp/img/btn_page_prev.jpg" alt="이전 페이지"></a>
				<% } else { %>
					<a href="#none"><img
					src="_wp/img/btn_page_prev.jpg" alt="이전 페이지"></a>
				<% } %>

				<% for(int i=startPage;i<=endPage;i++) { %>
					<% if(pageNum!=i) {//요청 페이지 번호와 출력 페이지 번호가 같지 않은 경우 링크 설정 %>
						<ol>
							<li class="xans-record-">
							<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=notice&work=notice_list&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>"
								class="other"><%=i %></a></li>
						</ol>
				<% } else {//요청 페이지 번호와 출력 페이지 번호가 같을 경우 링크 미설정 %>
						<ol>
							<li class="xans-record-"><a href=""
								class="this"><%=i %></a></li>
						</ol>
					<% } %>
				<% } %>
			
			
				<% if(endPage!=totalPage) {//종료 페이지 번호와 전체 페이지 갯수가 같지 않은 경우 링크 설정 %>
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=notice&work=notice_list&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">
					<img src="_wp/img/btn_page_next.jpg" alt="다음 페이지"></a>
				<% } else { %>
					<a href="#none">
					<img src="_wp/img/btn_page_next.jpg" alt="다음 페이지"></a>
				<% } %>
		</div>

		<form id="boardSearchForm" action="<%=request.getContextPath()%>/site/index.jsp?workgroup=notice&work=notice_list"
			method="post" target="_top">
	
			<div style="text-align:center"
				class="xans-element- xans-board xans-board-search-4 xans-board-search xans-board-4 ">
				<fieldset class="boardSearch">
					<legend>게시물 검색</legend>
					<p>					
						<select name="search" id="search_key">
							<option value="member_name" selected="selected">&nbsp;작성자&nbsp;</option>
							<option value="notice_title">&nbsp;제목&nbsp;</option>
							<option value="notice_content">&nbsp;내용&nbsp;</option>
						</select>
						<input id="search" name="keyword" class="inputTypeText" placeholder="내용을 입력하세요." type="text" size="30"> 
						
						<button type="submit" class="btnEm"><i class="fas fa-search"></i>검색</button>

					</p>
				</fieldset>
			</div>
		</form>

	</div>
</div>