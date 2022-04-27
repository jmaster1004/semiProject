<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="wrap">
	<div class="site-wrap">

		<div class="path">
			<span>현재 위치</span>
			<ol>
				<li><a href="/">홈</a></li>
				<li title="현재 위치">마이 쇼핑</li>
			</ol>
		</div>

		<div class="titleArea">
			<h2>마이 쇼핑</h2>
		</div>

		<div class="xans-element- xans-layout xans-layout-logincheck "></div>

		<div class="xans-element- xans-myshop xans-myshop-asyncbenefit">
			<div class="ec-base-box typeMember gMessage displaynone">
				<div class="information">
					<p class="thumbnail">
						<img
							src="//img.echosting.cafe24.com/skin/base_ko_KR/member/img_member_default.gif"
							alt=""
							onerror="this.src='//img.echosting.cafe24.com/skin/base/member/img_member_default.gif';"
							class="myshop_benefit_group_image_tag">
					</p>

				</div>
			</div>

		</div>

		<div class="xans-element- xans-myshop xans-myshop-orderstate ">

		</div>

		<div id="myshopMain"
			class="xans-element- xans-myshop xans-myshop-main">
			<ul>
				<li class="shopMain order"><a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=order&work=order_list">
						<h3>
							<strong>ORDER</strong><span>주문내역 조회</span>
						</h3>
						<p>
							고객님께서 주문하신 상품의<br> 주문내역을 확인하실 수 있습니다.
						</p>
				</a></li>
				<li class="shopMain profile"><a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=member&work=password_confirm&action=modify">
						<h3>
							<strong>PROFILE</strong><span>회원 정보</span>
						</h3>
						<p>
							회원이신 고객님의 개인정보를<br> 관리하는 공간입니다.
						</p>
				</a></li>
				<li class="shopMain board"><a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=member&work=member_myPostList">
						<h3>
							<strong>BOARD</strong><span>게시물 관리</span>
						</h3>
						<p>
							고객님께서 작성하신 게시물을<br> 관리하는 공간입니다.
						</p>
				</a></li>
				
				<li class="shopMain review"><a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=member&work=member_myReviewList">
						<h3>
							<strong>BOARD</strong><span>상품 리뷰 관리</span>
						</h3>
						<p>
							고객님께서 작성하신 상품 리뷰글을<br> 관리하는 공간입니다.
						</p>
				</a></li>
				
			</ul>
		</div>
	</div>
</div>