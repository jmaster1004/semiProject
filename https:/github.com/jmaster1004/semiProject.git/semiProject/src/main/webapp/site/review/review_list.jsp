<%@page import="xyz.itwill.dao.ReviewDAO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="xyz.itwill.dto.ReviewDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	
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
	
	String email=null;
	String code=null;
	
	int totalReview=ReviewDAO.getDAO().selectReviewCount(search, keyword , email, code);
	
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
							<span>νμ¬ μμΉ</span>  
							<ol>
								<li><a href="/">ν</a></li>
								<li title="νμ¬ μμΉ"><strong>μνλ¦¬λ·°</strong></li>
							</ol>
						</div>
						<div class="titleArea">
							<h2>				
								<font color="333333">μνλ¦¬λ·°</font>
							</h2>
							<p>μνλ¦¬λ·°μλλ€.</p>							
						</div>
					</div>
					<div class="reviewSearch">
						<ul class="sorting">
							<li class="selected">
								 <a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_list&pageNum=<%=pageNum%>&sort=1"
								 class="ec-board-list-sorting" data-sort-order="recent" data-sort-order-text="μ΅μ μ">μ΅μ μ</a>
							</li>
							<li class="">
								<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_list&pageNum=<%=pageNum%>&sort=2"
								class="ec-board-list-sorting" data-sort-order="rating" data-sort-order-text="νμ μ">νμ μ</a>
							</li>
							<li>
								<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_list&pageNum=<%=pageNum%>&sort=3"
								class="ec-board-list-sorting" data-sort-order="hit" data-sort-order-text="μ‘°νμμ">μ‘°νμμ</a>
							</li>
						</ul>
						
						<div class="ctrl">
						<form action="<%=request.getContextPath() %>/site/index.jsp?workgroup=review&work=review_list" method="post">
							<select name="search">
								<option value="member_name" selected="selected">&nbsp;μμ±μ&nbsp;</option>
								<option value="review_title">&nbsp;μ λͺ©&nbsp;</option>
								<option value="review_content">&nbsp;λ΄μ©&nbsp;</option>
							</select>
							<input type="text" name="keyword">
							<button type="submit">κ²μ</button>
						</form>
						</div>
					</div>
				
					<div class="review_table">
						<div class="ec-base-table typeList gBorder">
								<table border="1" summary="">
								<caption>μν κ²μν λͺ©λ‘</caption>
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
										<th scope="col">λ²νΈ</th>
										<th scope="col">μ λͺ©</th>
										<th scope="col">μνλͺ</th>
										<th scope="col">μμ±μ</th>
										<th scope="col">νμ </th>
										<th scope="col" class="">μ‘°νμ</th>
										<th scope="col" class="">μμ±μΌ</th>
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
										<td colspan="5">μμ±λ λ¦¬λ·°κ° νλλ μμ΅λλ€.</td>
									</tr>
									<% } else { %>
										<% for(ReviewDTO review:reviewList) { %>
										<tr class="">
											<%--λ²νΈ --%>
											<td><%=number %></td>
											<%--μ λͺ© --%>
											<td><a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_detail&reviewNo=<%=review.getReviewNo() %>&pageNum=<%=pageNum %>&search=<%=search%>&keyword=<%=keyword%>"><%=review.getReviewTitle() %></a></td>
											<%--μνλͺ --%>
											<td><%=review.getItemNm()%></td>
											<%--μμ±μ --%>
											<td><%=review.getMemberName() %></td>
											<%--νμ --%>
											<td>
												<% if(review.getReviewGrade()==1) {	%>
													β
												<% } else if(review.getReviewGrade()==2){%>
													ββ
												<% } else if(review.getReviewGrade()==3) {%>
													βββ
												<% } else if (review.getReviewGrade()==4) {%>
													ββββ
												<% } else if (review.getReviewGrade()==5) {%>
													βββββ
												<% } %>
											</td>											
											<%--
											 <td><%=review.getReviewGrade() %></td>
											 --%>
											<%--μ‘°νμ --%>
											<td><%=review.getReviewCount() %></td>
												<%--μμ±μΌ --%>
												<%-- κ²μκΈ μμ±λ μ§μ μμ€ν λ μ§κ° κ°μ κ²½μ° --%> 
											<td>
												<% if(currentDate.equals(review.getReviewDate().substring(0, 10))) { %>
												<%=review.getReviewDate().substring(11) %> 
												<% } else { //κ²μκΈ μμ±λ μ§μ μμ€ν λ μ§κ° λ€λ₯Έ κ²½μ° %>
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
			src="_wp/img/btn_page_prev.jpg" alt="μ΄μ  νμ΄μ§"></a>
		<% } else { %>
			<a href="#none"><img
			src="_wp/img/btn_page_prev.jpg" alt="μ΄μ  νμ΄μ§"></a>
		<% } %>

		<% for(int i=startPage;i<=endPage;i++) { %>
			<% if(pageNum!=i) {//μμ²­ νμ΄μ§ λ²νΈμ μΆλ ₯ νμ΄μ§ λ²νΈκ° κ°μ§ μμ κ²½μ° λ§ν¬ μ€μ  %>
				<ol>
					<li class="xans-record-">
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_list&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>"
						class="other"><%=i %></a></li>
				</ol>
		<% } else {//μμ²­ νμ΄μ§ λ²νΈμ μΆλ ₯ νμ΄μ§ λ²νΈκ° κ°μ κ²½μ° λ§ν¬ λ―Έμ€μ  %>
				<ol>
					<li class="xans-record-"><a href=""
						class="this"><%=i %></a></li>
				</ol>
			<% } %>
		<% } %>
	
	
		<% if(endPage!=totalPage) {//μ’λ£ νμ΄μ§ λ²νΈμ μ μ²΄ νμ΄μ§ κ°―μκ° κ°μ§ μμ κ²½μ° λ§ν¬ μ€μ  %>
			<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_list&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">
			<img src="_wp/img/btn_page_next.jpg" alt="λ€μ νμ΄μ§"></a>
		<% } else { %>
			<a href="#none">
			<img src="_wp/img/btn_page_next.jpg" alt="λ€μ νμ΄μ§"></a>
		<% } %>
</div>

	
	

