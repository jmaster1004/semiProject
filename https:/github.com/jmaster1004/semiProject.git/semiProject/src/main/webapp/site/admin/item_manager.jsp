<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="xyz.itwill.dto.ItemDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.ItemDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	int category=0;

	if(request.getParameter("category")!=null){
		category=Integer.parseInt(request.getParameter("category"));
	}
	
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
	
	int pageSize=9;
	
	int totalItem=ItemDAO.getDAO().selectItemCount(category, search, keyword);
	
	int totalPage=(int)Math.ceil((double)totalItem/pageSize);
	
	if(pageNum<=0 || pageNum>totalPage) {
		pageNum=1;
	}
	
	int startRow=(pageNum-1)*pageSize+1;
	
	int endRow=pageNum*pageSize;
	
	if(endRow>totalItem){
		endRow=totalItem;
	}
	
	List<ItemDTO> itemList=ItemDAO.getDAO().selectCategoryItemList(category,startRow, endRow, search, keyword, sort);
	
	int number=totalItem-(pageNum-1)*pageSize;
 
%>	
		
<div id="wrap">
	<div class="site-wrap" style="width:50%">

		<div class="xans-element- xans-product xans-product-menupackage ">
			<br>
			<div class="xans-element- xans-product xans-product-headcategory title ">
				<div class="titleArea">
					<h2>
						<span>상품조회</span>	
					</h2>
				</div>
			</div>
			<ul class="menuCategory">
				<!-- 참고 : 뉴상품관리 전용 모듈입니다. 뉴상품관리 이외의 곳에서 사용하면 정상동작하지 않습니다. -->
				<li style="display:;"
					class="xans-element- xans-product xans-product-displaycategory selected xans-record-"><a
					href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_manager">카테고리 <span
						class="count displaynone">()</span></a>
					<ul class="xans-element- xans-product xans-product-children">
						<li class=" xans-record-">
							<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_manager&category=1">다이어트식품 
								<span class="displaynone">()</span>
							</a>
								<div class="button"></div>
						</li>
						<li class=" xans-record-">
							<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_manager&category=2">건강식품
							<span
								class="displaynone">()
							</span>
							</a>
								<div class="button"></div>
						</li>
						<li class=" xans-record-">
							<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_manager&category=3">간편식품 
								<span class="displaynone">()</span>
							</a>
								<div class="button"></div>
						</li>
						<li class=" xans-record-">
							<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_manager&category=4">세트
							 	<span class="displaynone">()</span>
							</a>
								<div class="button"></div>
						</li>
						<li class=" xans-record-">
							<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_manager&category=5">소스 
								<span class="displaynone">()</span>
							</a>
							<div class="button"></div>
						</li>
					</ul>
				</li>
			</ul>
		</div>
		<div>
		상품 갯수 :
		<%=totalItem %>개
		</div>
		<div class="xans-element- xans-product xans-product-normalpackage ">
			<div class="ec-base-table typeList gBorder">
				<table border="1" summary="">
					<caption>게시판 목록</caption>
					<colgroup
						class="xans-element- xans-board xans-board-listheader-1002 xans-board-listheader xans-board-1002 ">
						<col style="width: 120px;">
						<col style="width: auto;">
						<col style="width: 120px;">
						<col style="width: 120px;">
					</colgroup>
					<thead
						class="xans-element- xans-board xans-board-listheader-1002 xans-board-listheader xans-board-1002 ">
						<tr style="">
							<th scope="col">번호</th>
							<th scope="col">제품명</th>
							<th scope="col">제품수량</th>
							<th scope="col">제품가격</th>
						</tr>
					</thead>
					<tbody
						class="xans-element- xans-board xans-board-notice-1002 xans-board-notice xans-board-1002 center">

					<% if(totalItem==0) { %>
						<tr style="background-color: #FFFFFF; color: #555555;"
							class="xans-record-">
							<td colspan="4">검색된 게시글이 하나도 없습니다.</td>
						</tr>
						<% } else { %>
						<% for(ItemDTO item:itemList) { %>
												
						<tr>
							<td><%=number %></td>

							<%-- 제목 --%>
							<td class="subject">
								<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_detail&num=<%=item.getItemCd() %>&pageNum=<%=pageNum %>&search=<%=search%>&keyword=<%=keyword%>"><%=item.getItemNm() %></a>							
							</td>								

							<td><%=item.getItemQty()%>개</td>

							<td>₩<%=DecimalFormat.getInstance().format(item.getItemPrice()) %></td>
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
		
		<%
			int blockSize=5;
	
			int startPage=(pageNum-1)/blockSize*blockSize+1; 
	
			int endPage=startPage+blockSize-1;
			
			if(endPage>totalPage) {
				endPage=totalPage;
			}
		%>
		
		<div
			class="xans-element- xans-product xans-product-normalpaging ec-base-paginate">
				<% if(startPage>blockSize) { %>
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_manager&pageNum=1&search=<%=search%>&keyword=<%=keyword%>">
					<img src="_wp/img/btn_page_first.jpg" alt="첫 페이지"></a>
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_manager&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>">
					<img src="_wp/img/btn_page_prev.jpg" alt="이전 페이지"></a>
				<% } else { %>
					<a href="#none" class="first"><img src="_wp/img/btn_page_first.jpg" alt="첫 페이지"></a>
					<a href="#none"><img src="_wp/img/btn_page_prev.jpg" alt="이전 페이지"></a>
				<% } %>

				<% for(int i=startPage;i<=endPage;i++) { %>
					<% if(pageNum!=i) {//요청 페이지 번호와 출력 페이지 번호가 같지 않은 경우 링크 설정 %>
						<ol>
							<li class="xans-record-">
							<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_manager&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>"
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
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_manager&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">
					<img src="_wp/img/btn_page_next.jpg" alt="다음 페이지"></a>
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_manager&pageNum=<%=totalPage%>&search=<%=search%>&keyword=<%=keyword%>">
					<img src="_wp/img/btn_page_last.jpg" alt="마지막 페이지"></a>
					
				<% } else { %>
					<a href="#none"><img src="_wp/img/btn_page_next.jpg" alt="다음 페이지"></a>
					<a href="#none" class="last"><img src="_wp/img/btn_page_last.jpg" alt="마지막 페이지"></a>
				<% } %>
		</div>
	</div>
</div>