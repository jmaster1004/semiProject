<%@page import="xyz.itwill.dao.ReviewDAO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="xyz.itwill.dto.ReviewDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	if(request.getParameter("code")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;	
	}	

	String code =request.getParameter("code");


	int sort=0;
	if(request.getParameter("sort")!=null){
		sort=Integer.parseInt(request.getParameter("sort"));
	}

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
	
	String email =null;
	
	int totalReview=ReviewDAO.getDAO().selectReviewCount(search, keyword, email , code);
	
	int totalPage=(int)Math.ceil((double)totalReview/pageSize);
	
	if(pageNum<=0 || pageNum>totalPage) {
		pageNum=1;
	}
	
	int startRow=(pageNum-1)*pageSize+1;
	
	int endRow=pageNum*pageSize;
	
	if(endRow>totalReview){
		endRow=totalReview;
	}

	List<ReviewDTO> reviewList=ReviewDAO.getDAO().selectReviewList(startRow, endRow, search, keyword, sort, email);

	
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
		
	int number=totalReview-(pageNum-1)*pageSize;
	
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());

%>	

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<div id="wrap">
	<div class="site-wrap">
		<div class="ec-board-list-multiple-list-wrapper">
			<div _sdk_async_app_key="smartreview_dispList_m1" async_status="load"
				class="xans-element- xans-smartreview xans-smartreview-displist reviewArea notranslate ">

				<div async_section="after" style="">
					<div class="reviewTitle">
						<div class="path">
							<span>?????? ??????</span>  
							<ol>
								<li><a href="/">???</a></li>
								<li title="?????? ??????"><strong>????????????</strong></li>
							</ol>
						</div>
						<div class="titleArea">
							<h2>				
								<font color="333333">????????????</font>
							</h2>
							<p>?????????????????????.</p>							
						</div>
					</div>
					<div class="reviewSearch">
						<ul class="sorting">
							<li class="selected">
								 <a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_list&pageNum=<%=pageNum%>&sort=1"
								 class="ec-board-list-sorting" data-sort-order="recent" data-sort-order-text="?????????">?????????</a>
							</li>
							<li class="">
								<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_list&pageNum=<%=pageNum%>&sort=2"
								class="ec-board-list-sorting" data-sort-order="rating" data-sort-order-text="?????????">?????????</a>
							</li>
							<li>
								<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_list&pageNum=<%=pageNum%>&sort=3"
								class="ec-board-list-sorting" data-sort-order="hit" data-sort-order-text="????????????">????????????</a>
							</li>
						</ul>
						
						<div class="ctrl">
						<form action="<%=request.getContextPath() %>/site/index.jsp?workgroup=review&work=review_list" method="post">
							<select name="search">
								<option value="member_name" selected="selected">&nbsp;?????????&nbsp;</option>
								<option value="review_title">&nbsp;??????&nbsp;</option>
								<option value="review_content">&nbsp;??????&nbsp;</option>
							</select>
							<input type="text" name="keyword">
							<button type="submit">??????</button>
						</form>
						</div>
					</div>
				
					<div class="review_table">
						<div class="ec-base-table typeList gBorder">
								<table border="1" summary="">
								<caption>?????? ????????? ??????</caption>
								<colgroup
									class="xans-element- xans-board xans-board-listheader-4 xans-board-listheader xans-board-4 ">
									<col style="width: 70px;">
									<col style="width: auto;">
									<col style="width: 140px;">
									<col style="width: 104px;">
									<col style="width: 104px;">
									<col style="width: 60px;" class="">
									<col style="width: 105px;" class="">
								</colgroup>
								<thead class="xans-element- xans-board xans-board-listheader-4 xans-board-listheader xans-board-4 ">
									<tr style="">
										<th scope="col">??????</th>
										<th scope="col">??????</th>
										<th scope="col">?????????</th>
										<th scope="col">?????????</th>
										<th scope="col">??????</th>
										<th scope="col" class="">?????????</th>
										<th scope="col" class="">?????????</th>
									</tr>
								</thead>
								<tbody class="xans-element- xans-board xans-board-list-4 xans-board-list xans-board-4 center" id="review_title">
									<!--
						               $product_name_cut = 30
						               $login_page_url = /member/login.html
						               $deny_access_url = /index.html
						           -->
									<% if(totalReview==0) { %>
									<tr style="background-color: #FFFFFF; color: #555555;"
										class="xans-record-">
										<td colspan="5">????????? ????????? ????????? ????????????.</td>
									</tr>
									<% } else { %>
										<% for(ReviewDTO review:reviewList) { %>
										<tr class="">
											<%--?????? --%>
											<td><%=number %></td>
											<%--?????? --%>
											<td><a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_detail&reviewNo=<%=review.getReviewNo() %>&pageNum=<%=pageNum %>&search=<%=search%>&keyword=<%=keyword%>"><%=review.getReviewTitle() %></a></td>
											<%--????????? --%>
											<td><%=review.getItemNm()%></td>
											<%--????????? --%>
											<td><%=review.getMemberName() %></td>
											<%--??????--%>
											<td>
												<% if(review.getReviewGrade()==1) {	%>
													???
												<% } else if(review.getReviewGrade()==2){%>
													??????
												<% } else if(review.getReviewGrade()==3) {%>
													?????????
												<% } else if (review.getReviewGrade()==4) {%>
													????????????
												<% } else if (review.getReviewGrade()==5) {%>
													???????????????
												<% } %>
											</td>											
											<%--
											 <td><%=review.getReviewGrade() %></td>
											 --%>
											<%--????????? --%>
											<td><%=review.getReviewCount() %></td>
												<%--????????? --%>
												<%-- ????????? ??????????????? ????????? ????????? ?????? ?????? --%> 
											<td>
												<% if(currentDate.equals(review.getReviewDate().substring(0, 10))) { %>
												<%=review.getReviewDate().substring(11) %> 
												<% } else { //????????? ??????????????? ????????? ????????? ?????? ?????? %>
												<%=(review.getReviewDate().substring(0, 10)) %>
												<% } %>
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
				</div>
			</div>
		</div>
	</div>
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
			<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_list&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>"><img
			src="_wp/img/btn_page_prev.jpg" alt="?????? ?????????"></a>
		<% } else { %>
			<a href="#none"><img
			src="_wp/img/btn_page_prev.jpg" alt="?????? ?????????"></a>
		<% } %>

		<% for(int i=startPage;i<=endPage;i++) { %>
			<% if(pageNum!=i) {//?????? ????????? ????????? ?????? ????????? ????????? ?????? ?????? ?????? ?????? ?????? %>
				<ol>
					<li class="xans-record-">
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_list&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>"
						class="other"><%=i %></a></li>
				</ol>
		<% } else {//?????? ????????? ????????? ?????? ????????? ????????? ?????? ?????? ?????? ????????? %>
				<ol>
					<li class="xans-record-"><a href=""
						class="this"><%=i %></a></li>
				</ol>
			<% } %>
		<% } %>
	
	
		<% if(endPage!=totalPage) {//?????? ????????? ????????? ?????? ????????? ????????? ?????? ?????? ?????? ?????? ?????? %>
			<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_list&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">
			<img src="_wp/img/btn_page_next.jpg" alt="?????? ?????????"></a>
		<% } else { %>
			<a href="#none">
			<img src="_wp/img/btn_page_next.jpg" alt="?????? ?????????"></a>
		<% } %>
</div>

	
	

