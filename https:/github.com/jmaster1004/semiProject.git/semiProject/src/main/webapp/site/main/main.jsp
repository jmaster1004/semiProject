<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style type="text/css">
/*
#title-text {
	text-align: center;
	font-size: 40px;
}
*/

#slider {
	position: absolute;
	width: 1000px;
	height: 350px;
	top: 100px;
	left: 150px;
	background-color: #ececec;
}

/* 슬라이더 이미지 출력 엘리먼트 */
*/
#sliderContainer {
	position: relative;
	width: 1362px;
	height: 327px;
	margin: 10px;
	/*overflow: hidden;*/
}

/* 슬라이더 이미지 엘리먼트 - 모든 이미지 엘리먼트 중첩 처리됨
 */
#sliderContainer img {
	display: block;
	position: absolute;
	top: 0;
	left: 0;
}

/* 화살표 이미지 엘리먼트 */
#arrowContainer img {
	position: absolute;
	top: 200px;
	opacity:0.0;
}

#arrowContainer img:HOVER {
	opacity:1.0;
}

#leftImg {
	z-index:100;
	left: 170px;
}
 
#rightImg {
	z-index:100;
	left: 1050px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
			
	});	
</script>
	
<div id="main">

	<!-- Uneedcomms Keepgrow Script -->
	<script id="kg-service-init" data-hosting="cafe24"
		src="//storage.keepgrow.com/admin/keepgrow-service/keepgrow-service_62a2f4e6-95f3-424f-a9ea-50a8d2dc38c6.js"></script>
	<script id="kgSync-init" type="text/javascript" data-env="pc"
		src="//storage.keepgrow.com/admin/kakaosync/kg_kakaosync_e6fc2e22-69ec-4a7f-bed4-fa990c38a2e9.js"></script>
	<!-- Uneedcomms Keepgrow Script -->

	<div id="skipNavigation">
		<p>
			<a href="#category">전체상품목록 바로가기</a>
		</p>
		<p>
			<a href="#contents">본문 바로가기</a>
		</p>
	</div>
<div class="clear"></div>
	<div class="main_bnr_300 bxslider-wrap">
		<div class="bx-wrapper" style="max-width: 100%;">
			<div class="bx-viewport" style="width: 100%; overflow: hidden; position: relative; height: 684px;">
				<div id="sliderContainer">
					<ul id="bxslider1" style="width: auto; position: relative; z-index: 1;">
						<!--<li>
				<a href="//paperbag.co.kr/product/detail.html?product_no=52&cate_no=29&display_group=1" target="_self"><img src="/web/upload/banner/renewal/pc/pc_truffle_1223.jpg" alt="" /></a>
			</li>-->
						<li style="float: none; list-style: none; position: absolute; width: 1362px; z-index: 0; ">
							<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=item&work=item_detail&code=54" target="_self">
								<img src="<%=request.getContextPath() %>/site/_wp/img/pc_main_1.jpg" alt=""></a>
						</li>
						<li style="float: none; list-style: none; position: absolute; width: 1362px; z-index: 0; "> 
							<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=item&work=item_list&category=1" target="_self">
							<img src="<%=request.getContextPath() %>/site/_wp/img/pc_main_2.jpg" alt=""></a>
						</li>
						<li style="float: none; list-style: none; position: absolute; width: 1362px; z-index: 0;">
							<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=item&work=item_detail&code=47" target="_self">
							<img src="<%=request.getContextPath() %>/site/_wp/img/pc_main_sauce.jpg" alt=""></a>
						</li>
						<%--
						 <li style="float: none; list-style: none; position: absolute; width: 1362px; z-index: 50; display: list-item;">
						 --%>
						<li style="float: none; list-style: none; position: absolute; width: 1362px; z-index: 0;">
							<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=item&work=item_detail&code=55" target="_self">
							<img src="<%=request.getContextPath() %>/site/_wp/img/pc_main_3.jpg" alt=""></a>
						</li>
						<li style="float: none; list-style: none; position: absolute; width: 1362px; z-index: 0; ">
							<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=item&work=item_detail&code=48" target="_self">
							<img src="<%=request.getContextPath() %>/site/_wp/img/pc_main_4.jpg" alt=""></a>
						</li>
					</ul>

				</div>
				
			</div>
			
		</div>
	</div>
	<!--//-->


	<!-- 상품진열(BEST) -->
	<!--
	- 공통상품진열 형태에 대한 스타일은 "/layout/basic/css/ec-base-product.css"에 정의되어 있습니다.
	- 메인 상품진열 형태에 대한 스타일은 "/_wp/css/main.css"에 추가로 정의되어 있습니다.
	- $count = 상품의 총 노출 개수
	- grid(숫자) 를 변경하면 한 줄에 보여지는 썸네일 크기를 변경할 수 있습니다.(grid3~grid6)
	- 상품정보표시설정은 관리자 '상품관리>상품표시관리>상품정보표시설정'에서 설정 가능합니다.
-->
	<div data-title="BEST" class="xans-element- xans-product xans-product-listmain-1 xans-product-listmain xans-product-1 ec-base-product">
		<div class="site-wrap">
			<div class="section-title">
				<h3>
				<br>
					<span class="title-text" style="display:;">Bag&Bag BEST
						<p>MD's Choice</p>
						<br>
					</span> <span class="title-img" style="display: none;"><img src=""
						alt="PAPERBAG BEST<p>MD's Choice</p>"></span>
				</h3>
			</div>
			<ul class="prdList grid3">
				<!--
				$count = 3
				※ 노출시킬 상품의 갯수를 숫자로 설정할 수 있으며, 설정하지 않을경우, 최대 200개로 자동제한됩니다.
				※ 상품 노출갯수가 많으면 쇼핑몰에 부하가 발생할 수 있습니다.
			-->
				<li id="anchorBoxId_39" class="xans-record-">
					<div class="thumbnail">
						<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=item&work=item_detail&code=54"
							name="anchorBoxName_39"> <img
							src="//paperbag.co.kr/web/product/medium/202110/187b465d256570d237670503dbdaf56c.jpg"
							id="eListPrdImage39_2" alt="마이너스 티"> &nbsp;
						</a>
						
					</div>
					<div class="description">
						<div class="colorbtn displaynone"></div>
						<strong class="name"><a
							href="<%=request.getContextPath() %>/site/index.jsp?workgroup=item&work=item_detail&code=54"
							class=""><span class="title displaynone"><span
									style="font-size: 18px; color: #000000;"
									data-i18n="PRODUCT.PRD_INFO_PRODUCT_NAME">상품명</span> :</span> <span
								style="font-size: 18px; color: #000000;">마이너스 티</span></a></strong>

						<ul
							class="xans-element- xans-product xans-product-listitem-1 xans-product-listitem xans-product-1 spec">
							<li class=" 소비자가 xans-record-"><strong
								class="title displaynone"><span
									style="font-size: 13px; color: #aaaaaa;"
									data-i18n="PRODUCT.PRD_INFO_PRODUCT_CUSTOM">소비자가</span> :</strong> <span
								style="font-size: 13px; color: #aaaaaa; text-decoration: line-through;">₩52,000</span><span
								class="discount_rate " data-prod-custom="52000"
								data-prod-price="47000">10</span></li>
							<li class=" 판매가 xans-record-"><strong
								class="title displaynone"><span
									style="font-size: 17px; color: #000000; font-weight: bold;"
									data-i18n="PRODUCT.PRD_INFO_PRODUCT_PRICE">판매가</span> :</strong> <span
								style="font-size: 17px; color: #000000; font-weight: bold;">₩47,000</span><span
								id="span_product_tax_type_text" style=""> </span></li>
						</ul>
						<div class="icon">
							<div class="promotion"></div>
						</div>
					</div>
				</li>
				<li id="anchorBoxId_34" class="xans-record-">
					<div class="thumbnail">
						<a
							href="<%=request.getContextPath() %>/site/index.jsp?workgroup=item&work=item_detail&code=60"
							name="anchorBoxName_34"> <img
							src="//paperbag.co.kr/web/product/medium/202108/875934a5b783f22e76639424c8b92dbb.jpg"
							id="eListPrdImage34_2" alt="[BEST] 치팅 패키지"> &nbsp;
						</a>
						
					</div>
					<div class="description">
						<div class="colorbtn displaynone"></div>
						<strong class="name"><a
							href="<%=request.getContextPath() %>/site/index.jsp?workgroup=item&work=item_detail&code=60"
							class=""><span class="title displaynone"><span
									style="font-size: 18px; color: #000000;"
									data-i18n="PRODUCT.PRD_INFO_PRODUCT_NAME">상품명</span> :</span> <span
								style="font-size: 18px; color: #000000;">[BEST] 치팅 패키지</span></a></strong>

						<ul
							class="xans-element- xans-product xans-product-listitem-1 xans-product-listitem xans-product-1 spec">
							<li class=" 소비자가 xans-record-"><strong
								class="title displaynone"><span
									style="font-size: 13px; color: #aaaaaa;"
									data-i18n="PRODUCT.PRD_INFO_PRODUCT_CUSTOM">소비자가</span> :</strong> <span
								style="font-size: 13px; color: #aaaaaa; text-decoration: line-through;">₩106,000</span><span
								class="discount_rate " data-prod-custom="106000"
								data-prod-price="79500">25</span></li>
							<li class=" 판매가 xans-record-"><strong
								class="title displaynone"><span
									style="font-size: 17px; color: #000000; font-weight: bold;"
									data-i18n="PRODUCT.PRD_INFO_PRODUCT_PRICE">판매가</span> :</strong> <span
								style="font-size: 17px; color: #000000; font-weight: bold;">₩79,500</span><span
								id="span_product_tax_type_text" style=""> </span></li>
						</ul>
						<div class="icon">
							<div class="promotion"></div>
						</div>
					</div>
				</li>
				<li id="anchorBoxId_30" class="xans-record-">
					<div class="thumbnail">
						<a
							href="<%=request.getContextPath() %>/site/index.jsp?workgroup=item&work=item_detail&code=55"
							name="anchorBoxName_30"> <img
							src="//paperbag.co.kr/web/product/medium/202112/f2696aedd560d9b2d1f0a2227a12508a.jpg"
							id="eListPrdImage30_2" alt="약손 매실 효소"> &nbsp;
						</a>
						
					</div>
					<div class="description">
						<div class="colorbtn displaynone"></div>
						<strong class="name"><a
							href="<%=request.getContextPath() %>/site/index.jsp?workgroup=item&work=item_detail&code=55"
							class=""><span class="title displaynone"><span
									style="font-size: 18px; color: #000000;"
									data-i18n="PRODUCT.PRD_INFO_PRODUCT_NAME">상품명</span> :</span> <span
								style="font-size: 18px; color: #000000;">약손 매실 효소</span></a></strong>

						<ul
							class="xans-element- xans-product xans-product-listitem-1 xans-product-listitem xans-product-1 spec">
							<li class=" 소비자가 xans-record-"><strong
								class="title displaynone"><span
									style="font-size: 13px; color: #aaaaaa;"
									data-i18n="PRODUCT.PRD_INFO_PRODUCT_CUSTOM">소비자가</span> :</strong> <span
								style="font-size: 13px; color: #aaaaaa; text-decoration: line-through;">₩36,000</span><span
								class="discount_rate " data-prod-custom="36000"
								data-prod-price="28800">20</span></li>
							<li class=" 판매가 xans-record-"><strong
								class="title displaynone"><span
									style="font-size: 17px; color: #000000; font-weight: bold;"
									data-i18n="PRODUCT.PRD_INFO_PRODUCT_PRICE">판매가</span> :</strong> <span
								style="font-size: 17px; color: #000000; font-weight: bold;">₩28,800</span><span
								id="span_product_tax_type_text" style=""> </span></li>
						</ul>
						<div class="icon">
							<div class="promotion"></div>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<!--//-->

	<!-- 상품진열(NEW ITEM) -->
	<!--
	- 공통상품진열 형태에 대한 스타일은 "/layout/basic/css/ec-base-product.css"에 정의되어 있습니다.
		- 메인 상품진열 형태에 대한 스타일은 "/_wp/css/main.css"에 추가로 정의되어 있습니다.
	- $count = 상품의 총 노출 개수
	- grid(숫자) 를 변경하면 한 줄에 보여지는 썸네일 크기를 변경할 수 있습니다.(grid3~grid6)
	- 상품정보표시설정은 관리자 '상품관리>상품표시관리>상품정보표시설정'에서 설정 가능합니다.
-->
	<div data-title="PRODUCT"
		class="xans-element- xans-product xans-product-listmain-2 xans-product-listmain xans-product-2 ec-base-product">
		<div class="site-wrap">
			<div class="section-title">
				<h3>
					<span class="title-text" style="display:;"><br>Bag&Bag NEW
						<p>신제품 만나보기</p>
						<br>
					</span> <span class="title-img" style="display: none;"><img src=""
						alt="PAPERBAG NEW<p>신제품 만나보기</p>"></span>
				</h3>
			</div>
			<ul class="prdList grid3">
				<!--
				$count = 3
				※ 노출시킬 상품의 갯수를 숫자로 설정할 수 있으며, 설정하지 않을경우, 최대 200개로 자동제한됩니다.
				※ 상품 노출갯수가 많으면 쇼핑몰에 부하가 발생할 수 있습니다.
			-->
				<li id="anchorBoxId_44" class="xans-record-">
					<div class="thumbnail">
						<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=item&work=item_detail&code=47" name="anchorBoxName_44"> 
						<img src="//paperbag.co.kr/web/product/medium/202112/d9f98711169f52a2b03aa3598dc74463.jpg"
							id="eListPrdImage44_3" alt="아재 마법간장/양념 소스"> &nbsp;
						</a>
						<!--<div class="likeButton likePrd likePrd_44"><button type="button"><img src="/web/upload/icon_202009081121137900.jpg"  class="likePrdIcon" product_no="44" category_no="1" icon_status="off" alt="좋아요 등록 전" /><strong><span class="likePrdCount likePrdCount_44">5</span></strong></button></div>-->
						
					</div>
					<div class="description">
						<div class="colorbtn displaynone"></div>
						<strong class="name"><a
							href="<%=request.getContextPath() %>/site/index.jsp?workgroup=item&work=item_detail&code=47"
							class=""><span class="title displaynone"><span
									style="font-size: 18px; color: #000000;"
									data-i18n="PRODUCT.PRD_INFO_PRODUCT_NAME">상품명</span> :</span> <span
								style="font-size: 18px; color: #000000;">아재 마법간장/양념 소스</span></a></strong>

						<ul
							class="xans-element- xans-product xans-product-listitem-2 xans-product-listitem xans-product-2 spec">
							<li class=" 소비자가 xans-record-"><strong
								class="title displaynone"><span
									style="font-size: 13px; color: #aaaaaa;"
									data-i18n="PRODUCT.PRD_INFO_PRODUCT_CUSTOM">소비자가</span> :</strong> <span
								style="font-size: 13px; color: #aaaaaa; text-decoration: line-through;">₩21,000</span><span
								class="discount_rate " data-prod-custom="21000"
								data-prod-price="21000" style="display: none;">0</span></li>
							<li class=" 판매가 xans-record-"><strong
								class="title displaynone"><span
									style="font-size: 17px; color: #000000; font-weight: bold;"
									data-i18n="PRODUCT.PRD_INFO_PRODUCT_PRICE">판매가</span> :</strong> <span
								style="font-size: 17px; color: #000000; font-weight: bold;">₩21,000</span><span
								id="span_product_tax_type_text" style=""> </span></li>
						</ul>
						<div class="icon">
							<div class="promotion"></div>
						</div>
					</div>
				</li>
				<li id="anchorBoxId_39" class="xans-record-">
					<div class="thumbnail">
						<a	href="<%=request.getContextPath() %>/site/index.jsp?workgroup=item&work=item_detail&code=54"
							name="anchorBoxName_39"> <img src="//paperbag.co.kr/web/product/medium/202110/187b465d256570d237670503dbdaf56c.jpg"
							id="eListPrdImage39_3" alt="마이너스 티"> &nbsp;
						</a>
						<!--<div class="likeButton likePrd likePrd_39"><button type="button"><img src="/web/upload/icon_202009081121137900.jpg"  class="likePrdIcon" product_no="39" category_no="1" icon_status="off" alt="좋아요 등록 전" /><strong><span class="likePrdCount likePrdCount_39">13</span></strong></button></div>-->
						
					</div>
					<div class="description">
						<div class="colorbtn displaynone"></div>
						<strong class="name">
						<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=item&work=item_detail&code=54"
							class=""><span class="title displaynone"><span style="font-size: 18px; color: #000000;"
									data-i18n="PRODUCT.PRD_INFO_PRODUCT_NAME">상품명</span> :</span> <span
								style="font-size: 18px; color: #000000;">마이너스 티</span></a></strong>

						<ul class="xans-element- xans-product xans-product-listitem-2 xans-product-listitem xans-product-2 spec">
							<li class=" 소비자가 xans-record-">
							<strong class="title displaynone"><span style="font-size: 13px; color: #aaaaaa;"
									data-i18n="PRODUCT.PRD_INFO_PRODUCT_CUSTOM">소비자가</span> :</strong> <span
								style="font-size: 13px; color: #aaaaaa; text-decoration: line-through;">₩52,000</span><span
								class="discount_rate " data-prod-custom="52000"
								data-prod-price="47000">10</span></li>
							<li class=" 판매가 xans-record-"><strong
								class="title displaynone"><span
									style="font-size: 17px; color: #000000; font-weight: bold;"
									data-i18n="PRODUCT.PRD_INFO_PRODUCT_PRICE">판매가</span> :</strong> <span
								style="font-size: 17px; color: #000000; font-weight: bold;">₩47,000</span><span
								id="span_product_tax_type_text" style=""> </span></li>
						</ul>
						<div class="icon">
							<div class="promotion"></div>
						</div>
					</div>
				</li>
				<li id="anchorBoxId_37" class="xans-record-">
					<div class="thumbnail">
						<a
							href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_detail&code=48"
							name="anchorBoxName_37"> <img
							src="//paperbag.co.kr/web/product/medium/202111/b1b6ce74cb4c1d2185a24adff2008d34.jpg"
							id="eListPrdImage37_3" alt="[BEST] 월클 피자 2종"> &nbsp;
						</a>
						<!--<div class="likeButton likePrd likePrd_37"><button type="button"><img src="/web/upload/icon_202009081121137900.jpg"  class="likePrdIcon" product_no="37" category_no="1" icon_status="off" alt="좋아요 등록 전" /><strong><span class="likePrdCount likePrdCount_37">12</span></strong></button></div>-->
						
					</div>
					<div class="description">
						<div class="colorbtn displaynone"></div>
						<strong class="name"><a
							href="<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_detail&code=48"
							class=""><span class="title displaynone"><span
									style="font-size: 18px; color: #000000;"
									data-i18n="PRODUCT.PRD_INFO_PRODUCT_NAME">상품명</span> :</span> <span
								style="font-size: 18px; color: #000000;">[BEST] 월클 피자 2종</span></a></strong>

						<ul
							class="xans-element- xans-product xans-product-listitem-2 xans-product-listitem xans-product-2 spec">
							<li class=" 소비자가 xans-record-"><strong
								class="title displaynone"><span
									style="font-size: 13px; color: #aaaaaa;"
									data-i18n="PRODUCT.PRD_INFO_PRODUCT_CUSTOM">소비자가</span> :</strong> <span
								style="font-size: 13px; color: #aaaaaa; text-decoration: line-through;">₩31,200</span><span
								class="discount_rate " data-prod-custom="31200"
								data-prod-price="31200" style="display: none;">0</span></li>
							<li class=" 판매가 xans-record-"><strong
								class="title displaynone"><span
									style="font-size: 17px; color: #000000; font-weight: bold;"
									data-i18n="PRODUCT.PRD_INFO_PRODUCT_PRICE">판매가</span> :</strong> <span
								style="font-size: 17px; color: #000000; font-weight: bold;">₩31,200</span><span
								id="span_product_tax_type_text" style=""> </span></li>
						</ul>
						<div class="icon">
							<div class="promotion"></div>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<%--
	<!--//-->
	<!-- 배너 -->
	<div class="main_bnr_200">
		<!--<div class="site-wrap">-->
		<a href="/shopinfo/brand.html"><img
			src="/web/upload/banner/main_story/pc/pc_story_test.jpg" alt=""></a>
		<!--</div>-->
	</div>
	<!--//-->
	 --%>


<script type="text/javascript">
		var $images=$("#sliderContainer").find("img");
		//alert($images.length); ////5
		
		var imageArray=new Array();
		
		$images.each(function() {
			imageArray.push($(this));
		});
		
		//슬라이더 이미지 엘리먼트가 출력될 좌표값 변경
		// => 슬라이더 이미지 엘리먼트를 슬라이더 출력 엘리먼트 왼쪽에 배치하여 보여지지 않도록 설정
		$images.css("left",-2000);
		
		//슬라이더 이미지 엘리먼트 중 첫번쨰 이미지 엘리먼트가  출력될 좌표값 변경
		// => 첫번째 이미지만 슬라이더 출력 엘리먼트에 보여지도록 설정
		$images.eq(0).css("left",0);
		
		//3초마다 이미지를 이동하여 교체하는 기능의 함수 선언
		// => setInterval 함수의 식별자를(intervalId)를 반환
		function sliding() {
			return setInterval(function() {
				//슬라이더 출력 엘리먼트에 출력될 현재 이미지를 변수에 저장
				var $currentImage=imageArray[0];
				
				//슬라이더 출력 엘리먼트에 출력될 다음 이미지를 변수에 저장
				var $nextImage=imageArray[1];
				
				//다음 이미지의 출력 좌표값을 변경
				// => 이미지를 슬라이더 출력 엘리먼트 왼쪽에 배치하여 보여지지 않도록 설정
				$nextImage.css("left",-2000);
				
				//현재 출력 이미지를 슬라이더 출력 엘리먼트 오른쪽으로 이동
				// => 현재 출력 이미지가 보여지지 않도록 설정
				$currentImage.stop().animate({"left":2000}, 2000);
				//$currentImage.stop().animate({"left":0}, 0);

				//다음 출력 이미지를 슬라이더 출력 엘리먼트로 이동
				// => 다음 출력 이미지가 보여지지 않도록 설정
				$nextImage.stop().animate({"left":0}, 2000);
				
				//Array 객체의 첫번째 요소를 제거하고 요소값(이미지 엘리먼트)을 반환받아 저장
				$removeImage=imageArray.shift();
				
				//제거된 첫번째 요소값을 Array 객체의 마지막 요소로 추가하여 저장
				imageArray.push($removeImage);
				
			}, 5000);
		}
		
		//슬라이더 기능을 제공하는 함수 호출
		var intervalId=sliding();
		
		//슬라이더 엘리먼트에 마우스 커서가 진입한 경우 슬라이더 기능 중지
		$("#slider").mouseover(function() {
			clearInterval(intervalId);
		});
		
		//슬라이더 엘리먼트에 마우스 커서가 벗어난 경우 슬라이더 기능 실행
		$("#slider").mouseout(function() {
			intervalId=sliding();
		});

		//화살표 이미지 엘리먼트에 마우스 커서가 진입한 경우 슬라이더 기능 중지
		$("#arrowContainer img").mouseover(function() {
			clearInterval(intervalId);
		});
		
		//오른쪽 화살표 이미지 엘리먼트를 클릭한 경우 이미지를 오른쪽 방향으로 이동하는 기능
		$("#rightImg").click(function() {
			var $currentImage=imageArray[0];
			var $nextImage=imageArray[1];
			$nextImage.css("left",-980);
			$currentImage.stop().animate({"left":980}, 1000);
			$nextImage.stop().animate({"left":0}, 1000);
			$removeImage=imageArray.shift();
			imageArray.push($removeImage);
		});
		
		//왼쪽 화살표 이미지 엘리먼트를 클릭한 경우 이미지를 왼쪽 방향으로 이동하는 기능
		$("#leftImg").click(function() {
			var $currentImage=imageArray[0];
			var $previousImage=imageArray[imageArrat.length-1];
			$nextImage.css("left",980);
			$currentImage.stop().animate({"left":-980}, 1000);
			$nextImage.stop().animate({"left":0}, 1000);
			$removeImage=imageArray.pop();
			imageArray.unshift($removeImage);
		});	
			
	</script>
