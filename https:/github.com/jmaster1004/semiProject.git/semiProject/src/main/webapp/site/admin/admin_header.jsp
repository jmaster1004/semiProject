<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="java.lang.reflect.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%


	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");

%>
    
<div class="top-menu-wrap">
	<div class="inner">
		<div class="site-wrap">
			<!-- 멀티샵 노출 영역 -->
						<!-- //멀티샵 노출 영역 -->

			<!-- 상단 우측 로그인 텍스트 영역 -->
			<div class="float-right wp-util">
				<ul class="">
				
				<!-- 로그인 후-->
				<li class="xans-element- xans-layout xans-layout-statelogoff point_wrap ">
				<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=main&work=main" >쇼핑몰 바로가기&nbsp;&nbsp;</a></li>
				<li class="xans-element- xans-layout xans-layout-orderbasketcount basket ">
                <li class="xans-element- xans-layout xans-layout-statelogoff ">
                <a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=member&work=logout_action" class="logout">관리자[<%=loginMember.getMemberName() %>]님 로그아웃</a></li>
				</li>
				</ul>
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

		<!-- 상단 검색 -->
			<div class="search">
				<div class="dp-search">
					<form id="searchBarForm" name="" action="action" method="get" target="_self" enctype="multipart/form-data">
					<input id="banner_action" name="banner_action" value="" type="hidden">
					<div class="xans-element- xans-layout xans-layout-searchheader ">
					<!--
							$product_page=/product/detail.html
							$category_page=/product/list.html
						-->
	
					<input id="keyword" name="keyword" fw-filter="" fw-label="검색어" fw-msg="" class="inputTypeText" placeholder="" onmousedown="SEARCH_BANNER.clickSearchForm(this)" value="" type="text">					
						<div class="icon">
							<input class="search-btn" type="image" src="<%=request.getContextPath() %>/site/_wp/img/top_search.png" alt="검색" onclick="SEARCH_BANNER.submitSearchBanner(this); return false;">
						</div>
					</div>
					</form>		
				</div>
			</div>
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
			<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_manager" class="m1">상품관리</a>
				<div class="sub-category">
					<p class="xans-record-"><a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_manager">상품조회</a></p>
					<p class="xans-record-"><a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_add">상품추가</a></p>
<!-- 					<p class="xans-record-"><a href="">상품수정</a></p>
					<p class="xans-record-"><a href="">상품삭제</a></p> -->
					<p class="xans-record-"><a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_category">카테고리관리</a></p>
				</div>
			</li>
			<li><a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_member_list" class="m1">회원관리</a>
				<div class="sub-category">
					<p class="xans-record-"><a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_member_list">회원조회</a></p>
					<p class="xans-record-"><a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_admin_list">관리자 관리</a></p>
				</div>
			</li>
			<li><a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_order_list" class="m1">주문관리</a>
				<div class="sub-category">
					<p class="xans-record-"><a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_order_list">배송관리</a></p>
				</div>
			</li>
			</ul>
		</div>
	</div>
</div>