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
	
/* 	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
 */		
	int number=totalItem-(pageNum-1)*pageSize;
	
/* 	String currentDate=new SimpleDateFormat("yyy-MM-dd").format(new Date());
 */
 
%>	
		
<div id="wrap">
	<div class="site-wrap">

		<div class="xans-element- xans-product xans-product-menupackage ">
			<div
				class="xans-element- xans-product xans-product-headcategory path ">
				<span>현재 위치</span>
				<ol>
					<li><a href="/">홈</a></li>
					<li class=""><a href="/product/list.html?cate_no=24">제품구매</a></li>
					<li class=""><a href="/product/list.html?cate_no=29">쇼핑하기</a></li>
					<li class="displaynone"><a href="/product/list.html"></a></li>
					<li class="displaynone"><strong><a
							href="/product/list.html"></a></strong></li>
				</ol>
			</div>
			<div
				class="xans-element- xans-product xans-product-headcategory title ">
				<p class="banner">
					<img
						src="//paperbag.co.kr/web/upload/category/shop1_29_top_644870.jpg"
						usemap="#categoryhead_top_image_map_name" alt="">
				</p>
				<div class="titleArea">
					<h2>
					<%if(category==1){ %>
						<span>다이어트식품</span>																
					<%} else if(category==2) { %>
						<span>건강식품</span>											
					<%} else if(category==3) { %>
						<span>간편식품</span>						
					<%} else if(category==4) { %>
						<span>세트</span>										
					<%} else if(category==5) { %>
						<span>소스</span>						
					<%} else { %>
						<span>쇼핑하기</span>	
					<%} %>															
					</h2>
				</div>
			</div>
			<ul class="menuCategory">
				<!-- 참고 : 뉴상품관리 전용 모듈입니다. 뉴상품관리 이외의 곳에서 사용하면 정상동작하지 않습니다. -->
				<li style="display:;"
					class="xans-element- xans-product xans-product-displaycategory selected xans-record-"><a
					href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list">쇼핑하기 <span
						class="count displaynone">()</span></a>
					<ul class="xans-element- xans-product xans-product-children">
						<li class=" xans-record-">
							<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&category=1">다이어트식품 
								<span class="displaynone">()</span>
							</a>
								<div class="button"></div>
						</li>
						<li class=" xans-record-">
							<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&category=2">건강식품
							<span
								class="displaynone">()
							</span>
							</a>
								<div class="button"></div>
						</li>
						<li class=" xans-record-">
							<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&category=3">간편식품 
								<span class="displaynone">()</span>
							</a>
								<div class="button"></div>
						</li>
						<li class=" xans-record-">
							<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&category=4">세트
							 	<span class="displaynone">()</span>
							</a>
								<div class="button"></div>
						</li>
						<li class=" xans-record-">
							<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&category=5">소스 
								<span class="displaynone">()</span>
							</a>
							<div class="button"></div>
						</li>
					</ul>
				</li>
				<!-- //참고 -->
			</ul>
		</div>
		<div class="xans-element- xans-product xans-product-normalpackage ">
			<div class="xans-element- xans-product xans-product-normalmenu ">
				<!--
            $compare_page = /product/compare.html
        -->
				<div class="function">
					<p class="prdCount">
						<strong><%=totalItem %></strong>개의 상품이 등록되어 있습니다.
					</p>
					<ul id="type"
						class="xans-element- xans-product xans-product-orderby">
						<li class="xans-record-"><a
							href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&category=<%=category%>&sort=11">신상품</a></li>
						<li class="xans-record-"><a
							href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&category=<%=category%>&sort=22">상품명</a></li>
						<li class="xans-record-"><a
							href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&category=<%=category%>&sort=33">낮은가격</a></li>
						<li class="xans-record-"><a
							href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&category=<%=category%>&sort=44">높은가격</a></li>
					</ul>
				</div>
			</div>
			<div
				class="xans-element- xans-product xans-product-listnormal ec-base-product">
				<!--
            $count = 30
				※ 노출시킬 상품의 갯수를 숫자로 설정할 수 있습니다.
				※ 상품 노출갯수가 많으면 쇼핑몰에 부하가 발생할 수 있습니다.
            $basket_result = /product/add_basket.html
            $basket_option = /product/basket_option.html
        -->
				<ul class="prdList grid3">
					<%for(ItemDTO item:itemList) { %>
				
						<li id="anchorBoxId_44" class="xans-record-">
							<span class="chk">
								<input type="checkbox" class="ProductCompareClass xECPCNO_44 displaynone">
							</span>
							<div class="thumbnail">
								<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_detail&code=<%=item.getItemCd() %>" name=""> 
									<img src="<%=request.getContextPath()%>/site/item_image/<%=item.getItemMainImage()%>" id="" alt="<%=item.getItemMainImage()%>" class="img_medium" width="386px" height="386px">
									&nbsp;
								</a>

							</div>
							<div class="description">
								<div class="colorbtn displaynone"></div>
									<strong class="name">
										<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_detail&code=<%=item.getItemCd() %>" class="">
											<span class="title displaynone">
												<span style="font-size: 18px; color: #000000;"data-i18n="PRODUCT.PRD_INFO_PRODUCT_NAME">상품명</span> :
											</span> 
											<span style="font-size: 18px; color: #000000;"><%=item.getItemNm() %></span>
										</a>
									</strong>
								<ul class="xans-element- xans-product xans-product-listitem spec">
									<li class=" 판매가 xans-record-">
										<strong class="title displaynone">
											<span style="font-size: 17px; color: #000000; font-weight: bold;" data-i18n="PRODUCT.PRD_INFO_PRODUCT_PRICE">판매가</span> :
										</strong> 
										<span style="font-size: 17px; color: #000000; font-weight: bold;">₩<%=DecimalFormat.getInstance().format(item.getItemPrice()) %></span>
	<!-- 									<span id="span_product_tax_type_text" style=""></span>
	 -->								</li>
								</ul>
	<!-- 							<div class="icon">
									<div class="promotion"></div>
								</div> -->
							</div>
						</li>
					<% } %>	
					
				</ul>
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
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&pageNum=1&search=<%=search%>&keyword=<%=keyword%>">
					<img src="_wp/img/btn_page_first.jpg" alt="첫 페이지"></a>
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>">
					<img src="_wp/img/btn_page_prev.jpg" alt="이전 페이지"></a>
				<% } else { %>
					<a href="#none" class="first"><img src="_wp/img/btn_page_first.jpg" alt="첫 페이지"></a>
					<a href="#none"><img src="_wp/img/btn_page_prev.jpg" alt="이전 페이지"></a>
				<% } %>

				<% for(int i=startPage;i<=endPage;i++) { %>
					<% if(pageNum!=i) {//요청 페이지 번호와 출력 페이지 번호가 같지 않은 경우 링크 설정 %>
						<ol>
							<li class="xans-record-">
							<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>"
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
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">
					<img src="_wp/img/btn_page_next.jpg" alt="다음 페이지"></a>
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&pageNum=<%=totalPage%>&search=<%=search%>&keyword=<%=keyword%>">
					<img src="_wp/img/btn_page_last.jpg" alt="마지막 페이지"></a>
					
				<% } else { %>
					<a href="#none"><img src="_wp/img/btn_page_next.jpg" alt="다음 페이지"></a>
					<a href="#none" class="last"><img src="_wp/img/btn_page_last.jpg" alt="마지막 페이지"></a>
				<% } %>
		</div>
			<form id="boardSearchForm" action="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list"
			method="post" target="_top">
	
			<div style="text-align:center"
				class="xans-element- xans-board xans-board-search-4 xans-board-search xans-board-4 ">
				<fieldset class="boardSearch">
					<legend>상품 검색</legend>
					<p>					
						<input id="search" name="search" type="hidden" value="item_nm"> 
						<input id="keyword" name="keyword" class="inputTypeText" placeholder="상품명을 입력하세요." type="text" size="30"> 
						
						<button type="submit" class="btnEm"><i class="fas fa-search"></i>검색</button>

					</p>
				</fieldset>
			</div>
		</form>
	</div>
</div>