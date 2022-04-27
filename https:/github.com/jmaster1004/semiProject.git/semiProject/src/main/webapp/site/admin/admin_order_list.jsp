<%@page import="xyz.itwill.util.changeStatusVal"%>
<%@page import="xyz.itwill.dto.OrdersDTO"%>
<%@page import="xyz.itwill.dao.OrdersDAO"%>
<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>

<%



	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");

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
	String email=null;
	int totalMember= OrdersDAO.getDAO().selectOrdersCount(email);
	
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

	int sta =0;
	List<OrdersDTO> orderList = OrdersDAO.getDAO().selectAllOrdersList(sta,startRow,endRow);
	
%>
<div id="wrap">
	<div class="site-wrap">
		<div
			class="xans-element- xans-board xans-board-listpackage-1002 xans-board-listpackage xans-board-1002 ">
			<div
				class="xans-element- xans-board xans-board-title-1002 xans-board-title xans-board-1002 ">
				<div class="titleArea">
					<h2>
						<font color="#555555">주문조회</font>
					</h2>
				</div>
				<p class="imgArea"></p>
			</div>
			<div class="boardSort">
				<span
					class="xans-element- xans-board xans-board-replysort-1002 xans-board-replysort xans-board-1002 "></span>
			</div>


			
			<div class="ec-base-table typeList gBorder">
				<table border="1" summary="">
					<caption>회원 목록</caption>
					<colgroup
						class="xans-element- xans-board xans-board-listheader-1002 xans-board-listheader xans-board-1002 ">
						<col style="width: 120px;">
						<col style="width: auto;">
						<col style="width: 104px;">
						<col style="width: 55px;" class="">
						<col style="width: 55px;" class="">
						<col style="width: auto;">
						<col style="width: 160px;" class="">
						<col style="width: auto;">
					</colgroup>
					<thead
						class="xans-element- xans-board xans-board-listheader-1002 xans-board-listheader xans-board-1002 ">
						<tr style="">
							<th scope="col">이메일</th>
							<th scope="col">구매자</th>
							<th scope="col">상품</th>
							<th scope="col">구매수량</th>
							<th scope="col" class="">구매 금액</th>
							<th scope="col" class="">상태</th>
							<th scope="col" class="">주문날짜</th>
							<th scope="col" class="">관리</th>
						</tr>
					</thead>
					<tbody
						class="xans-element- xans-board xans-board-notice-1002 xans-board-notice xans-board-1002 center">

					<% if(orderList.size()==0) { %>
						<tr style="background-color: #FFFFFF; color: #555555;"
							class="xans-record-">
							<td colspan="5">검색된 결과가 없습니다.</td>
						</tr>
						<% } else { %>
						<% for(OrdersDTO order:orderList) { %>
						
						<tr>
							<td id="email"><%= order.getMemberEmail() %></td>
							<td id="name"><strong><%=order.getMemberName() %></strong></td>
							<td id="itemName"><%=order.getItemNm() %></td>
							<td id="itemEach"><%=order.getOrderQuantity() %></td>
							<td id="totalPrice"><%=order.getItemPrice()*order.getOrderQuantity() %></td>
							<td id="Status"><%=changeStatusVal.getUtil().changeStatus(order.getOrderStatus())%></td>
							<td id="Date"><%=order.getOrderDate() %></td>
							<td>
							<form id="updateForm" action="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_orderStatus_update" method="post" >
								<input type="hidden" id="orderNO"  name="orderNO" value="<%=order.getOrderNo() %>">
								<input type="hidden" id="orderStatus"  name="orderStatus" value="<%=order.getOrderStatus() %>">
								<button type="submit" id="update">수정</button><br>
							</form>
							</td>
						</tr>
						<% } %>
					<% } %>	
					</tbody>
					
				</table>
				<p
					class="xans-element- xans-board xans-board-empty-4 xans-board-empty xans-board-4 message displaynone "></p>
			</div>

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
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_order_list&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>"><img
					src="_wp/img/btn_page_prev.jpg" alt="이전 페이지"></a>
				<% } else { %>
					<a href="#none"><img
					src="_wp/img/btn_page_prev.jpg" alt="이전 페이지"></a>
				<% } %>

				<% for(int i=startPage;i<=endPage;i++) { %>
					<% if(pageNum!=i) {//요청 페이지 번호와 출력 페이지 번호가 같지 않은 경우 링크 설정 %>
						<ol>
							<li class="xans-record-">
							<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_order_list&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>"
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
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_order_list&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">
					<img src="_wp/img/btn_page_next.jpg" alt="다음 페이지"></a>
				<% } else { %>
					<a href="#none">
					<img src="_wp/img/btn_page_next.jpg" alt="다음 페이지"></a>
				<% } %>
		</div>

		<form id="boardSearchForm" action="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_order_list" method="post" target="_top">
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

	
	function orderUpdate(ths){
	    $("#data").attr("method", "post");
		$("#data").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_orderStatus_update");
		$("#data").submit();
	}

</script>