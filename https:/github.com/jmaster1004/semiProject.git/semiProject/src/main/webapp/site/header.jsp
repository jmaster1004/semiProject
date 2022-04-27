<%@page import="xyz.itwill.dao.cartDAO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
%>  
<div class="top-menu-wrap">
	<div class="inner">
		<div class="site-wrap">
			<!-- 멀티샵 노출 영역 -->
						<!-- //멀티샵 노출 영역 -->

			<!-- 상단 우측 로그인 텍스트 영역 -->
			<div class="float-right wp-util">
				<% if(loginMember==null) {//비로그인 사용자인 경우 %>
					<ul class="">
						<!-- 로그인 전-->
						<li class="xans-element- xans-layout xans-layout-statelogoff ">
							<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=member&work=login" class="login">로그인</a>
						</li>
						<li class="xans-element- xans-layout xans-layout-statelogoff point_wrap ">
							<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=member&work=join">회원가입</a>
						</li>
						<li><a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=member&work=login">주문조회</a></li>
						<li class="xans-element- xans-layout xans-layout-orderbasketcount basket ">
							<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=cart&work=cart">
							<img src="<%=request.getContextPath() %>/site/_wp/img/top_basket.png" style = "max-width:18px; position: absolute; top: 9px; left: 16px;" >장바구니
							</a>
						</li>
					</ul>
				<% } else {//로그인 사용자인 경우 
				int cartRows = (int)cartDAO.getDAO().selectCartRows(loginMember.getMemberEmail());
				
				%>
					<ul>
						<li>
							<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=member&work=logout_action">로그아웃</a>
						</li>
						<li>
							<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=member&work=mypage">마이페이지</a>
						</li>
						<% if(loginMember.getMemberStatus()==9) { //로그인 사용자가 관리자인 경우 %>
						<li>
							<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=admin&work=admin_member_list">관리자</a>
						</li>
						<% } %>
						<li>
							<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=order&work=order_list">주문조회</a>
						</li>
						<li class="xans-element- xans-layout xans-layout-orderbasketcount basket ">
							<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=cart&work=cart">
							<img src="<%=request.getContextPath() %>/site/_wp/img/top_basket.png" style = "max-width:18px; position: absolute; top: 9px; left: 16px;">장바구니<span class="count displaynone EC-Layout_Basket-count-display"><span class="EC-Layout-Basket-count"><%= cartRows %></span></span>
							</a>
						</li>
					</ul>
				<% } %>
				<!-- 로그인 후-->
                    										
			</div>
			<!-- //상단 우측 로그인 텍스트 영역 -->

			<div class="clear"></div>
		</div>
	</div>
</div>

<div class="logo-wrap">
	<div class="site-wrap">
        <!-- 상단 로고 -->
		<div class="xans-element- xans-layout xans-layout-logotop logo ">
			<div class="vertical">
			<%--
			 <a href="index.html"><img src="<%=request.getContextPath() %>/site/web/upload/category/logo/fb2ce9d9a7819eb89cb191c069b946be_LGURHqRqKd_3_top.jpg" alt="주식회사 페이퍼백"><!-- <img src="/web/upload/category/logo/fb2ce9d9a7819eb89cb191c069b946be_LGURHqRqKd_3_top.jpg" alt="주식회사 페이퍼백" /> --></a></div>
			 --%>
				<a href="index.jsp" class="main_logo">Bag&Bag</a>
			</div>
		<!-- //상단 로고 -->
		<div class="search">
				<div class="dp-search">
						<form id="boardSearchForm" action="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list"
						method="post" target="_top">
				
						<div style="text-align:right"
							class="xans-element- xans-board xans-board-search-4 xans-board-search xans-board-4 ">
							<fieldset class="boardSearch">
								<legend>상품 검색</legend>
								<p>					
									<input id="search" name="search" type="hidden" value="item_nm"> 
									<input id="keyword" name="keyword" class="inputTypeText" placeholder="상품명을 입력하세요." type="text" size="30"> 
									
									<button type="submit"><img src="<%=request.getContextPath() %>/site/img/find_icon.png" height="20" width="20" /><!-- <i class="fas fa-search"></i>검색 --></button>
			
								</p>
							</fieldset>
						</div>
					</form>
				</div>
			</div>
		<!-- 상단 검색 -->
			<!-- //상단 검색 -->
			<div class="clear"></div>
		</div>
	</div>
</div>

<div class="cate-wrap">
	<div class="inner">
		<div class="site-wrap">
			<!-- 카테고리 영역 -->
            <ul id="category" class="xans-element- xans-layout xans-layout-category cate-override">
			<li data-param="?cate_no=29" class="xans-record-">
			<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list" class="m1">쇼핑하기</a>
				<div class="sub-category">
					<p class="xans-record-"><a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&category=1">다이어트</a></p>
					<p class="xans-record-"><a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&category=2">건강식품</a></p>
					<p class="xans-record-"><a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&category=3">간편식품</a></p>
					<p class="xans-record-"><a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&category=4">세트</a></p>
					<p class="xans-record-"><a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list&category=5">소스</a></p>
				</div>
			</li>
			<li><a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=review&work=review_list" class="m1">리뷰</a></li>
			<li><a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=qa&work=qa_list" class="m1">상품Q&A</a></li>
			<li><a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=notice&work=notice_list" class="m1">공지사항</a></li>
			</ul>
		</div>
	</div>
</div>