<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>

<%

	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	List<MemberDTO> adminList = MemberDAO.getDAO().selectAllAdminList();

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
	
	int totalMember= adminList.size();
	
	int totalPage=(int)Math.ceil((double)totalMember/pageSize);
	
	if(pageNum<=0 || pageNum>totalPage) {
		pageNum=1;
	}
	
	int startRow=(pageNum-1)*pageSize+1;
	
	int endRow=pageNum*pageSize;
	
	if(endRow>totalMember){
		endRow=totalMember;
	}
	
	int number=totalMember-(pageNum-1)*pageSize;


	
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
						<font color="#555555">관리자조회</font>
					</h2>
				</div>
				<p class="imgArea"></p>
			</div>
			<div class="boardSort">
				<span
					class="xans-element- xans-board xans-board-replysort-1002 xans-board-replysort xans-board-1002 "></span>
			</div>
			<form id="data" class="data">
			<input type="hidden" name ="email_data" id ="email_data"value="">
			<input type="hidden" name ="name_data" id ="name_data" value="">
			<input type="hidden" name ="phone_data" id ="phone_data" value="">
			<div class="ec-base-table typeList gBorder">
				<table border="1" summary="">
					<caption>회원 목록</caption>
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
							<th scope="col">이메일</th>
							<th scope="col">이름</th>
							<th scope="col">연락처</th>
							<th scope="col" class=""></th>
							<th scope="col" class="">관리</th>
						</tr>
					</thead>
					
					<tbody
						class="xans-element- xans-board xans-board-notice-1002 xans-board-notice xans-board-1002 center">

					<% if(adminList.size()==0) { %>
						<tr style="background-color: #FFFFFF; color: #555555;"
							class="xans-record-">
							<td colspan="5">검색된 회원이 하나도 없습니다.</td>
						</tr>
						<% } else { %>
						<% for(MemberDTO admin:adminList) { %>
												
						<tr>
							<td id="email"><%= admin.getMemberEmail() %></td>
							<td id="name"><strong><%= admin.getMemberName() %></strong></td>
							<td class="subject" style="text-align:left" id="phone"><%= admin.getMemberPhone() %></td>
							<td id="totalPrice"></td>
							<td>
								<button type="button" id="update" onclick= memberUpdate(this)>수정</button><br>
								<button type="button" id="delete"  onclick=prompttest(this)>삭제</button>
								<input type="hidden" id="delete_email"  name="delete_email" value="">
							</td>
						</tr>
						<% } %>
					<% } %>	
					</tbody>
					
				</table>
				<p
					class="xans-element- xans-board xans-board-empty-4 xans-board-empty xans-board-4 message displaynone "></p>
			</div>
			</form>
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
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_admin_list&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>"><img
					src="_wp/img/btn_page_prev.jpg" alt="이전 페이지"></a>
				<% } else { %>
					<a href="#none"><img
					src="_wp/img/btn_page_prev.jpg" alt="이전 페이지"></a>
				<% } %>

				<% for(int i=startPage;i<=endPage;i++) { %>
					<% if(pageNum!=i) {//요청 페이지 번호와 출력 페이지 번호가 같지 않은 경우 링크 설정 %>
						<ol>
							<li class="xans-record-">
							<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_admin_list&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>"
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
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_admin_list&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">
					<img src="_wp/img/btn_page_next.jpg" alt="다음 페이지"></a>
				<% } else { %>
					<a href="#none">
					<img src="_wp/img/btn_page_next.jpg" alt="다음 페이지"></a>
				<% } %>
		</div>

		<form id="boardSearchForm" action="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_admin_list" method="post" target="_top">
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

<script type="text/javascript">
	function prompttest(ths){

    	var deleteEmail=prompt("삭제하려하는 이메일을 다시 입력해주세요","");
    	$("#delete_email").val(deleteEmail);
    	
    	var $email = $(ths).closest('tr').find("td[id='email']");
    	var email = $email.text();
    	$("#email_data").val(email);
    	
    	if($("#delete_email").val()!="") {
    	    $("#data").attr("method", "post");
    		$("#data").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_member_delete_action");
    		$("#data").submit();
    	}
    	
	}
	
	function memberUpdate(ths){
	    var $email = $(ths).closest('tr').find("td[id='email']");
	    var $name = $(ths).closest('tr').find("td[id='name']");
	    var $phone = $(ths).closest('tr').find("td[id='phone']");
	    
	    var email = $email.text();
	    var name = $name.text();
	    var phone = $phone.text();
	    
	    
	    $("#email_data").val(email);
	    $("#name_data").val(name);
	    $("#phone_data").val(phone);

		if(email!="") {
	    $("#data").attr("method", "post");
		$("#data").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_member_update");
		$("#data").submit();
		}
	}

</script>