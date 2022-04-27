<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="wrap">
	<div class="site-wrap">


		<!--
    $category_page = /product/list.html
    $project_page = /product/project.html
    $jointbuy_page = /product/jointbuy.html
-->


		<style>
.delivery_css>.w-cont::after {
	content: "(냉동식품 배송비 5,000원)"
}
</style>

		<div
			class="xans-element- xans-product xans-product-headcategory path ">
			<span>현재 위치</span>
			<ol>
				<li><a href="/">홈</a></li>
				<li class=""><a href="/category/제품구매/24/">제품구매</a></li>
				<li class=""><a href="/category/쇼핑하기/29/">쇼핑하기</a></li>
				<li class=""><a href="/category/세트/56/">세트</a></li>
				<li class="displaynone"><strong><a href=""></a></strong></li>
			</ol>
		</div>



		<!-- tiktok pixel -->
		<!-- 상품상세 정보 전송 -->
		<!------------- tiktok pixel -------------->
		<script>

    function callbackProductDetail(callback) {
        var time = 0;
        var interval = setInterval(function () {
            if(
                typeof iProductNo !== 'undefined' &&
                typeof iCategoryNo !== 'undefined' &&
                typeof product_name !== 'undefined' &&
                typeof product_price !== 'undefined'
            ) {
                // visible, do something
                callback();
                clearInterval(interval);
            } else {
                // not visible yet, do something
                time += 100;
            }
        }, 200);
    }

    var productNo = null;
    var productCategory = null;
    var productName = null;
    var productPrice = null;
    callbackProductDetail(function() {
        productNo = iProductNo;
        productCategory = iCategoryNo;
        productName = removeHtml(product_name);
        productPrice = product_price.replace(/[^0-9]/g,'');;

        pageType = 'detail';

        try {
            var pixelData = {
                content_id: productNo + '',
                content_type: 'product',
                content_name: productName.replace(/[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\/]/gi, ''),
                quantity: 1,
                price: productPrice,
                value: productPrice,
                currency: 'KRW',
            };
            console.log('tiktokPixel ViewItem', pixelData)
            if(typeof tiktokPixelIds !== 'undefined' && tiktokPixelIds.length > 0) {
                for(var i in tiktokPixelIds) {
                    ttq.instance(tiktokPixelIds[i]).track('ViewContent', pixelData)
                }

            } else {
                ttq.track('ViewContent', pixelData)
            }
        } catch(e) {}

    });
</script>
		<!------------- tiktok pixel -------------->
		<!-- 상품상세 정보 전송 -->
		<!-- tiktok pixel -->


		<!-- tiktok pixel -->
		<!-- 장바구니 저장 함수 선언 -->
		<script>
    function addToCart() {

        var products = [];
        var productTotalPrice = 0;
        if($('.ProductOption0').length > 0) {
            $('.option_products tr').each(function(index, item){
                // 상품이름
                var optionName = $(this).find('td')[0];
                var productNameInfo = $(optionName).find('.product');
                var splittedProductInfo = productNameInfo.html().split('<span>');

                if(splittedProductInfo.length > 0) {
                    productNameInfo = removeHtml(splittedProductInfo[0]);
                    productNameInfo = productNameInfo.replace('-', '').trim();
                }


                optionName = $(optionName).find('span');
                if(optionName) {
                    optionName = optionName.html();
                }

                if(optionName == 'undefined') {
                    optionName = '';
                }

                // 상품건수
                var productQuantity = $(this).find('input.quantity_opt').val();

                var productOptionTotalPrice = $(this).find('td')[2];
                if(productOptionTotalPrice) {
                    var productOptionTotalPriceInput = $(productOptionTotalPrice).find('input');
                    if(productOptionTotalPriceInput) {
                        productOptionTotalPrice = $(productOptionTotalPriceInput).val();
                    }
                }

                if(!isNaN(productOptionTotalPrice)) {
                    productTotalPrice += parseInt(productOptionTotalPrice);
                } else {
                    productOptionTotalPrice = $(this).find('td')[1];
                    if(productOptionTotalPrice) {
                        var productOptionTotalPriceInput = $(productOptionTotalPrice).find('input');
                        if(productOptionTotalPriceInput) {
                            productOptionTotalPrice = $(productOptionTotalPriceInput).val();
                        }
                    }

                    if(!isNaN(productOptionTotalPrice)) {
                        productTotalPrice += parseInt(productOptionTotalPrice);
                    }
                }

                products.push({
                    'id': productNo,
                    'name': productNameInfo,
                    'category': productCategory,     // Product category (string).
                    'price': parseInt(productOptionTotalPrice / productQuantity),
                    "variant": optionName,
                    'quantity': productQuantity
                })
            });


        }


        // 상품 옵션이 없는 경우
        if($('.ProductOption0').length == 0 && $('#quantity').val() > 0) {
            productTotalPrice = productPrice * $('#quantity').val()
            products.push({
                'id': productNo,
                'name': productName,
                'category': productCategory,     // Product category (string).
                'price': productPrice,
                'quantity': $('#quantity').val()
            })
        }
        console.log(products);
        console.log(productTotalPrice);

        if(products.length > 0) {

            try {
                var tiktokItems = [];
                for(var i in products) {
                    tiktokItems.push({
                        content_id: products[i].id + '',
                        content_type: 'product',
                        content_name: products[i].name,
                        quantity: products[i].quantity,
                        price: products[i].price,
                    });
                }

                var pixelData = {
                    contents: tiktokItems,
                    value: productTotalPrice,
                    currency: 'KRW',
                };

                if((tiktokItems.length > 0 && productTotalPrice > 0)) {
                    if(typeof tiktokPixelIds !== 'undefined' && tiktokPixelIds.length > 0) {
                        for(var i in tiktokPixelIds) {
                            ttq.instance(tiktokPixelIds[i]).track('AddToCart', pixelData)
                        }

                    } else {
                        ttq.track('AddToCart', pixelData)
                    }
                }



            } catch(e) {}


        }
    }
</script>
		<!-- 장바구니 저장 함수 선언 -->
		<!-- tiktok pixel -->




		<!-- tiktok pixel -->
		<!-- 장바구니 이벤트 등록 -->
		<script>
    var addToCartSelector = '.sub_cart, #actionCart, .df-btn.basket, #cartBtn, #cartbtn, .cart-btn, .btn_cart, .cart, .addCart, #btnAddToCart';
    callbackIsVisible(addToCartSelector, function() {
        setTimeout(function() {
            $(addToCartSelector).click(function() {
                addToCart()
            })
        }, 1000);

    })
</script>
		<!-- 장바구니 이벤트 등록 -->
		<!-- tiktok pixel -->



		<!-- tiktok pixel -->
		<!-- 네이버페이 -->
		<script>
    callbackIsVisible('.npay_btn_link.npay_btn_pay', function() {

        setTimeout(function(){
            naverEvent()
        }, 2000)
    })



    function naverEvent() {

        console.log('네이버페이 버튼 이벤트 추가');

        $($($('.npay_btn_item')[0]).children()[0]).click(function(){
            console.log('네이버페이 버튼 클릭');

            var products = [];
            var productTotalPrice = 0;
            if($('.ProductOption0').length > 0) {
                $('.option_products tr').each(function(index, item){
                    // 상품이름
                    var optionName = $(this).find('td')[0];
                    var productNameInfo = $(optionName).find('.product');
                    var splittedProductInfo = productNameInfo.html().split('<span>');

                    if(splittedProductInfo.length > 0) {
                        productNameInfo = removeHtml(splittedProductInfo[0]);
                        productNameInfo = productNameInfo.replace('-', '').trim();
                    }


                    optionName = $(optionName).find('span');
                    if(optionName) {
                        optionName = optionName.html();
                    }

                    if(optionName == 'undefined') {
                        optionName = '';
                    }

                    // 상품건수
                    var productQuantity = $(this).find('input.quantity_opt').val();

                    var productOptionTotalPrice = $(this).find('td')[2];
                    if(productOptionTotalPrice) {
                        var productOptionTotalPriceInput = $(productOptionTotalPrice).find('input');
                        if(productOptionTotalPriceInput) {
                            productOptionTotalPrice = $(productOptionTotalPriceInput).val();
                        }
                    }

                    if(!isNaN(productOptionTotalPrice)) {
                        productTotalPrice += parseInt(productOptionTotalPrice);
                    } else {
                        productOptionTotalPrice = $(this).find('td')[1];
                        if(productOptionTotalPrice) {
                            var productOptionTotalPriceInput = $(productOptionTotalPrice).find('input');
                            if(productOptionTotalPriceInput) {
                                productOptionTotalPrice = $(productOptionTotalPriceInput).val();
                            }
                        }

                        if(!isNaN(productOptionTotalPrice)) {
                            productTotalPrice += parseInt(productOptionTotalPrice);
                        }
                    }

                    products.push({
                        'id': productNo,
                        'name': productNameInfo,
                        'category': productCategory,     // Product category (string).
                        'price': parseInt(productOptionTotalPrice / productQuantity),
                        "variant": optionName,
                        'quantity': productQuantity
                    })
                });


            }


            // 상품 옵션이 없는 경우
            if($('.ProductOption0').length == 0 && $('#quantity').val() > 0) {
                productTotalPrice = productPrice * $('#quantity').val()
                products.push({
                    'id': productNo,
                    'name': productName,
                    'category': productCategory,     // Product category (string).
                    'price': productPrice,
                    'quantity': $('#quantity').val()
                })
            }
            console.log(products);
            console.log(productTotalPrice);

            if(products.length > 0 && productTotalPrice > 0) {

                var totalOrderPrice = productTotalPrice;
                var googleAnalyticsNaverPayPrice = getCookieAnalytics('SEAN_GOOGLE_ANALYTICS_NAVERPAY_PRICE')

                if(googleAnalyticsNaverPayPrice != "" && !isNaN(parseInt(googleAnalyticsNaverPayPrice)) && parseInt(googleAnalyticsNaverPayPrice) == totalOrderPrice) {
                    console.log("금액이 같음" + totalOrderPrice)
                    return false;
                }

                if(googleAnalyticsNaverPayPrice == "" || (googleAnalyticsNaverPayPrice != "" && !isNaN(parseInt(googleAnalyticsNaverPayPrice)) &&
                    parseInt(googleAnalyticsNaverPayPrice) != totalOrderPrice)) {
                    setCookieAnalytics('SEAN_GOOGLE_ANALYTICS_NAVERPAY_PRICE', totalOrderPrice, 1);
                }

                var date = new Date();
                var orderId = date.getUTCFullYear();
                orderId += (parseInt(date.getMonth())+1) < 10 ? '0'+ (parseInt(date.getMonth())+1) : (parseInt(date.getMonth())+1) + '';
                orderId += date.getDate() < 10 ? '0'+ date.getDate() : date.getDate() + '';
                orderId += date.getHours() < 10 ? '0'+ date.getHours() : date.getHours() + '';
                orderId += '-naverpay-' + productNo + productCategory;
                orderId += Math.random(0,10) < 10 ? '0'+ Math.random(0,10) : Math.random(0,10);


                try {
                    var tiktokItems = [];
                    for(var i in products) {
                        tiktokItems.push({
                            content_id: products[i].id,
                            content_type: 'product',
                            content_name: products[i].name,
                            quantity: products[i].quantity,
                            price: products[i].price,
                        });
                    }

                    var pixelData = {
                        contents: tiktokItems,
                        value: productTotalPrice,
                        currency: 'KRW',
                    };
                    if(typeof tiktokPixelIds !== 'undefined' && tiktokPixelIds.length > 0) {
                        for(var i in tiktokPixelIds) {
                            ttq.instance(tiktokPixelIds[i]).track('CompletePayment', pixelData)
                        }
                    } else {
                        ttq.track('CompletePayment', pixelData)
                    }
                } catch(e) {}

            }
        });
    }
</script>
		<!-- tiktok pixel -->
		<!-- 네이버페이 -->


		<!-- 상단 제품 정보  -->
		<div class="xans-element- xans-product xans-product-detail">
			<!--
		$coupon_download_page = /coupon/coupon_productdetail.html
    -->
			<div class="detailArea">
				<!-- 이미지 영역 -->
				<div class="xans-element- xans-product xans-product-image imgArea ">
					<div class="keyImg">
						<!--<div class="thumbnail">
                    <a href="/product/image_zoom2.html?product_no=34&cate_no=1&display_group=2" id="prdDetailImg" data-param="?product_no=34&cate_no=1&display_group=2" alt="P00000BI" onclick="window.open(this.href, 'image_zoom2', 'toolbar=no,scrollbars=auto,resizable=yes,width=450,height=693,left=0,top=0', this);return false;">
                        <img src="//paperbag.co.kr/web/product/big/202108/1c7569fae0e8f54741b6a49b4e380fe3.jpg" alt="[BEST] 치팅 패키지" class="BigImage " /><span module="product_Imagestyle"><span class="prdIcon " style="background-image:url('');"></span></span>
                    </a>
                    <div id="zoom_wrap"></div>
                </div>-->
						<div class="thumbnail">
							<img
								src="//paperbag.co.kr/web/product/big/202108/1c7569fae0e8f54741b6a49b4e380fe3.jpg"
								alt="[BEST] 치팅 패키지" class="BigImage ">
						</div>
					</div>
					<!-- 참고 : 뉴상품관리 전용 모듈입니다. 뉴상품관리 이외의 곳에서 사용하면 정상동작하지 않습니다. -->
					<div
						class="xans-element- xans-product xans-product-addimage listImg">
						<ul class="product_addimage_slide">
							<li class="xans-record-"><img
								src="//paperbag.co.kr/web/product/small/202108/33eb5e7be4f2aed308b52f28cd8fd3cb.jpg"
								class="ThumbImage" alt=""></li>
						</ul>
					</div>
					<!-- //참고 -->
					<!-- 리뷰톡톡 -->
					<!-- 
    참고 : 이 페이지는 상품상세 리뷰요약 상단입니다
    사용되는 페이지들 : 리뷰 상세보기, 상품상세
-->
					<!-- 비동기로 전달할 템플릿 영역(반드시 포함이 되어있어야함) -->
					<div class="reviewArea notranslate" id="ec-board-zoom-wrapper"
						style="display: none;"></div>
					<div class="reviewArea notranslate"
						async_module="smartreview_dispZoom" async_type="template"
						id="ec-board-zoom">
						<!-- 비동기로 처리된 이후 노출되는 섹션 -->
						<div async_section="after" style="display: none;">
							<div class="dimmed"></div>
							<div class="zoomLayer">
								<h2>확대보기</h2>
								<div class="imgView" id="sliderWrap">
									<ul async_module="smartreview_dispFiles" async_type="template"
										class="slides">
										<!--
                        $img_count = 10
                            ※ 입력 가능 숫자 : 10 ~ 30
                    -->
										<li>{$*img_src}</li>
										<li>{$*img_src}</li>
									</ul>
									<div class="paging">
										<button type="button" class="btnPrev">이전</button>
										<button type="button" class="btnNext">다음</button>
									</div>
								</div>
								<div class="reviewThumb">
									<div class="thumbList">
										<p class="count"></p>
										<div id="zoomfakeScroll">
											<ul async_module="smartreview_dispFiles"
												async_type="template">
												<!--
                                $img_count = 10
                                    ※ 입력 가능 숫자 : 10 ~ 30
                            -->
												<li><a href="#none">{$*img_src_thumb_figure}</a></li>
												<li><a href="#none">{$*img_src_thumb_figure}</a></li>
											</ul>
										</div>
									</div>
								</div>
								<button type="button" class="btnClose ec-board-list-zoom-close">닫기</button>
							</div>
						</div>
					</div>
					<div _sdk_async_app_key="smartreview_dispRating_m1"
						async_status="load"
						class="xans-element- xans-smartreview xans-smartreview-disprating reviewArea notranslate">
						<!-- 비동기로 처리된 이후 노출되는 섹션 -->
						<div async_section="after" style="" class="ec-board-files">
							<div class="gradeArea ">
								<div class="status ec-board-rating-grade  ">
									<h3>리뷰평점</h3>
									<strong class="score">4.9</strong>
									<div class="ec-board-grade ec-board-star small">
										<strong class="blind" id="ec-board-detail-rating" data-set="1"
											data-type="star">평점 아이콘</strong><span class="point left on"><span
											class="inner"></span></span><span class="point right on"><span
											class="inner"></span></span><span class="point left on"><span
											class="inner"></span></span><span class="point right on"><span
											class="inner"></span></span><span class="point left on"><span
											class="inner"></span></span><span class="point right on"><span
											class="inner"></span></span><span class="point left on"><span
											class="inner"></span></span><span class="point right on"><span
											class="inner"></span></span><span class="point left on"><span
											class="inner"></span></span><span class="point right"><span
											class="inner"></span></span>
									</div>
								</div>
								<div class="thumbList  ">
									<div async_type="template"
										class="xans-element- xans-smartreview xans-smartreview-dispfiles">
										<!--
                        $ignore_parameter = review_no
                        $img_count = 10
                            ※ 입력 가능 숫자 : 10 ~ 30
                    -->
										<div class="inner ec-board-files ">
											<div class="ec-board-files-list" style="overflow: hidden;">
												<ul style="width: 800px;">
													<li class="xans-record-"><a href="#none"
														class="ec-board-zoom-view-btn" data-index="0"><img
															src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/25/thumb_list/33c4bdef8848c559cbd6342bf4563d77.jpg"
															alt="" class="figure"
															onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
													<li class="xans-record-"><a href="#none"
														class="ec-board-zoom-view-btn" data-index="1"><img
															src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/24/thumb_list/83509f76d9bfa629bfc037b589f14c56.jpg"
															alt="" class="figure"
															onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
													<li class="xans-record-"><a href="#none"
														class="ec-board-zoom-view-btn" data-index="2"><img
															src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/24/thumb_list/7d42633124e63ca63664903a09312864.jpg"
															alt="" class="figure"
															onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
													<li class="xans-record-"><a href="#none"
														class="ec-board-zoom-view-btn" data-index="3"><img
															src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/22/thumb_list/522579ec6db70ca3965e531545cb0630.jpg"
															alt="" class="figure"
															onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
													<li class="xans-record-"><a href="#none"
														class="ec-board-zoom-view-btn" data-index="4"><img
															src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/22/thumb_list/062edb7ec4a492bd40dfb7d62a003480.jpg"
															alt="" class="figure"
															onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
													<li class="xans-record-"><a href="#none"
														class="ec-board-zoom-view-btn" data-index="5"><img
															src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/21/thumb_list/9ac5f13e6575999cf37374b6b77c31ae.jpg"
															alt="" class="figure"
															onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
													<li class="xans-record-"><a href="#none"
														class="ec-board-zoom-view-btn" data-index="6"><img
															src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/18/thumb_list/66a79ab9537a7d67b590e6aa349e5ff5.jpeg"
															alt="" class="figure"
															onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
													<li class="xans-record-"><a href="#none"
														class="ec-board-zoom-view-btn" data-index="7"><img
															src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/12/thumb_list/aeacc591d51587400c24e82b01039bf2.jpeg"
															alt="" class="figure"
															onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
													<li class="xans-record-"><a href="#none"
														class="ec-board-zoom-view-btn" data-index="8"><img
															src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/11/thumb_list/706144bd8559f5202005f16ec653b0b2.jpeg"
															alt="" class="figure"
															onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
													<li class="xans-record-"><a href="#none"
														class="ec-board-zoom-view-btn" data-index="9"><img
															src="https://reviewtalktalk.poxo.com/paperbag0/2021/12/07/thumb_list/d57198aa762bdd56adc497e1920c9a34.jpg"
															alt="" class="figure"
															onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
												</ul>
											</div>
											<p class="paging">
												<button type="button"
													class="btnPrev ec-board-files-prev-btn">이전</button>
												<button type="button"
													class="btnNext ec-board-files-next-btn">다음</button>
											</p>
										</div>
										<p class="empty displaynone">리뷰 사진을 기다리고 있습니다.</p>
									</div>
								</div>
								<p class="empty displaynone">
									아직 상품리뷰가 없습니다.<br>상품을 구매하고 리뷰를 작성해보세요.
								</p>
							</div>
						</div>
					</div>

					<script type="text/javascript"
						src="https://smartreview-004.cafe24.com/optimizer.php?filename=3c313366f0368a739f4a78fa83b4512868588fc8_1644015366&amp;type=js&amp;"></script>

					<link rel="stylesheet" type="text/css"
						href="https://smartreview-004.cafe24.com/optimizer.php?filename=fb73d8c2a59a65612e6156923049b78756da1223_1644001213&amp;type=css&amp;">
					<style type="text/css">
.reviewArea .ec-board-grade.ec-board-star.medium .point .inner {
	background-image:
		url("//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png");
}

.reviewArea .ec-board-star.small .point .inner {
	background-image:
		url("//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_small.png");
}

.reviewArea .ec-board-star.medium .point .inner {
	background-image:
		url("//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png");
}

.thumbList .row .progress-bar_value {
	height: 100%;
	background-color: #EF636F;
}

.thumbList .row .five_star_percentage {
	width: 85.714285714286%;
}

.thumbList .row .four_star_percentage {
	width: 14.285714285714%;
}

.thumbList .row .three_star_percentage {
	width: 0%;
}

.thumbList .row .two_star_percentage {
	width: 0%;
}

.thumbList .row .one_star_percentage {
	width: 0%;
}
</style>
					<!-- 리뷰톡톡 -->
				</div>
				<!-- //이미지 영역 -->

				<!-- 상세정보 내역 -->
				<div class="infoArea wp-detail-info">
					<!-- 좋아요 -->
					<!-- <div class="likeButton likePrd likePrd_34">
				<button type="button"><span class="title">좋아요</span><img src="/web/upload/icon_202009081121137900.jpg"  class="likePrdIcon" product_no="34" category_no="56" icon_status="off" alt="좋아요 등록 전" /><span class="count"><span class="likePrdCount likePrdCount_34">25</span></span></button>
			</div> -->
					<!--//-->
					<!-- 상품명 -->
					<div class="headingArea ">
						<span class="delivery displaynone">(International shipping
							available)</span> <span class="icon"> </span>
						<h2>[BEST] 치팅 패키지</h2>
						<!-- 상품 타이틀 -->
						<!-- <div class="icon_star"><img src="/_wp/img/icon_detail_star.png"/></div> -->
						<div class="supply displaynone">
							<span></span> <a href="#none" onclick=""><img src=""
								alt="공급사 바로가기"></a>
						</div>
					</div>
					<!--//-->
					<!-- 할인율 -->
					<div
						class="xans-element- xans-product xans-product-detaildesign wp-detail-info">
						<!-- 메인 타이틀 이하 옵션 전까지  -->
						<ul class=" product_name_css xans-record-">
							<li class="w-title"><span
								style="font-size: 16px; color: #555555;"
								data-i18n="PRODUCT.PRD_INFO_PRODUCT_NAME">상품명</span></li>
							<li class="w-cont"><span
								style="font-size: 16px; color: #555555;">[BEST] 치팅 패키지</span></li>
						</ul>
						<ul class=" product_custom_css xans-record-">
							<span class="dc-rate" data-prod-custom="₩106,000"
								data-prod-price="79500">25</span>
							<li class="w-title"><span
								style="font-size: 13px; color: #555555;"
								data-i18n="PRODUCT.PRD_INFO_PRODUCT_CUSTOM">소비자가</span></li>
							<li class="w-cont"><span
								style="font-size: 13px; color: #555555;"><span
									id="span_product_price_custom"><strike>₩106,000</strike></span></span></li>
						</ul>
						<ul class=" product_price_css xans-record-">
							<li class="w-title"><span
								style="font-size: 18px; color: #000000; font-weight: bold;"
								data-i18n="PRODUCT.PRD_INFO_PRODUCT_PRICE">판매가</span></li>
							<li class="w-cont"><span
								style="font-size: 18px; color: #000000; font-weight: bold;"><strong
									id="span_product_price_text">₩79,500</strong><input
									id="product_price" name="product_price" value="" type="hidden"></span></li>
						</ul>
						<ul class=" delivery_css xans-record-">
							<li class="w-title"><span
								style="font-size: 12px; color: #555555;"
								data-i18n="PRODUCT.PRD_INFO_DELIVERY">배송방법</span></li>
							<li class="w-cont"><span
								style="font-size: 12px; color: #555555;">택배</span></li>
						</ul>
						<ul class=" delivery_price_css xans-record-">
							<li class="w-title"><span
								style="font-size: 12px; color: #555555;"
								data-i18n="PRODUCT.PRD_INFO_DELIVERY_PRICE">배송비</span></li>
							<li class="w-cont"><span
								style="font-size: 12px; color: #555555;"><span
									class="delv_price_B"><input id="delivery_cost_prepaid"
										name="delivery_cost_prepaid" value="P" type="hidden"><strong>₩3,000</strong>
										(₩50,000 이상 구매 시 무료)</span></span></li>
						</ul>
					</div>

					<div class="regularDelivery displaynone ">
						<table border="1" summary="정기결제">
							<caption>정기결제</caption>
							<tbody>
								<tr>
									<th scope="row">구매방법</th>
									<td><label class="gLabel"> 1회구매</label> <label
										class="gLabel"> 정기배송<span class="badge displaynone">
												<i class="icoDown">할인</i>
										</span></label></td>
								</tr>
								<tr class="shippingCycle displaynone" id="">
									<th scope="row">배송주기</th>
									<td>

										<div class="info displaynone" id="">
											<p class="title">
												<strong>정기배송 할인</strong> <span class="icoSave">save</span>
											</p>
											<ul
												class="xans-element- xans-product xans-product-regulardiscount">
												<li class="">결제 시 : <span class="icoDown">할인</span>
												</li>
											</ul>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>

					<p class="displaynone">
						<img
							src="http://img.echosting.cafe24.com/skin/base_ko_KR/product/txt_naver.gif"
							alt="개인결제창을 통한 결제 시 네이버 마일리지 적립 및 사용이 가능합니다.">
					</p>
					<!-- //상세정보 내역 -->

					<div id="option-box" class="option_layer ">
						<!-- 옵션 -->
						<div class="option_btn">
							옵션선택<span class="arrow"></span>
						</div>
						<div class="block">
							<table border="0" summary="" style="margin: 0;"
								class="xans-element- xans-product xans-product-option xans-record-">
								<caption>상품 옵션</caption>
								<!-- 참고 : 뉴상품관리 전용 변수가 포함되어 있습니다. 뉴상품관리 이외의 곳에서 사용하면 일부 변수가 정상동작하지 않을 수 있습니다. -->
								<tbody></tbody>
								<tbody
									class="xans-element- xans-product xans-product-option xans-record-">
									<tr>
										<th scope="row">추가구매</th>
										<td><select option_product_no="34"
											option_select_element="ec-option-select-finder"
											option_sort_no="1" option_type="T" item_listing_type="C"
											option_title="추가구매" product_type="product_option"
											product_option_area="product_option_34_0" name="option1"
											id="product_option_id1" class="ProductOption0"
											option_style="select" required="true"><option
													value="*" selected="" link_image="">- [필수] 옵션을 선택해
													주세요 -</option>
												<option value="**" disabled="" link_image="">-------------------</option>
												<optgroup label="추가구매">
													<option value="P00000BI000Z" link_image="">[25%]
														병아리콩(14개입)+효소(20포) (+₩6,700)</option>
													<option value="P00000BI00BA" link_image="">[25%]
														까만콩(14개입)+효소(20포) (+₩6,700)</option>
													<option value="P00000BI00BB" link_image="">[25%]
														쿠앤크(14개입)+효소(20포)</option>
													<option value="P00000BI00BC" link_image="">[35%]
														병아리콩(28개입)+효소(40포) (+₩70,000)</option>
													<option value="P00000BI00BD" link_image="">[35%]
														까만콩(28개입)+효소(40포) (+₩70,000)</option>
													<option value="P00000BI00BE" link_image="">[35%]
														쿠앤크(28개입)+효소(40포) (+₩58,300)</option>
												</optgroup></select>
										<p class="value"></p></td>
									</tr>
								</tbody>
								<tbody>
									<tr class="displaynone" id="">
										<td colspan="2" class="selectButton"><a href="#none"
											onclick=""><img
												src="http://img.echosting.cafe24.com/skin/base_ko_KR/product/btn_manual_select.gif"
												alt="옵션 선택"></a></td>
									</tr>
								</tbody>
								<!-- //참고 -->
							</table>
							<div class="guideArea">
								<!-- 참고 : 뉴상품관리 전용 변수가 포함되어 있습니다. 뉴상품관리 이외의 곳에서 사용하면 일부 변수가 정상동작하지 않을 수 있습니다. -->
								<!-- <p class="info ">(최소주문수량 1개 이상<span class="displaynone"> / 최대주문수량 0개 이하</span>)</p> -->
								<!-- //참고 -->
								<span class="sizeGuide displaynone"><a href="#none"
									class="size_guide_info" product_no="34">사이즈 가이드</a></span>
							</div>

							<!-- 참고 : 뉴상품관리 전용 모듈입니다. 뉴상품관리 이외의 곳에서 사용하면 정상동작하지 않습니다. -->
							<!-- //참고 -->


							<!-- 참고 : 뉴상품관리 전용 변수가 포함되어 있습니다. 뉴상품관리 이외의 곳에서 사용하면 일부 변수가 정상동작하지 않을 수 있습니다. -->
							<div id="totalProducts" class="">
								<!-- <p class="ec-base-help txtWarn txt11 displaynone"> 수량을 선택해주세요.</p> -->
								<p class="ec-base-help txtWarn txt11 ">위 옵션선택 박스를 선택하시면 아래에
									상품이 추가됩니다.</p>
								<table border="0" summary="">
									<caption>상품 목록</caption>
									<colgroup>
										<col style="width: 284px;">
										<col style="width: 80px;">
										<col style="width: 110px;">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">상품명</th>
											<th scope="col">상품수</th>
											<th scope="col">가격</th>
										</tr>
									</thead>
									<tbody class="displaynone tbody">
										<tr>
											<td width="">[BEST] 치팅 패키지</td>
											<td width=""><span class="quantity"> <input
													id="quantity" name="quantity_name" style="" value="0"
													type="text"> <a href="#none"><img
														src="http://img.echosting.cafe24.com/skin/base_ko_KR/product/btn_count_up.gif"
														alt="수량증가" class="QuantityUp up"></a> <a href="#none"><img
														src="http://img.echosting.cafe24.com/skin/base_ko_KR/product/btn_count_down.gif"
														alt="수량감소" class="QuantityDown down"></a>
											</span></td>
											<td width="" class="right"><span class="quantity_price">79500</span>
												<span class="mileage displaynone">(<img src="">
													&nbsp;<span class="mileage_price"></span>)
											</span></td>
										</tr>
									</tbody>
									<!-- 참고 : 옵션선택 또는 세트상품 선택시 상품이 추가되는 영역입니다. 쇼핑몰 화면에는 아래와 같은 마크업구조로 표시됩니다. 삭제시 기능이 정상동작 하지 않습니다.-->
									<tbody class="option_products">
										<!-- tr>
                                    <td>
                                        <p class="product">
                                            $상품명<br />
                                            <span>$옵션</span>
                                        </p>
                                    </td>
                                    <td>
                                        <span class="quantity">
                                            <input type="text" class="quantity_opt" />
                                            &nbsp;<a href="#none"><img src="http://img.echosting.cafe24.com/skin/base_ko_KR/product/btn_count_up.gif" alt="수량증가" class="up" /></a>
                                            <a href="#none"><img src="http://img.echosting.cafe24.com/skin/base_ko_KR/product/btn_count_down.gif" alt="수량감소" class="down" /></a>
                                        </span>
                                        <a href="#none"><img src="http://img.echosting.cafe24.com/design/skin/default/product/btn_price_delete.gif" alt="삭제" class="option_box_del" /></a>
                                    </td>
                                    <td class="right">
                                        <span>$가격</span>
                                        <span class="mileage">(<img src="http://img.echosting.cafe24.com/design/skin/admin/ko_KR/product/ico_pay_point.gif" /> &nbsp;<span class="mileage_price">$적립금</span>)</span>
                                    </td>
                                </tr -->
										<tr class="option_product " data-option-index="1"
											target-key="34">
											<td><input type="hidden" class="option_box_id"
												id="option_box1_id" value="P00000BI00BA" name="item_code[]"
												data-item-add-option="" data-item-reserved="N"
												data-option-id="00BA" data-option-index="1">
											<p class="product">
													[BEST] 치팅 패키지<br> - <span>[25%]
														까만콩(14개입)+효소(20포) (+₩6,700)</span>
												</p></td>
											<td><span class="quantity" style="width: 65px;"><input
													type="text" id="option_box1_quantity" name="quantity_opt[]"
													class="quantity_opt eProductQuantityClass" value="1"
													product-no="34"><a href="#none"
													class="up eProductQuantityUpClass"
													"="" data-target="option_box1_up"><img
														src="//img.echosting.cafe24.com/design/skin/default/product/btn_count_up.gif"
														id="option_box1_up" class="option_box_up" alt="수량증가"></a><a
													href="#none" class="down eProductQuantityDownClass"
													data-target="option_box1_down"><img
														src="//img.echosting.cafe24.com/design/skin/default/product/btn_count_down.gif"
														id="option_box1_down" class="option_box_down" alt="수량감소"></a></span><a
												href="#none" class="delete"><img
													src="//img.echosting.cafe24.com/design/skin/default/product/btn_price_delete.gif"
													alt="삭제" id="option_box1_del" class="option_box_del"></a></td>
											<td class="right"><span id="option_box1_price"><input
													type="hidden" class="option_box_price" value="86200"
													product-no="34" item_code="P00000BI00BA"><span
													class="ec-front-product-item-price" code="P00000BI00BA"
													product-no="34">₩86,200</span></span></td>
										</tr>
									</tbody>
									<tbody class="add_products"></tbody>
									<!-- //참고 -->
								</table>
							</div>
							<!-- //참고 -->
							<div id="totalPrice" class="totalPrice">
								<strong>총 상품금액</strong>(수량) : <span class="total"><strong><em>₩86,200</em></strong>
									(1개)</span>
								<!-- SNS 상품홍보 -->
								<div class="displaynone wp-sns">
									<div class="social">
										<ul class="xans-element- xans-product xans-product-customsns ">
											<li></li>
										</ul>
									</div>
								</div>
								<!--//-->
							</div>
							<p class="ec-base-help txt11 displaynone EC-price-warning">할인가가
								적용된 최종 결제예정금액은 주문 시 확인할 수 있습니다.</p>

							<!-- 참고 : 뉴상품관리 전용 변수가 포함되어 있습니다. 뉴상품관리 이외의 곳에서 사용하면 일부 변수가 정상동작하지 않을 수 있습니다. -->
							<div class="xans-element- xans-product xans-product-action ">
								<div class="ec-base-button gColumn">
									<a href="#none" class="btnSubmit sizeL "
										onclick="check_action_nologin();"> <span id="btnBuy">바로
											구매</span> <span id="btnReserve" class="displaynone"
										style="display: none;">주문 예약</span>
									</a> <a href="#none" class="btnNormal sizeL "
										onclick="check_action_nologin();" id="btnAddToCart">장바구니</a> <span
										class="btnEm sizeL gFlex2 displaynone">SOLD OUT</span> <a
										href="#none"
										onclick="add_wishlist_nologin('/member/login.html');"
										class="btnNormal sizeL ">관심상품</a>
								</div>
								<div>
									<a href="/member/join.html"><img
										src="/web/upload/banner/renewal/cpa_banner_0106.png"
										style="width: 100%; margin: 0; padding: 0;"></a>
								</div>
								<div class="dp_sample naverpay">
									<img src="/_wp/img/naverpay.jpg" alt="네이버 체크아웃 구매 버튼">
								</div>
								<!-- 네이버 체크아웃 구매 버튼 -->
								<div id="NaverChk_Button" style="display: block;">
									<div id="NC_ID_1644026282324363"
										class="npay_storebtn_bx npay_type_A_2">
										<div id="NPAY_BUTTON_BOX_ID" class="npay_button_box ">
											<div class="npay_button">
												<div class="npay_text">
													<span class="npay_blind">NAVER 네이버 ID로 간편구매 네이버페이</span>
												</div>
												<table class="npay_btn_list" cellspacing="0" cellpadding="0">
													<tbody>
														<tr>
															<td class="npay_btn_item"><a
																id="NPAY_BUY_LINK_IDNC_ID_1644026282324363" href="#"
																class="npay_btn_link npay_btn_pay btn_green"
																style="box-sizing: content-box;" title="새창"><span
																	class="npay_blind">네이버페이 구매하기</span></a></td>
															<td class="npay_btn_item btn_width"><a
																id="NPAY_WISH_LINK_IDNC_ID_1644026282324363" href="#"
																class="npay_btn_link npay_btn_zzim "
																style="box-sizing: content-box;" title="새창"><span
																	class="npay_blind">찜하기</span></a></td>
														</tr>
													</tbody>
												</table>
											</div>
											<div id="NPAY_EVENT_ID" class="npay_event">
												<a id="NPAY_PROMOTION_PREV_IDNC_ID_1644026282324363"
													href="#" class="npay_more npay_more_prev"><span
													class="npay_blind">이전</span></a>
												<p id="NPAY_PROMOTION_IDNC_ID_1644026282324363"
													class="npay_event_text">
													<strong class="event_title">CU더블혜택</strong><a
														class="event_link"
														href="https://m-campaign.naver.com/collect/v2/?code=2021120101_210201_008_inc_103101_20211201001_shopping_pay&amp;target=https://m-campaign.naver.com/npay/cuplus_npay/"
														target="_blank" title="새창">최대 5%적립+최대5%할인</a>
												</p>
												<a id="NPAY_PROMOTION_NEXT_IDNC_ID_1644026282324363"
													href="#" class="npay_more npay_more_next"><span
													class="npay_blind">다음</span></a>
											</div>
										</div>
									</div>
								</div>
								<!-- //네이버 체크아웃 구매 버튼 -->
								<!-- <div module="myshop_asyncbenefit" class="ec-base-box typeMember gMessage">
							<p class="message displaynone">저희 쇼핑몰을 이용해 주셔서 감사합니다.</p>
							<div class="information displaynone">
								<strong class="thumbnail"><img src="" alt="" onerror="this.src='http://img.echosting.cafe24.com/skin/base/member/img_member_default.gif';" class="" /></strong>
								<div class="description">
									<p class="member"><strong> 님</strong>은 <em>[]</em> 회원이십니다.</p>
									<p class="displaynone "><strong> </strong> 구매시 <strong></strong>을  받으실 수 있습니다. </p>
									<p class="displaynone "><strong> </strong> 구매시 <strong></strong>을  받으실 수 있습니다. </p>
								</div>
							</div>
						</div> -->


							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- //상단 제품 정보 -->

		<div class="xans-element- xans-product xans-product-detail ">
			<!-- 공급사:판매사정보 -->
			<div class="supplyInfo displaynone"></div>
			<!-- //공급사:판매사정보 -->
			<div class="eventArea displaynone">
				<div class="event"></div>
			</div>
		</div>

		<!-- 추가구성상품 -->
		<!-- 참고 : 뉴상품관리 전용 모듈입니다. 뉴상품관리 이외의 곳에서 사용하면 정상동작하지 않습니다. -->
		<!-- //참고 -->




		<!--모비온 인사이트 마케팅-->
		<!-- Enliple Insite shopDetail start -->
		<script type="text/javascript">(function(m,b,r,i,s){m.mbris=m.mbris||function(){(m.mbris.q=m.mbris.q||[]).push(arguments)};i=b.createElement(r);i.async=!0;i.defer=!0;i.src="https://cdn.megadata.co.kr/dist/prod/enp_mbris.min.js";0<b.querySelectorAll("script[src*=enp_mbris]").length&&m.ENP_MBRIS_INVOKE?m.ENP_MBRIS_INVOKE():(s=b.getElementsByTagName(r)[0],s.parentNode.insertBefore(i,s))})(window,document,"script");mbris("20210122100608634_paperbag_2_01,20210122100608634_paperbag_2_02");</script>
		<!-- 광고 노출 영역 -->
		<div id="mbris_detail_section"
			style="position: relative; display: block; height: 320px; width: 100%; box-sizing: border-box; border-radius: 12px;">
			<iframe id="iframe_mbris_detail_section"
				style="height: 320px; border: none; width: 100%; box-sizing: border-box; border-radius: 12px;"
				scrolling="no"></iframe>
		</div>
		<!-- Enliple Insite shopDetail end -->





		<div class="xans-element- xans-product xans-product-additional">
			<!-- 상품상세정보 -->
			<!-- 구매후기 -->
			<div id="use_review" class="ec-base-tab typeLight ">
				<a name="useReviewAnchor" class="anchor"></a>
				<div class="menu-wrap">
					<ul class="menu">
						<li><a href="#prdDetail">상품상세정보</a></li>
						<li><a href="#prdInfoAnchor">구매안내</a></li>
						<li class="selected"><a href="#useReviewAnchor">사용후기 (<span
								class="count reviewtalk_count_display_91"><span
									class="reviewtalk_review_count" data-product-no="34"
									data-format="REVIEWTALKCOUNT">91</span></span>)
						</a></li>
						<li><a href="#prdQnA">상품문의 (<span class="count">6</span>)
						</a></li>
						<!-- <li><a href="#prdRelation">관련상품</a></li> -->
					</ul>
				</div>

				<!--<iframe src="about:blank" id="frmReviewWrite" scrolling="no" data-islogin="T" module="Layout_statelogon"></iframe>
		<iframe src="about:blank" id="frmReviewWrite" scrolling="no" data-islogin="F" module="Layout_statelogoff"></iframe>
		<div class="no-permission displaynone">작성 권한이 없습니다.</div>

		<div class="wpReview" module="product_review">
			<dl class="gridType" data-target="#listReview">
				<dd class="g0"><a href="javascript:;"></a></dd>
				<dd class="g4 selected"><a href="javascript:;"></a></dd>
			</dl>
			<ul id="listReview" class="review-list gall grid4" data-cache-name="detail_review">
                <li class="item effect-scale" data-idx="">
                    <div class="box">
                        <div class="img img-bx-wrap"><a href="/product/best-치팅-패키지/34/display/2/" class="open-review"><img src="/board/review/img/noimage.gif" data-src="" data-attach="" class="thumb" /></a></div>
                        <div class="cont cont-left">
                            <div class="checkbox"></div>
                            <ul class="prod-wrap">
                                <li><a href="/product/best-치팅-패키지/34/display/2/"><img src="/board/review/img/noimage.gif" data-src="" class="prod-thumb" onerror="this.src='//img.echosting.cafe24.com/thumb/img_product_small.gif'" /></a></li>
                                <li>
                                    <span class="name"><a href="/product/best-치팅-패키지/34/display/2/"></a></span>
                                    <span class="rate rate ">(.0)</span>
                                </li>
                            </ul>-->
				<!-- <p class="subject ellipsis open-review"></p> -->
				<!--<p class="desc ellipsis open-review"></p>
                            <p module="Layout_statelogon"><a href="javascript:;" class="btnBasic btnModify" onclick="ListReview.modify(this);">수정</a></p>
                        </div>
                        <div class="cont cont-right">
                            <p class="writer"></p>
                            <p class="comment"></p>
                            <p class="date"></p>
                            <ul class="prod-wrap">
                                <li><a href="/product/best-치팅-패키지/34/display/2/"><img src="/board/review/img/noimage.gif" data-src="" class="prod-thumb" onerror="this.src='//img.echosting.cafe24.com/thumb/img_product_small.gif'" /></a></li>
                                <li>
                                    <span class="name"><a href="/product/best-치팅-패키지/34/display/2/"></a></span>
                                    <span class="rate rate ">(.0)</span>
                                </li>
                            </ul>
                            <ul class="vote-wrap">
                                <li class="voteTxt">이 리뷰가 도움 되었나요?</li>
                                <li><a href="javascript:;" onclick="ListReview.voteUp()" class="btnNormal btnVote">추천</a><span class="voteCount" id="wp-vote-"></span></li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li class="item effect-scale" data-idx="">
                    <div class="box">
                        <div class="img img-bx-wrap"><a href="/product/best-치팅-패키지/34/display/2/" class="open-review"><img src="/board/review/img/noimage.gif" data-src="" data-attach="" class="thumb" /></a></div>
                        <div class="cont cont-left">
                            <div class="checkbox"></div>
                            <ul class="prod-wrap">
                                <li><a href="/product/best-치팅-패키지/34/display/2/"><img src="/board/review/img/noimage.gif" data-src="" class="prod-thumb" onerror="this.src='//img.echosting.cafe24.com/thumb/img_product_small.gif'" /></a></li>
                                <li>
                                    <span class="name"><a href="/product/best-치팅-패키지/34/display/2/"></a></span>
                                    <span class="rate rate ">(.0)</span>
                                </li>
                            </ul>-->
				<!-- <p class="subject ellipsis open-review"></p> -->
				<!--<p class="desc ellipsis open-review"></p>
                            <p module="Layout_statelogon"><a href="javascript:;" class="btnBasic btnModify" onclick="ListReview.modify(this);">수정</a></p>
                        </div>
                        <div class="cont cont-right">
                            <p class="writer"></p>
                            <p class="comment"></p>
                            <p class="date"></p>
                            <ul class="prod-wrap">
                                <li><a href="/product/best-치팅-패키지/34/display/2/"><img src="/board/review/img/noimage.gif" data-src="" class="prod-thumb" onerror="this.src='//img.echosting.cafe24.com/thumb/img_product_small.gif'" /></a></li>
                                <li>
                                    <span class="name"><a href="/product/best-치팅-패키지/34/display/2/"></a></span>
                                    <span class="rate rate ">(.0)</span>
                                </li>
                            </ul>
                            <ul class="vote-wrap">
                                <li class="voteTxt">이 리뷰가 도움 되었나요?</li>
                                <li><a href="javascript:;" onclick="ListReview.voteUp()" class="btnNormal btnVote">추천</a><span class="voteCount" id="wp-vote-"></span></li>
                            </ul>
                        </div>
                    </div>
                </li>
			</ul>
		</div>
		<div module="product_reviewpaging" class="ec-base-paginate typeSub">
			<a href="" class="first"><img src="/_wp/img/btn_page_first2.jpg" alt="첫 페이지" /></a>
			<a href=""><img src="/_wp/img/btn_page_prev2.jpg" alt="이전 페이지" /></a>
			<ol>
				<li><a href=""class=""></a></li>
				<li><a href=""class=""></a></li>
				<li><a href=""class=""></a></li>
				<li><a href=""class=""></a></li>
				<li><a href=""class=""></a></li>
			</ol>
			<a href=""><img src="/_wp/img/btn_page_next2.jpg" alt="다음 페이지" /></a>
			<a href="" class="last"><img src="/_wp/img/btn_page_last2.jpg" alt="마지막 페이지" /></a>
		</div>-->

				<!-- 리뷰톡톡 -->
				<!-- 
    참고 : 이 페이지는 상품상세 리뷰요약 하단입니다
    사용되는 페이지들 : 리뷰 상세보기, 상품상세
-->
				<!-- 비동기로 전달할 템플릿 영역(반드시 포함이 되어있어야함) -->
				<div class="reviewArea notranslate" id="ec-board-zoom-wrapper"
					style="display: none;"></div>
				<div class="reviewArea notranslate"
					async_module="smartreview_dispZoom" async_type="template"
					id="ec-board-zoom">
					<!-- 비동기로 처리된 이후 노출되는 섹션 -->
					<div async_section="after" style="display: none;">
						<div class="dimmed"></div>
						<div class="zoomLayer">
							<h2>확대보기</h2>
							<div class="imgView" id="sliderWrap">
								<ul async_module="smartreview_dispFiles" async_type="template"
									class="slides">
									<!--
                        $img_count = 10
                            ※ 입력 가능 숫자 : 10 ~ 30
                    -->
									<li>{$*img_src}</li>
									<li>{$*img_src}</li>
								</ul>
								<div class="paging">
									<button type="button" class="btnPrev">이전</button>
									<button type="button" class="btnNext">다음</button>
								</div>
							</div>
							<div class="reviewThumb">
								<div class="thumbList">
									<p class="count"></p>
									<div id="zoomfakeScroll">
										<ul async_module="smartreview_dispFiles" async_type="template">
											<!--
                                $img_count = 10
                                    ※ 입력 가능 숫자 : 10 ~ 30
                            -->
											<li><a href="#none">{$*img_src_thumb_figure}</a></li>
											<li><a href="#none">{$*img_src_thumb_figure}</a></li>
										</ul>
									</div>
								</div>
							</div>
							<button type="button" class="btnClose ec-board-list-zoom-close">닫기</button>
						</div>
					</div>
				</div>
				<div _sdk_async_app_key="smartreview_dispRating_m2"
					async_status="load"
					class="xans-element- xans-smartreview xans-smartreview-disprating reviewArea notranslate">
					<!-- 비동기로 처리된 이후 노출되는 섹션 -->
					<div async_section="after" class="ec-board-files" style="">
						<div class="gradeArea ">
							<div class="status ec-board-rating-grade  ">
								<strong class="score">4.9</strong>
								<div class="ec-board-grade ec-board-star medium">
									<strong class="blind" id="ec-board-detail-rating" data-set="1"
										data-type="star">평점 아이콘</strong><span class="point left on"><span
										class="inner"></span></span><span class="point right on"><span
										class="inner"></span></span><span class="point left on"><span
										class="inner"></span></span><span class="point right on"><span
										class="inner"></span></span><span class="point left on"><span
										class="inner"></span></span><span class="point right on"><span
										class="inner"></span></span><span class="point left on"><span
										class="inner"></span></span><span class="point right on"><span
										class="inner"></span></span><span class="point left on"><span
										class="inner"></span></span><span class="point right"><span
										class="inner"></span></span>
								</div>
								<p class="desc">
									(<strong>91</strong>개 리뷰 평점)
								</p>
							</div>
							<div class="thumbList  ">
								<div async_type="template"
									class="xans-element- xans-smartreview xans-smartreview-dispfiles">
									<!--
                       $ignore_parameter = review_no
                       $img_count = 10
                            ※ 입력 가능 숫자 : 10 ~ 30
                    -->
									<div class="inner ec-board-files ">
										<div class="ec-board-files-list" style="overflow: hidden;">
											<ul style="width: 800px;">
												<li class="xans-record-"><a href="#none"
													class="ec-board-zoom-view-btn" data-index="0"><img
														src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/25/thumb_list/33c4bdef8848c559cbd6342bf4563d77.jpg"
														alt="" class="figure"
														onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
												<li class="xans-record-"><a href="#none"
													class="ec-board-zoom-view-btn" data-index="1"><img
														src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/24/thumb_list/83509f76d9bfa629bfc037b589f14c56.jpg"
														alt="" class="figure"
														onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
												<li class="xans-record-"><a href="#none"
													class="ec-board-zoom-view-btn" data-index="2"><img
														src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/24/thumb_list/7d42633124e63ca63664903a09312864.jpg"
														alt="" class="figure"
														onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
												<li class="xans-record-"><a href="#none"
													class="ec-board-zoom-view-btn" data-index="3"><img
														src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/22/thumb_list/522579ec6db70ca3965e531545cb0630.jpg"
														alt="" class="figure"
														onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
												<li class="xans-record-"><a href="#none"
													class="ec-board-zoom-view-btn" data-index="4"><img
														src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/22/thumb_list/062edb7ec4a492bd40dfb7d62a003480.jpg"
														alt="" class="figure"
														onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
												<li class="xans-record-"><a href="#none"
													class="ec-board-zoom-view-btn" data-index="5"><img
														src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/21/thumb_list/9ac5f13e6575999cf37374b6b77c31ae.jpg"
														alt="" class="figure"
														onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
												<li class="xans-record-"><a href="#none"
													class="ec-board-zoom-view-btn" data-index="6"><img
														src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/18/thumb_list/66a79ab9537a7d67b590e6aa349e5ff5.jpeg"
														alt="" class="figure"
														onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
												<li class="xans-record-"><a href="#none"
													class="ec-board-zoom-view-btn" data-index="7"><img
														src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/12/thumb_list/aeacc591d51587400c24e82b01039bf2.jpeg"
														alt="" class="figure"
														onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
												<li class="xans-record-"><a href="#none"
													class="ec-board-zoom-view-btn" data-index="8"><img
														src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/11/thumb_list/706144bd8559f5202005f16ec653b0b2.jpeg"
														alt="" class="figure"
														onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
												<li class="xans-record-"><a href="#none"
													class="ec-board-zoom-view-btn" data-index="9"><img
														src="https://reviewtalktalk.poxo.com/paperbag0/2021/12/07/thumb_list/d57198aa762bdd56adc497e1920c9a34.jpg"
														alt="" class="figure"
														onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"></a></li>
											</ul>
										</div>
										<p class="paging">
											<button type="button" class="btnPrev ec-board-files-prev-btn">이전</button>
											<button type="button" class="btnNext ec-board-files-next-btn">다음</button>
										</p>
									</div>
									<p class="empty displaynone">리뷰 사진을 기다리고 있습니다.</p>
								</div>
							</div>
							<p class="empty displaynone">
								아직 상품리뷰가 없습니다.<br>상품을 구매하고 리뷰를 작성해보세요.
							</p>
						</div>
					</div>
				</div>

				<script type="text/javascript"
					src="https://smartreview-004.cafe24.com/optimizer.php?filename=fd126209b396e52d1e534ad92cc688b0e1c60c23_1644015366&amp;type=js&amp;"></script>

				<link rel="stylesheet" type="text/css"
					href="https://smartreview-004.cafe24.com/optimizer.php?filename=fb73d8c2a59a65612e6156923049b78756da1223_1644001213&amp;type=css&amp;">
				<style type="text/css">
.reviewArea .ec-board-grade.ec-board-star.medium .point .inner {
	background-image:
		url("//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png");
}

.reviewArea .ec-board-star.small .point .inner {
	background-image:
		url("//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_small.png");
}

.reviewArea .ec-board-star.medium .point .inner {
	background-image:
		url("//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png");
}

.thumbList .row .progress-bar_value {
	height: 100%;
	background-color: #EF636F;
}

.thumbList .row .five_star_percentage {
	width: 85.714285714286%;
}

.thumbList .row .four_star_percentage {
	width: 14.285714285714%;
}

.thumbList .row .three_star_percentage {
	width: 0%;
}

.thumbList .row .two_star_percentage {
	width: 0%;
}

.thumbList .row .one_star_percentage {
	width: 0%;
}
</style>



				<!-- 상품상세 리뷰 목록(갤러리형) -->

				<div class="ec-board-list-multiple-list-wrapper">
					<div _sdk_async_app_key="smartreview_dispList_m1"
						async_status="load"
						class="xans-element- xans-smartreview xans-smartreview-displist reviewArea notranslate ">
						<!--
            $is_photo_only = F
                ※ T 포토리뷰만 보기 / F 모든리뷰 보기
                
            $more_view_type = button
                ※ button : 다음글을 더보기 버튼으로 제어
                   paginate : 다음글을 페이지네이트로 제어

            $sns_popup_url = /board/smartreview/sns_popup.html

            $sort_order = recent
                ※ recent : 최신순으로 기본정렬
                   rating : 평점순으로 기본정렬
                   like : 좋아요순으로 기본정렬
                   hit : 조회수순으로 기본정렬
        -->
						<!-- 비동기로 처리전 노출되는 섹션 -->
						<div async_section="before" style="display: none;">
							<div class="loading">
								<img
									src="//img.echosting.cafe24.com/skin/base/board/review/ico_loading.gif"
									alt="로딩중입니다. 잠시만 기다려 주세요"> &nbsp;
							</div>
						</div>
						<!-- 비동기로 처리된 이후 노출되는 섹션 -->
						<div async_section="after" style="">
							<div
								class="xans-element- xans-smartreview xans-smartreview-dispdetailreview ">
								<div class="btnArea">
									<a class="btnNormalFix sizeS"
										href="/board/smartreview/list.html">모두 전체보기</a> <a
										class="btnSubmitFix sizeS" href="#none"
										onclick="__alert('회원에게만 글작성 권한이 있습니다.');return false;">리뷰작성</a>
								</div>
							</div>
							<div class="reviewSearch">
								<ul class="sorting">
									<li class="selected"><a href="#none"
										class="ec-board-list-sorting" data-sort-order="recent"
										data-sort-order-text="최신순">최신순 (91)</a></li>
									<li class=""><a href="#none" class="ec-board-list-sorting"
										data-sort-order="rating" data-sort-order-text="평점순">평점순</a></li>
									<li><a href="#none" class="ec-board-list-sorting"
										data-sort-order="like" data-sort-order-text="좋아요순">좋아요순</a></li>
									<li><a href="#none" class="ec-board-list-sorting"
										data-sort-order="hit" data-sort-order-text="조회수순">조회수순</a></li>
								</ul>
								<div class="ctrl">
									<label><input type="checkbox"
										class="ec-board-list-photo-only"> 포토리뷰만 보기</label>
									<div class="searchWrap">
										<select class="ec-board-list-search-type"><option
												value="content" selected="selected">내용</option>
											<option value="prd.name">상품명</option>
											<option value="writing.id">아이디</option></select>
										<div class="search">
											<input type="text" class="keyword ec-board-list-keyword"
												value="" placeholder="검색어 입력">
											<button type="submit"
												class="btnSearch ec-board-list-search-keyword">검색</button>
										</div>
									</div>
								</div>
							</div>
							<div class="searchArea">
								<button type="button"
									class="btnOpen ec-board-list-search-detail displaynone">상세검색
									열기</button>
								<div class="searchList ec-board-list-additems">
									<table border="1" summary="">
										<caption>상세검색</caption>
										<colgroup>
											<col style="width: 123px;">
											<col style="width: auto;">
										</colgroup>
									</table>
								</div>
							</div>
							<div class="reviewList ec-board-list-items-data ">
								<ul
									class="xans-element- xans-smartreview xans-smartreview-displistitems"
									style="width: 1200.01px; height: 891.734px;">
									<!--
                        $is_photo_only = F
                            ※ T 포토리뷰만 보기 / F 모든리뷰 보기

                        $sort_order = recent
                            ※ recent : 최신순으로 기본정렬
                               rating : 평점순으로 기본정렬
                               like : 좋아요순으로 기본정렬
                               hit : 조회수순으로 기본정렬
                    -->
									<!--
    참고 : 이 페이지는 리뷰 아이템입니다
    사용되는 페이지들 : 상품상세 리뷰 목록, 해시태그 모아보기, 작성자글 모아보기, 리뷰 목록
-->
									<li data-bulletin-no="84937"
										style="width: 292.01px; left: 0px; top: 4px; position: absolute;"
										class="grid ec-board-list-item notranslate xans-record-">
										<div class="reviewInfo">
											<div class="reviewImg displaynone">
												<a href="#none"
													class="reviewThumb ec-board-list-review-read"></a>
												<div class="gradeLayer" title="5">
													<div class="ec-board-grade ec-board-star medium">
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">0.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">5.0</span></span>
													</div>
													<div class="gradeBg"></div>
												</div>
											</div>
											<div class="prdOption typeSimple displaynone ">
												<p class="normal displaynone">
													<span class="option"></span>
												</p>
												<ul class="set displaynone">
												</ul>
											</div>
											<span class="icon "><img
												src="//img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_best.gif"
												style="display: none;" class="eBestIcon"></span> <span
												class="icon displaynone"></span> <span
												class="icon displaynone"></span> <a href="#none"
												class="summary ec-board-list-review-read"> <strong
												class="heading"><span class="bulletinHeading">
														항상구매하는 ㅎㅎ 맛있어서 좋아요 (2022-02-03 21:20:39 에 등록된 네이버 페이 구매평)
												</span></strong> <span class="info"> <strong>네이버 페이 구매자</strong> <span
													class="date">2022-02-04 04:54</span>
											</span>
											</a>
											<div class="community">
												<a href="#none"
													class="comment ec-board-list-review-read  empty">댓글 <strong
													class="count ec-board-comment-count">0</strong></a>
												<div class="social">
													<button type="button"
														class="btnLike  ec-board-list-sns-share-button-84937">좋아요</button>
													<button type="button" class="btnShare displaynone">공유하기</button>
													<div class="shareLayer">
														<ul>
															<li class=""><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_facebook.gif"
																alt="페이스북"> &nbsp;<a href="#none"
																data-sns-share="facebook">페이스북</a></li>
															<li><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_kakao_story.gif"
																alt="카카오스토리"> &nbsp;<a href="#none"
																data-sns-share="kakaostory">카카오스토리</a></li>
															<li class="displaynone"><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_instagram.gif"
																alt="인스타그램"> &nbsp;<a href="#none"
																data-sns-share="instagram">인스타그램</a></li>
														</ul>
														<span class="edge"></span>
													</div>
												</div>
											</div>
										</div>
										<div class="prdInfo displaynone">
											<p class="reviewThumb">
												<a href="/product/detail.html?product_no=34"><img
													src="//paperbag.co.kr/web/product/tiny/202108/fb3b3b73d2559875df6f1d55620b11b5.jpg"></a>
											</p>
											<div class="summary">
												<a href="/product/detail.html?product_no=34" class="heading"><strong>[BEST]
														치팅 패키지</strong></a>
												<div class="prdOption typeSimple displaynone">
													<p class="normal displaynone">
														<span class="option"></span>
													</p>
													<ul class="set displaynone">
													</ul>
												</div>
												<div class="info">
													<dl class="">
														<dt>평점</dt>
														<dd>4.9</dd>
													</dl>
													<dl>
														<dt>리뷰</dt>
														<dd>91</dd>
													</dl>
												</div>
											</div>
										</div>
									</li>
									<li data-bulletin-no="84931"
										style="width: 292.01px; left: 300.002px; top: 4px; position: absolute;"
										class="grid ec-board-list-item notranslate xans-record-">
										<div class="reviewInfo">
											<div class="reviewImg displaynone">
												<a href="#none"
													class="reviewThumb ec-board-list-review-read"></a>
												<div class="gradeLayer" title="5">
													<div class="ec-board-grade ec-board-star medium">
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">0.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">5.0</span></span>
													</div>
													<div class="gradeBg"></div>
												</div>
											</div>
											<div class="prdOption typeSimple displaynone ">
												<p class="normal displaynone">
													<span class="option"></span>
												</p>
												<ul class="set displaynone">
												</ul>
											</div>
											<span class="icon "><img
												src="//img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_best.gif"
												style="display: none;" class="eBestIcon"></span> <span
												class="icon displaynone"></span> <span
												class="icon displaynone"></span> <a href="#none"
												class="summary ec-board-list-review-read"> <strong
												class="heading"><span class="bulletinHeading">
														간단히 먹기도 좋고 맛도 있고 포만감도 괜찮아요 (2022-02-03 10:02:01 에 등록된 네이버
														페이... </span></strong> <span class="info"> <strong>네이버 페이
														구매자</strong> <span class="date">2022-02-04 02:58</span>
											</span>
											</a>
											<div class="community">
												<a href="#none"
													class="comment ec-board-list-review-read  empty">댓글 <strong
													class="count ec-board-comment-count">0</strong></a>
												<div class="social">
													<button type="button"
														class="btnLike  ec-board-list-sns-share-button-84931">좋아요</button>
													<button type="button" class="btnShare displaynone">공유하기</button>
													<div class="shareLayer">
														<ul>
															<li class=""><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_facebook.gif"
																alt="페이스북"> &nbsp;<a href="#none"
																data-sns-share="facebook">페이스북</a></li>
															<li><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_kakao_story.gif"
																alt="카카오스토리"> &nbsp;<a href="#none"
																data-sns-share="kakaostory">카카오스토리</a></li>
															<li class="displaynone"><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_instagram.gif"
																alt="인스타그램"> &nbsp;<a href="#none"
																data-sns-share="instagram">인스타그램</a></li>
														</ul>
														<span class="edge"></span>
													</div>
												</div>
											</div>
										</div>
										<div class="prdInfo displaynone">
											<p class="reviewThumb">
												<a href="/product/detail.html?product_no=34"><img
													src="//paperbag.co.kr/web/product/tiny/202108/fb3b3b73d2559875df6f1d55620b11b5.jpg"></a>
											</p>
											<div class="summary">
												<a href="/product/detail.html?product_no=34" class="heading"><strong>[BEST]
														치팅 패키지</strong></a>
												<div class="prdOption typeSimple displaynone">
													<p class="normal displaynone">
														<span class="option"></span>
													</p>
													<ul class="set displaynone">
													</ul>
												</div>
												<div class="info">
													<dl class="">
														<dt>평점</dt>
														<dd>4.9</dd>
													</dl>
													<dl>
														<dt>리뷰</dt>
														<dd>91</dd>
													</dl>
												</div>
											</div>
										</div>
									</li>
									<li data-bulletin-no="84897"
										style="width: 292.01px; left: 600.005px; top: 4px; position: absolute;"
										class="grid ec-board-list-item notranslate xans-record-">
										<div class="reviewInfo">
											<div class="reviewImg displaynone">
												<a href="#none"
													class="reviewThumb ec-board-list-review-read"></a>
												<div class="gradeLayer" title="5">
													<div class="ec-board-grade ec-board-star medium">
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">0.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">5.0</span></span>
													</div>
													<div class="gradeBg"></div>
												</div>
											</div>
											<div class="prdOption typeSimple displaynone ">
												<p class="normal displaynone">
													<span class="option"></span>
												</p>
												<ul class="set displaynone">
												</ul>
											</div>
											<span class="icon "><img
												src="//img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_best.gif"
												style="display: none;" class="eBestIcon"></span> <span
												class="icon displaynone"></span> <span
												class="icon displaynone"></span> <a href="#none"
												class="summary ec-board-list-review-read"> <strong
												class="heading"><span class="bulletinHeading">
														진짜 짱맛!! 지인들도 다들 맛있다고들!! (2022-01-31 11:46:17 에 등록된 네이버 페이
														구매... </span></strong> <span class="info"> <strong>네이버 페이
														구매자</strong> <span class="date">2022-02-01 03:07</span>
											</span>
											</a>
											<div class="community">
												<a href="#none"
													class="comment ec-board-list-review-read  empty">댓글 <strong
													class="count ec-board-comment-count">0</strong></a>
												<div class="social">
													<button type="button"
														class="btnLike  ec-board-list-sns-share-button-84897">좋아요</button>
													<button type="button" class="btnShare displaynone">공유하기</button>
													<div class="shareLayer">
														<ul>
															<li class=""><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_facebook.gif"
																alt="페이스북"> &nbsp;<a href="#none"
																data-sns-share="facebook">페이스북</a></li>
															<li><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_kakao_story.gif"
																alt="카카오스토리"> &nbsp;<a href="#none"
																data-sns-share="kakaostory">카카오스토리</a></li>
															<li class="displaynone"><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_instagram.gif"
																alt="인스타그램"> &nbsp;<a href="#none"
																data-sns-share="instagram">인스타그램</a></li>
														</ul>
														<span class="edge"></span>
													</div>
												</div>
											</div>
										</div>
										<div class="prdInfo displaynone">
											<p class="reviewThumb">
												<a href="/product/detail.html?product_no=34"><img
													src="//paperbag.co.kr/web/product/tiny/202108/fb3b3b73d2559875df6f1d55620b11b5.jpg"></a>
											</p>
											<div class="summary">
												<a href="/product/detail.html?product_no=34" class="heading"><strong>[BEST]
														치팅 패키지</strong></a>
												<div class="prdOption typeSimple displaynone">
													<p class="normal displaynone">
														<span class="option"></span>
													</p>
													<ul class="set displaynone">
													</ul>
												</div>
												<div class="info">
													<dl class="">
														<dt>평점</dt>
														<dd>4.9</dd>
													</dl>
													<dl>
														<dt>리뷰</dt>
														<dd>91</dd>
													</dl>
												</div>
											</div>
										</div>
									</li>
									<li data-bulletin-no="84866"
										style="width: 292.01px; left: 900.007px; top: 4px; position: absolute;"
										class="grid ec-board-list-item notranslate xans-record-">
										<div class="reviewInfo">
											<div class="reviewImg displaynone">
												<a href="#none"
													class="reviewThumb ec-board-list-review-read"></a>
												<div class="gradeLayer" title="5">
													<div class="ec-board-grade ec-board-star medium">
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">0.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">5.0</span></span>
													</div>
													<div class="gradeBg"></div>
												</div>
											</div>
											<div class="prdOption typeSimple displaynone ">
												<p class="normal displaynone">
													<span class="option"></span>
												</p>
												<ul class="set displaynone">
												</ul>
											</div>
											<span class="icon "><img
												src="//img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_best.gif"
												style="display: none;" class="eBestIcon"></span> <span
												class="icon "><img
												src="//img.echosting.cafe24.com/skin/admin_ko_KR/board/ico_mobile.gif"
												alt="Mobile"></span> <span class="icon displaynone"></span> <a
												href="#none" class="summary ec-board-list-review-read">
												<strong class="heading"><span
													class="bulletinHeading"> 준호가 광고해서 샀는데 원래 쉐이크 맛없어서
														싫어했음에도 이거는 맛있어서 잘먹고 있어요! </span></strong> <span class="info"> <strong>20**********</strong>
													<span class="date">2022-01-29 19:46</span>
											</span>
											</a>
											<div class="community">
												<a href="#none"
													class="comment ec-board-list-review-read  empty">댓글 <strong
													class="count ec-board-comment-count">0</strong></a>
												<div class="social">
													<button type="button"
														class="btnLike  ec-board-list-sns-share-button-84866">좋아요</button>
													<button type="button" class="btnShare displaynone">공유하기</button>
													<div class="shareLayer">
														<ul>
															<li class=""><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_facebook.gif"
																alt="페이스북"> &nbsp;<a href="#none"
																data-sns-share="facebook">페이스북</a></li>
															<li><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_kakao_story.gif"
																alt="카카오스토리"> &nbsp;<a href="#none"
																data-sns-share="kakaostory">카카오스토리</a></li>
															<li class="displaynone"><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_instagram.gif"
																alt="인스타그램"> &nbsp;<a href="#none"
																data-sns-share="instagram">인스타그램</a></li>
														</ul>
														<span class="edge"></span>
													</div>
												</div>
											</div>
										</div>
										<div class="prdInfo displaynone">
											<p class="reviewThumb">
												<a href="/product/detail.html?product_no=34"><img
													src="//paperbag.co.kr/web/product/tiny/202108/fb3b3b73d2559875df6f1d55620b11b5.jpg"></a>
											</p>
											<div class="summary">
												<a href="/product/detail.html?product_no=34" class="heading"><strong>[BEST]
														치팅 패키지</strong></a>
												<div class="prdOption typeSimple displaynone">
													<p class="normal displaynone">
														<span class="option"></span>
													</p>
													<ul class="set displaynone">
													</ul>
												</div>
												<div class="info">
													<dl class="">
														<dt>평점</dt>
														<dd>4.9</dd>
													</dl>
													<dl>
														<dt>리뷰</dt>
														<dd>91</dd>
													</dl>
												</div>
											</div>
										</div>
									</li>
									<li data-bulletin-no="54848"
										style="width: 292.01px; left: 0px; top: 168.457px; position: absolute;"
										class="grid ec-board-list-item notranslate xans-record-">
										<div class="reviewInfo">
											<div class="reviewImg displaynone">
												<a href="#none"
													class="reviewThumb ec-board-list-review-read"></a>
												<div class="gradeLayer" title="5">
													<div class="ec-board-grade ec-board-star medium">
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">0.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">5.0</span></span>
													</div>
													<div class="gradeBg"></div>
												</div>
											</div>
											<div class="prdOption typeSimple displaynone ">
												<p class="normal displaynone">
													<span class="option"></span>
												</p>
												<ul class="set displaynone">
												</ul>
											</div>
											<span class="icon "><img
												src="//img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_best.gif"
												style="display: none;" class="eBestIcon"></span> <span
												class="icon displaynone"></span> <span
												class="icon displaynone"></span> <a href="#none"
												class="summary ec-board-list-review-read"> <strong
												class="heading"><span class="bulletinHeading">
														저는 유당불내증이 심한 편이라.. 쉐이크 도전할때 엄청 겁 많이 먹고 했는데.. 속 부데끼는게 전~혀
														없는건... </span></strong> <span class="info"> <strong>네이버 페이
														구매자</strong> <span class="date">2022-01-26 04:17</span>
											</span>
											</a>
											<div class="community">
												<a href="#none"
													class="comment ec-board-list-review-read  empty">댓글 <strong
													class="count ec-board-comment-count">0</strong></a>
												<div class="social">
													<button type="button"
														class="btnLike  ec-board-list-sns-share-button-54848">좋아요</button>
													<button type="button" class="btnShare displaynone">공유하기</button>
													<div class="shareLayer">
														<ul>
															<li class=""><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_facebook.gif"
																alt="페이스북"> &nbsp;<a href="#none"
																data-sns-share="facebook">페이스북</a></li>
															<li><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_kakao_story.gif"
																alt="카카오스토리"> &nbsp;<a href="#none"
																data-sns-share="kakaostory">카카오스토리</a></li>
															<li class="displaynone"><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_instagram.gif"
																alt="인스타그램"> &nbsp;<a href="#none"
																data-sns-share="instagram">인스타그램</a></li>
														</ul>
														<span class="edge"></span>
													</div>
												</div>
											</div>
										</div>
										<div class="prdInfo displaynone">
											<p class="reviewThumb">
												<a href="/product/detail.html?product_no=34"><img
													src="//paperbag.co.kr/web/product/tiny/202108/fb3b3b73d2559875df6f1d55620b11b5.jpg"></a>
											</p>
											<div class="summary">
												<a href="/product/detail.html?product_no=34" class="heading"><strong>[BEST]
														치팅 패키지</strong></a>
												<div class="prdOption typeSimple displaynone">
													<p class="normal displaynone">
														<span class="option"></span>
													</p>
													<ul class="set displaynone">
													</ul>
												</div>
												<div class="info">
													<dl class="">
														<dt>평점</dt>
														<dd>4.9</dd>
													</dl>
													<dl>
														<dt>리뷰</dt>
														<dd>91</dd>
													</dl>
												</div>
											</div>
										</div>
									</li>
									<li data-bulletin-no="54832"
										style="width: 292.01px; left: 600.005px; top: 168.457px; position: absolute;"
										class="grid ec-board-list-item notranslate xans-record-">
										<div class="reviewInfo">
											<div class="reviewImg ">
												<a href="#none"
													class="reviewThumb ec-board-list-review-read"><img
													src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/25/thumb_list/33c4bdef8848c559cbd6342bf4563d77.jpg"
													width="300" height="400"
													onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"
													class="ec-board-list-item-img"></a>
												<div class="gradeLayer" title="4">
													<div class="ec-board-grade ec-board-star medium">
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">0.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.0</span></span>
														<span class="point left "><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.5</span></span>
														<span class="point right "><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">5.0</span></span>
													</div>
													<div class="gradeBg"></div>
												</div>
											</div>
											<div class="prdOption typeSimple displaynone ">
												<p class="normal displaynone">
													<span class="option"></span>
												</p>
												<ul class="set displaynone">
												</ul>
											</div>
											<span class="icon "><img
												src="//img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_best.gif"
												style="display: none;" class="eBestIcon"></span> <span
												class="icon "><img
												src="//img.echosting.cafe24.com/skin/admin_ko_KR/board/ico_mobile.gif"
												alt="Mobile"></span> <span class="icon displaynone"></span> <a
												href="#none" class="summary ec-board-list-review-read">
												<strong class="heading"><span
													class="bulletinHeading"> 간편해서 너무좋아요~ 맛도있고 특히 씹하는
														맛덕분에 처음먹었을때 포만감도있는데,,길게지속되진 않지만 그래도 ... </span></strong> <span
												class="info"> <strong>20**********</strong> <span
													class="date">2022-01-25 08:31</span>
											</span>
											</a>
											<div class="community">
												<a href="#none"
													class="comment ec-board-list-review-read  empty">댓글 <strong
													class="count ec-board-comment-count">0</strong></a>
												<div class="social">
													<button type="button"
														class="btnLike  ec-board-list-sns-share-button-54832">좋아요</button>
													<button type="button" class="btnShare ">공유하기</button>
													<div class="shareLayer">
														<ul>
															<li class=""><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_facebook.gif"
																alt="페이스북"> &nbsp;<a href="#none"
																data-sns-share="facebook">페이스북</a></li>
															<li><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_kakao_story.gif"
																alt="카카오스토리"> &nbsp;<a href="#none"
																data-sns-share="kakaostory">카카오스토리</a></li>
															<li class="displaynone"><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_instagram.gif"
																alt="인스타그램"> &nbsp;<a href="#none"
																data-sns-share="instagram">인스타그램</a></li>
														</ul>
														<span class="edge"></span>
													</div>
												</div>
											</div>
										</div>
										<div class="prdInfo displaynone">
											<p class="reviewThumb">
												<a href="/product/detail.html?product_no=34"><img
													src="//paperbag.co.kr/web/product/tiny/202108/fb3b3b73d2559875df6f1d55620b11b5.jpg"></a>
											</p>
											<div class="summary">
												<a href="/product/detail.html?product_no=34" class="heading"><strong>[BEST]
														치팅 패키지</strong></a>
												<div class="prdOption typeSimple displaynone">
													<p class="normal displaynone">
														<span class="option"></span>
													</p>
													<ul class="set displaynone">
													</ul>
												</div>
												<div class="info">
													<dl class="">
														<dt>평점</dt>
														<dd>4.9</dd>
													</dl>
													<dl>
														<dt>리뷰</dt>
														<dd>91</dd>
													</dl>
												</div>
											</div>
										</div>
									</li>
									<li data-bulletin-no="54802"
										style="width: 292.01px; left: 900.007px; top: 183.457px; position: absolute;"
										class="grid ec-board-list-item notranslate xans-record-">
										<div class="reviewInfo">
											<div class="reviewImg ">
												<a href="#none"
													class="reviewThumb ec-board-list-review-read"><img
													src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/24/thumb_list/83509f76d9bfa629bfc037b589f14c56.jpg"
													width="300" height="400"
													onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"
													class="ec-board-list-item-img"></a>
												<div class="gradeLayer" title="4">
													<div class="ec-board-grade ec-board-star medium">
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">0.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.0</span></span>
														<span class="point left "><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.5</span></span>
														<span class="point right "><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">5.0</span></span>
													</div>
													<div class="gradeBg"></div>
												</div>
											</div>
											<div class="prdOption typeSimple displaynone ">
												<p class="normal displaynone">
													<span class="option"></span>
												</p>
												<ul class="set displaynone">
												</ul>
											</div>
											<span class="icon "><img
												src="//img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_best.gif"
												style="display: none;" class="eBestIcon"></span> <span
												class="icon "><img
												src="//img.echosting.cafe24.com/skin/admin_ko_KR/board/ico_mobile.gif"
												alt="Mobile"></span> <span class="icon displaynone"></span> <a
												href="#none" class="summary ec-board-list-review-read">
												<strong class="heading"><span
													class="bulletinHeading"> 간편하고 맛있어요~ 운전하면서고 편하게 마시면서
														식사대용으로 굿~ 씹히는 맛도있고 포만감도 있는게 좋아요~!... </span></strong> <span class="info">
													<strong>20**********</strong> <span class="date">2022-01-24
														10:49</span>
											</span>
											</a>
											<div class="community">
												<a href="#none"
													class="comment ec-board-list-review-read  empty">댓글 <strong
													class="count ec-board-comment-count">0</strong></a>
												<div class="social">
													<button type="button"
														class="btnLike  ec-board-list-sns-share-button-54802">좋아요</button>
													<button type="button" class="btnShare ">공유하기</button>
													<div class="shareLayer">
														<ul>
															<li class=""><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_facebook.gif"
																alt="페이스북"> &nbsp;<a href="#none"
																data-sns-share="facebook">페이스북</a></li>
															<li><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_kakao_story.gif"
																alt="카카오스토리"> &nbsp;<a href="#none"
																data-sns-share="kakaostory">카카오스토리</a></li>
															<li class="displaynone"><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_instagram.gif"
																alt="인스타그램"> &nbsp;<a href="#none"
																data-sns-share="instagram">인스타그램</a></li>
														</ul>
														<span class="edge"></span>
													</div>
												</div>
											</div>
										</div>
										<div class="prdInfo displaynone">
											<p class="reviewThumb">
												<a href="/product/detail.html?product_no=34"><img
													src="//paperbag.co.kr/web/product/tiny/202108/fb3b3b73d2559875df6f1d55620b11b5.jpg"></a>
											</p>
											<div class="summary">
												<a href="/product/detail.html?product_no=34" class="heading"><strong>[BEST]
														치팅 패키지</strong></a>
												<div class="prdOption typeSimple displaynone">
													<p class="normal displaynone">
														<span class="option"></span>
													</p>
													<ul class="set displaynone">
													</ul>
												</div>
												<div class="info">
													<dl class="">
														<dt>평점</dt>
														<dd>4.9</dd>
													</dl>
													<dl>
														<dt>리뷰</dt>
														<dd>91</dd>
													</dl>
												</div>
											</div>
										</div>
									</li>
									<li data-bulletin-no="54800"
										style="width: 292.01px; left: 300.002px; top: 186.457px; position: absolute;"
										class="grid ec-board-list-item notranslate xans-record-">
										<div class="reviewInfo">
											<div class="reviewImg ">
												<a href="#none"
													class="reviewThumb ec-board-list-review-read"><img
													src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/24/thumb_list/7d42633124e63ca63664903a09312864.jpg"
													width="300" height="400"
													onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"
													class="ec-board-list-item-img"></a>
												<div class="gradeLayer" title="4">
													<div class="ec-board-grade ec-board-star medium">
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">0.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.0</span></span>
														<span class="point left "><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.5</span></span>
														<span class="point right "><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">5.0</span></span>
													</div>
													<div class="gradeBg"></div>
												</div>
											</div>
											<div class="prdOption typeSimple displaynone ">
												<p class="normal displaynone">
													<span class="option"></span>
												</p>
												<ul class="set displaynone">
												</ul>
											</div>
											<span class="icon "><img
												src="//img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_best.gif"
												style="display: none;" class="eBestIcon"></span> <span
												class="icon "><img
												src="//img.echosting.cafe24.com/skin/admin_ko_KR/board/ico_mobile.gif"
												alt="Mobile"></span> <span class="icon displaynone"></span> <a
												href="#none" class="summary ec-board-list-review-read">
												<strong class="heading"><span
													class="bulletinHeading"> 오오오~~ 맛있어요! 은근 포만감도있구 씹히는맛이
														아주 좋습니다~! </span></strong> <span class="info"> <strong>20**********</strong>
													<span class="date">2022-01-24 08:59</span>
											</span>
											</a>
											<div class="community">
												<a href="#none"
													class="comment ec-board-list-review-read  empty">댓글 <strong
													class="count ec-board-comment-count">0</strong></a>
												<div class="social">
													<button type="button"
														class="btnLike  ec-board-list-sns-share-button-54800">좋아요</button>
													<button type="button" class="btnShare ">공유하기</button>
													<div class="shareLayer">
														<ul>
															<li class=""><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_facebook.gif"
																alt="페이스북"> &nbsp;<a href="#none"
																data-sns-share="facebook">페이스북</a></li>
															<li><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_kakao_story.gif"
																alt="카카오스토리"> &nbsp;<a href="#none"
																data-sns-share="kakaostory">카카오스토리</a></li>
															<li class="displaynone"><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_instagram.gif"
																alt="인스타그램"> &nbsp;<a href="#none"
																data-sns-share="instagram">인스타그램</a></li>
														</ul>
														<span class="edge"></span>
													</div>
												</div>
											</div>
										</div>
										<div class="prdInfo displaynone">
											<p class="reviewThumb">
												<a href="/product/detail.html?product_no=34"><img
													src="//paperbag.co.kr/web/product/tiny/202108/fb3b3b73d2559875df6f1d55620b11b5.jpg"></a>
											</p>
											<div class="summary">
												<a href="/product/detail.html?product_no=34" class="heading"><strong>[BEST]
														치팅 패키지</strong></a>
												<div class="prdOption typeSimple displaynone">
													<p class="normal displaynone">
														<span class="option"></span>
													</p>
													<ul class="set displaynone">
													</ul>
												</div>
												<div class="info">
													<dl class="">
														<dt>평점</dt>
														<dd>4.9</dd>
													</dl>
													<dl>
														<dt>리뷰</dt>
														<dd>91</dd>
													</dl>
												</div>
											</div>
										</div>
									</li>
									<li data-bulletin-no="54755"
										style="width: 292.01px; left: 0px; top: 350.914px; position: absolute;"
										class="grid ec-board-list-item notranslate xans-record-">
										<div class="reviewInfo">
											<div class="reviewImg ">
												<a href="#none"
													class="reviewThumb ec-board-list-review-read"><img
													src="https://reviewtalktalk.poxo.com/paperbag0/2022/01/22/thumb_list/522579ec6db70ca3965e531545cb0630.jpg"
													width="300" height="300"
													onerror="this.src='//img.echosting.cafe24.com/skin/base/board/review/@img_thumb.gif';"
													class="ec-board-list-item-img"></a>
												<div class="gradeLayer" title="5">
													<div class="ec-board-grade ec-board-star medium">
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">0.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">5.0</span></span>
													</div>
													<div class="gradeBg"></div>
												</div>
											</div>
											<div class="prdOption typeSimple displaynone ">
												<p class="normal displaynone">
													<span class="option"></span>
												</p>
												<ul class="set displaynone">
												</ul>
											</div>
											<span class="icon "><img
												src="//img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_best.gif"
												style="display: none;" class="eBestIcon"></span> <span
												class="icon "><img
												src="//img.echosting.cafe24.com/skin/admin_ko_KR/board/ico_mobile.gif"
												alt="Mobile"></span> <span class="icon displaynone"></span> <a
												href="#none" class="summary ec-board-list-review-read">
												<strong class="heading"><span
													class="bulletinHeading"> 베송도 생각보다 빨리왔고 지금 2일차 점심엔 효소
														저녁에 쉐이크로 먹어보고있습니다. 효소도 냄새가 심하거나 ... </span></strong> <span class="info">
													<strong>20**********</strong> <span class="date">2022-01-22
														09:17</span>
											</span>
											</a>
											<div class="community">
												<a href="#none"
													class="comment ec-board-list-review-read  empty">댓글 <strong
													class="count ec-board-comment-count">0</strong></a>
												<div class="social">
													<button type="button"
														class="btnLike  ec-board-list-sns-share-button-54755">좋아요</button>
													<button type="button" class="btnShare ">공유하기</button>
													<div class="shareLayer">
														<ul>
															<li class=""><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_facebook.gif"
																alt="페이스북"> &nbsp;<a href="#none"
																data-sns-share="facebook">페이스북</a></li>
															<li><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_kakao_story.gif"
																alt="카카오스토리"> &nbsp;<a href="#none"
																data-sns-share="kakaostory">카카오스토리</a></li>
															<li class="displaynone"><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_instagram.gif"
																alt="인스타그램"> &nbsp;<a href="#none"
																data-sns-share="instagram">인스타그램</a></li>
														</ul>
														<span class="edge"></span>
													</div>
												</div>
											</div>
										</div>
										<div class="prdInfo displaynone">
											<p class="reviewThumb">
												<a href="/product/detail.html?product_no=34"><img
													src="//paperbag.co.kr/web/product/tiny/202108/fb3b3b73d2559875df6f1d55620b11b5.jpg"></a>
											</p>
											<div class="summary">
												<a href="/product/detail.html?product_no=34" class="heading"><strong>[BEST]
														치팅 패키지</strong></a>
												<div class="prdOption typeSimple displaynone">
													<p class="normal displaynone">
														<span class="option"></span>
													</p>
													<ul class="set displaynone">
													</ul>
												</div>
												<div class="info">
													<dl class="">
														<dt>평점</dt>
														<dd>4.9</dd>
													</dl>
													<dl>
														<dt>리뷰</dt>
														<dd>91</dd>
													</dl>
												</div>
											</div>
										</div>
									</li>
									<li data-bulletin-no="54751"
										style="width: 292.01px; left: 300.002px; top: 705.277px; position: absolute;"
										class="grid ec-board-list-item notranslate xans-record-">
										<div class="reviewInfo">
											<div class="reviewImg displaynone">
												<a href="#none"
													class="reviewThumb ec-board-list-review-read"></a>
												<div class="gradeLayer" title="5">
													<div class="ec-board-grade ec-board-star medium">
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">0.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">1.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">2.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">3.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.0</span></span>
														<span class="point left on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">4.5</span></span>
														<span class="point right on"><span class="inner"
															style="background-image: url('//img.echosting.cafe24.com/skin/base/board/review/ico_grade_star_set1_medium.png')">5.0</span></span>
													</div>
													<div class="gradeBg"></div>
												</div>
											</div>
											<div class="prdOption typeSimple displaynone ">
												<p class="normal displaynone">
													<span class="option"></span>
												</p>
												<ul class="set displaynone">
												</ul>
											</div>
											<span class="icon "><img
												src="//img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_best.gif"
												style="display: none;" class="eBestIcon"></span> <span
												class="icon displaynone"></span> <span
												class="icon displaynone"></span> <a href="#none"
												class="summary ec-board-list-review-read"> <strong
												class="heading"><span class="bulletinHeading">
														준호가 모델이기도 하고 다이어트 식단 찾던중이었던지라 구매해서 먹어보고 맛없으면 걍 나눠줘야지 했는데
														왠걸 ... </span></strong> <span class="info"> <strong>네이버 페이
														구매자</strong> <span class="date">2022-01-22 06:20</span>
											</span>
											</a>
											<div class="community">
												<a href="#none"
													class="comment ec-board-list-review-read  empty">댓글 <strong
													class="count ec-board-comment-count">0</strong></a>
												<div class="social">
													<button type="button"
														class="btnLike  ec-board-list-sns-share-button-54751">좋아요</button>
													<button type="button" class="btnShare displaynone">공유하기</button>
													<div class="shareLayer">
														<ul>
															<li class=""><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_facebook.gif"
																alt="페이스북"> &nbsp;<a href="#none"
																data-sns-share="facebook">페이스북</a></li>
															<li><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_kakao_story.gif"
																alt="카카오스토리"> &nbsp;<a href="#none"
																data-sns-share="kakaostory">카카오스토리</a></li>
															<li class="displaynone"><img
																src="//img.echosting.cafe24.com/skin/base/board/review/ico_instagram.gif"
																alt="인스타그램"> &nbsp;<a href="#none"
																data-sns-share="instagram">인스타그램</a></li>
														</ul>
														<span class="edge"></span>
													</div>
												</div>
											</div>
										</div>
										<div class="prdInfo displaynone">
											<p class="reviewThumb">
												<a href="/product/detail.html?product_no=34"><img
													src="//paperbag.co.kr/web/product/tiny/202108/fb3b3b73d2559875df6f1d55620b11b5.jpg"></a>
											</p>
											<div class="summary">
												<a href="/product/detail.html?product_no=34" class="heading"><strong>[BEST]
														치팅 패키지</strong></a>
												<div class="prdOption typeSimple displaynone">
													<p class="normal displaynone">
														<span class="option"></span>
													</p>
													<ul class="set displaynone">
													</ul>
												</div>
												<div class="info">
													<dl class="">
														<dt>평점</dt>
														<dd>4.9</dd>
													</dl>
													<dl>
														<dt>리뷰</dt>
														<dd>91</dd>
													</dl>
												</div>
											</div>
										</div>
									</li>
								</ul>
								<div style="display: none;" class="ec-board-list-items-loading">
									<div class="loading">
										<img
											src="//img.echosting.cafe24.com/skin/base/board/review/ico_loading.gif"
											alt="로딩중입니다. 잠시만 기다려 주세요"> &nbsp;
									</div>
								</div>
							</div>
							<div
								class="reviewListEmpty ec-board-list-items-empty displaynone">상품리뷰가
								없습니다.</div>
							<button type="button" class="btnMore ec-board-list-more-button ">
								<span>리뷰글 더 보기</span>
							</button>
						</div>
						<!-- 비동기 실패시 노출되는 섹션 -->
						<div async_section="error" style="display: none;">
							<div class="reviewListEmpty">상품리뷰가 없습니다.</div>
						</div>
					</div>
					<script type="text/javascript"
						src="//polyfill.io/v3/polyfill.min.js?features=Promise"
						charset="utf-8"></script>

					<script type="text/javascript"
						src="https://smartreview-004.cafe24.com/optimizer.php?filename=50b3e387832593287a082acc0ab256d965cc7579_1644015366&amp;type=js&amp;"></script>
					<script type="text/javascript">
setTimeout(function() {
MSA_REVIEWTALKTALK.COMMON.setNameSpace('MSA_REVIEWTALKTALK.FRONT.SNS');
if ($.isEmptyObject(MSA_REVIEWTALKTALK.FRONT.SNS) === true) {
MSA_REVIEWTALKTALK.FRONT.SNS = new MSA_REVIEWTALKTALK.DISP_SNS({
sData : {
"sShareHashTag": "",
"sDecryptedState": "0c7f12682c51e7578354e827dbdbdc5d17bd773f94738fceb77d433f57fb3f160b19f2496599686397a9d76a84577591aedbc3362f83feb0a3530e3871cce893e5060c0a670cfda34a1daa1961d53c1272eeaa5e71ef662bf19b62b426c174014cec145c497c2dc4a4f8896e867eef053c6861ee6ee9eea06f751786c491aefc",
"sCallbackUrl": "https:\/\/paperbag.co.kr\/board\/smartreview\/sns_popup.html",
"sOptionSnsPopupUrl": "\/board\/smartreview\/sns_popup.html",
"SNS_KAKAOSTORY_CLIENT_ID": "4403c23f4aaf3824421a00a203d3199b",
"SNS_FACEBOOK_CLIENT_ID": "136073660210615"
}
})
$('.ec-board-list-items-data').append('');
}
}, 2500);
setTimeout(function() {
MSA_REVIEWTALKTALK.COMMON.setNameSpace('MSA_REVIEWTALKTALK.FRONT.LIST.smartreview_dispList_m1');
MSA_REVIEWTALKTALK.FRONT.LIST.smartreview_dispList_m1 = new MSA_REVIEWTALKTALK.DISP_LIST({
sAppKey : 'smartreview_dispList_m1',
sData : {
"iProductCategoryNo": null,
"iReviewArticleCount": 91,
"iReviewListPageCount": 10,
"iLimitReviewListPageCount": 1000,
"iListCountPerPage": 10,
"oAddingItemsConfig": [],
"oProductCategory": [],
"iProductNo": 34,
"sHashtag": null,
"sWriterId": null,
"sMoreViewType": "button",
"sOriginalMoreViewType": "button",
"sUseRatingDisplay": "T",
"sListType": "gallery",
"sIsPhotoOnly": "F",
"iPage": 1,
"sSortOrder": "recent",
"sSearchType": null,
"sSearchKeyword": null,
"iSearchedKeywordPeriod": 0,
"bAbuseOvercount": false,
"sWritePermissionType": "member",
"sMallVersion": false,
"sResponsiveDisplay": false,
"sSquareType": "gallery"
}
});
}, 2500);

</script>
					<link rel="stylesheet" type="text/css"
						href="https://smartreview-004.cafe24.com/optimizer.php?filename=1d7bcfb7d39b7177556a28bf91e657b0faa9620f_1644001212&amp;type=css&amp;">

					<!-- 비동기로 전달할 템플릿 영역(반드시 포함이 되어있어야함) -->
					<div class="ec-board-list-items-template notranslate"
						async_module="smartreview_dispListItems" async_type="template"
						style="display: none;">
						<ul async_section="after" style="display: none;">
							<!--
    참고 : 이 페이지는 리뷰 아이템입니다
    사용되는 페이지들 : 상품상세 리뷰 목록, 해시태그 모아보기, 작성자글 모아보기, 리뷰 목록
-->
							<li class="grid ec-board-list-item notranslate"
								data-bulletin-no="{$*bulletin_no}" style="display: none;">
								<div class="reviewInfo">
									<div
										class="reviewImg {$*display_bulletin_thumbnail_visible_class}">
										<a href="#none" class="reviewThumb ec-board-list-review-read">{$*display_bulletin_thumbnail_url}</a>
										<div class="gradeLayer" title="{$*rating}">
											<div class="ec-board-grade ec-board-star medium">
												{$*display_bulletin_rating_medium_tpl}</div>
											<div class="gradeBg"></div>
										</div>
									</div>
									<div
										class="prdOption typeSimple {$*product_option_info_display} {$*product_option_info_visible_display}">
										<p class="normal {$*normal_product_info_display}">
											<span class="option">{$*display_product_option_info}</span>
										</p>
										<ul class="set {$*set_product_info_display}">
											{$*display_product_set_info}
										</ul>
									</div>
									<span class="icon {$*display_best_icon_visible_class}">{$*display_best_icon_url}</span>
									<span class="icon {$*display_mobile_icon_visible_class}">{$*display_mobile_icon_url}</span>
									<span class="icon {$*display_new_icon_visible_class}">{$*display_new_icon_url}</span>
									<a href="#none" class="summary ec-board-list-review-read">
										<strong class="heading">{$*display_subject_long}</strong> <span
										class="info">
											{$*display_group_icon}{$*display_nick_icon} <strong>{$*display_writer}</strong>
											<span class="date">{$*display_writen_date}</span>
									</span>
									</a>
									<div class="community">
										<a href="#none"
											class="comment ec-board-list-review-read {$*display_comment_visible_class} {$*display_comment_visible_underline_class}">댓글
											<strong class="count ec-board-comment-count">{$*comment_cnt}</strong>
										</a>
										<div class="social">
											<button type="button"
												class="btnLike {$*display_like_selected} ec-board-list-sns-share-button-{$*bulletin_no}">좋아요</button>
											<button type="button"
												class="btnShare {$*display_sns_share_visible_class}">공유하기</button>
											<div class="shareLayer">
												<ul>
													<li class="{$*sns_share_facebook_display}"><img
														src="//img.echosting.cafe24.com/skin/base/board/review/ico_facebook.gif"
														alt="페이스북"> &nbsp;<a href="#none"
														data-sns-share="facebook">페이스북</a></li>
													<li><img
														src="//img.echosting.cafe24.com/skin/base/board/review/ico_kakao_story.gif"
														alt="카카오스토리"> &nbsp;<a href="#none"
														data-sns-share="kakaostory">카카오스토리</a></li>
													<li class="{$*display_sns_share_instagram_class}"><img
														src="//img.echosting.cafe24.com/skin/base/board/review/ico_instagram.gif"
														alt="인스타그램"> &nbsp;<a href="#none"
														data-sns-share="instagram">인스타그램</a></li>
												</ul>
												<span class="edge"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="prdInfo {$*display_product_info_visible_class}">
									<p class="reviewThumb">
										<a href="/product/detail.html?product_no=%7B%24*prd_no%7D">{$*display_product_image_tag}</a>
									</p>
									<div class="summary">
										<a href="/product/detail.html?product_no=%7B%24*prd_no%7D"
											class="heading"><strong>{$*product_name|cut:15,...}</strong></a>
										<div
											class="prdOption typeSimple {$*product_option_info_display}">
											<p class="normal {$*normal_product_info_display}">
												<span class="option">{$*display_product_option_info}</span>
											</p>
											<ul class="set {$*set_product_info_display}">
												{$*display_product_set_info}
											</ul>
										</div>
										<div class="info">
											<dl class="{$*display_rating_visible_class}">
												<dt>평점</dt>
												<dd>{$*display_product_info_rating_avg}</dd>
											</dl>
											<dl>
												<dt>리뷰</dt>
												<dd>{$*display_product_info_review_count}</dd>
											</dl>
										</div>
									</div>
								</div>
							</li>
							<li class="grid ec-board-list-item notranslate"
								data-bulletin-no="{$*bulletin_no}" style="display: none;">
								<div class="reviewInfo">
									<div
										class="reviewImg {$*display_bulletin_thumbnail_visible_class}">
										<a href="#none" class="reviewThumb ec-board-list-review-read">{$*display_bulletin_thumbnail_url}</a>
										<div class="gradeLayer" title="{$*rating}">
											<div class="ec-board-grade ec-board-star medium">
												{$*display_bulletin_rating_medium_tpl}</div>
											<div class="gradeBg"></div>
										</div>
									</div>
									<div
										class="prdOption typeSimple {$*product_option_info_display} {$*product_option_info_visible_display}">
										<p class="normal {$*normal_product_info_display}">
											<span class="option">{$*display_product_option_info}</span>
										</p>
										<ul class="set {$*set_product_info_display}">
											{$*display_product_set_info}
										</ul>
									</div>
									<span class="icon {$*display_best_icon_visible_class}">{$*display_best_icon_url}</span>
									<span class="icon {$*display_mobile_icon_visible_class}">{$*display_mobile_icon_url}</span>
									<span class="icon {$*display_new_icon_visible_class}">{$*display_new_icon_url}</span>
									<a href="#none" class="summary ec-board-list-review-read">
										<strong class="heading">{$*display_subject_long}</strong> <span
										class="info">
											{$*display_group_icon}{$*display_nick_icon} <strong>{$*display_writer}</strong>
											<span class="date">{$*display_writen_date}</span>
									</span>
									</a>
									<div class="community">
										<a href="#none"
											class="comment ec-board-list-review-read {$*display_comment_visible_class} {$*display_comment_visible_underline_class}">댓글
											<strong class="count ec-board-comment-count">{$*comment_cnt}</strong>
										</a>
										<div class="social">
											<button type="button"
												class="btnLike {$*display_like_selected} ec-board-list-sns-share-button-{$*bulletin_no}">좋아요</button>
											<button type="button"
												class="btnShare {$*display_sns_share_visible_class}">공유하기</button>
											<div class="shareLayer">
												<ul>
													<li class="{$*sns_share_facebook_display}"><img
														src="//img.echosting.cafe24.com/skin/base/board/review/ico_facebook.gif"
														alt="페이스북"> &nbsp;<a href="#none"
														data-sns-share="facebook">페이스북</a></li>
													<li><img
														src="//img.echosting.cafe24.com/skin/base/board/review/ico_kakao_story.gif"
														alt="카카오스토리"> &nbsp;<a href="#none"
														data-sns-share="kakaostory">카카오스토리</a></li>
													<li class="{$*display_sns_share_instagram_class}"><img
														src="//img.echosting.cafe24.com/skin/base/board/review/ico_instagram.gif"
														alt="인스타그램"> &nbsp;<a href="#none"
														data-sns-share="instagram">인스타그램</a></li>
												</ul>
												<span class="edge"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="prdInfo {$*display_product_info_visible_class}">
									<p class="reviewThumb">
										<a href="/product/detail.html?product_no=%7B%24*prd_no%7D">{$*display_product_image_tag}</a>
									</p>
									<div class="summary">
										<a href="/product/detail.html?product_no=%7B%24*prd_no%7D"
											class="heading"><strong>{$*product_name|cut:15,...}</strong></a>
										<div
											class="prdOption typeSimple {$*product_option_info_display}">
											<p class="normal {$*normal_product_info_display}">
												<span class="option">{$*display_product_option_info}</span>
											</p>
											<ul class="set {$*set_product_info_display}">
												{$*display_product_set_info}
											</ul>
										</div>
										<div class="info">
											<dl class="{$*display_rating_visible_class}">
												<dt>평점</dt>
												<dd>{$*display_product_info_rating_avg}</dd>
											</dl>
											<dl>
												<dt>리뷰</dt>
												<dd>{$*display_product_info_review_count}</dd>
											</dl>
										</div>
									</div>
								</div>
							</li>
						</ul>
					</div>
				</div>
				<!-- 리뷰톡톡 -->
			</div>
			<!-- //구매후기 -->
			<div id="prdDetail" class="ec-base-tab typeLight ">
				<a name="prdDetailAnchor" class="anchor"></a>
				<div class="menu-wrap">
					<ul class="menu">
						<li class="selected"><a href="#prdDetailAnchor">상세정보</a></li>
						<li><a href="#prdInfoAnchor">구매안내</a></li>
						<li><a href="#useReviewAnchor">사용후기 (<span
								class="count reviewtalk_count_display_91"><span
									class="reviewtalk_review_count" data-product-no="34"
									data-format="REVIEWTALKCOUNT">91</span></span>)
						</a></li>
						<li><a href="#prdQnAAnchor">상품Q&amp;A (<span
								class="count">6</span>)
						</a></li>
						<!-- <li><a href="#prdRelation">관련상품</a></li> -->
					</ul>
				</div>
				<div class="cont">
					<div style="text-align: center;">
						<div
							style="text-align: center !important; max-width: 750px; margin: 0 auto;">

							<!-- 판매돌파-->
							<img
								src="/web/upload/editor/2021/promotion/top_number_shake_0728.jpg"><br>
							<img
								src="/web/upload/editor/2021/yakson2/top_number_yakson_0728.jpg"><br>



							<!--시딩 -->
							<img
								src="/web/upload/editor/2021/cleansing/top_cleansing_0701_01.jpg"><br>
							<img
								src="/web/upload/editor/2021/cleansing/top_cleansing_0701_02.gif"><br>
							<!--<img src="/web/upload/editor/2021/cleansing/top_cleansing_0701_03.gif"><br /> -->


							<!--상시 가격 -->
							<img
								src="/web/upload/editor/2021/cleansing/cheating_topmain_0802.jpg"><br>
							<img
								src="/web/upload/editor/2021/cleansing/cheating_price_0802.jpg"><br>

							<!--프모 가격 -->
							<!--<img src="/web/upload/editor/2021/cleansing/cleansing_topmain_0805.jpg"><br />-->
							<!--<img src="/web/upload/editor/2021/cleansing/cheating_price_0805.jpg"><br />-->


							<!-- 구성보기 -->
							<img
								src="/web/upload/editor/2021/cleansing/cheating_link_0802.jpg"><br>

							<a
								href="https://www.paperbag.co.kr/product/detail.html?product_no=19&amp;cate_no=29&amp;display_group=1"
								target="_blank" border="0"> <img
								src="/web/upload/editor/2021/cleansing/cleansing_link_002.jpg"><br></a>

							<a
								href="https://www.paperbag.co.kr/product/detail.html?product_no=26&amp;cate_no=29&amp;display_group=1"
								target="_blank" border="0"> <img
								src="/web/upload/editor/2021/cleansing/cleansing_link_003.jpg"><br></a>

							<a
								href="https://www.paperbag.co.kr/product/detail.html?product_no=29&amp;cate_no=1&amp;display_group=2"
								target="_blank" border="0"> <img
								src="/web/upload/editor/2021/cleansing/cleansing_link_004.jpg"><br></a>

							<a
								href="https://www.paperbag.co.kr/product/detail.html?product_no=30&amp;cate_no=29&amp;display_group=1"
								target="_blank" border="0"> <img
								src="/web/upload/editor/2021/cleansing/cleansing_link_005.jpg"><br></a>

							<!-- 치팅식단-->
							<img
								src="/web/upload/editor/2021/cleansing/cheating_menu_0802_1.jpg"><br>


							<!-- 요약상세-->
							<img src="/web/upload/editor/2021/cleansing/cleansing_1_01.jpg"><br>
							<img src="/web/upload/editor/2021/cleansing/cleansing_1_02.jpg"><br>
							<img src="/web/upload/editor/2021/cleansing/cleansing_1_03.gif"><br>
							<img src="/web/upload/editor/2021/cleansing/cleansing_1_04.jpg"><br>
							<img src="/web/upload/editor/2021/cleansing/cleansing_1_005.jpg"><br>

							<img src="/web/upload/editor/2021/cleansing/cleansing_2_001.jpg"><br>
							<img src="/web/upload/editor/2021/cleansing/cleansing_2_002.jpg"><br>
							<img src="/web/upload/editor/2021/yakson/yakson_page1_04.gif"><br>
							<img src="/web/upload/editor/2021/yakson2/plum2_page1_03_.jpg"><br>
							<img src="/web/upload/editor/2021/yakson2/plum2_page1_04.jpg"><br>
							<img src="/web/upload/editor/2021/yakson2/plum2_page1_05_.jpg"><br>
							<img src="/web/upload/editor/2021/yakson/yakson_page1_11.gif"><br>
							<img src="/web/upload/editor/2021/yakson2/plum2_page1_07.jpg"><br>
							<img src="/web/upload/editor/2021/yakson2/plum2_page2_01.jpg"><br>
							<img src="/web/upload/editor/2021/yakson2/plum2_page2_02.jpg"><br>
							<img src="/web/upload/editor/2021/yakson2/plum2_page2_03.jpg"><br>
							<img src="/web/upload/editor/2021/yakson2/plum2_page2_04.jpg"><br>
							<img src="/web/upload/editor/2021/yakson2/plum2_page2_05.jpg">
						</div>
					</div>
				</div>
			</div>
			<!-- //상품상세정보 -->
			<!-- 관련상품 -->
			<div id="prdRelation" class="ec-base-tab typeLight ">
				<!-- <div class="menu-wrap">
			<ul class="menu">
				<li><a href="#prdDetailAnchor">상세정보</a></li>
				<li><a href="#prdInfoAnchor">구매안내</a></li>
				<li><a href="#useReviewAnchor">사용후기 (<span class="count">0</span>)</a></li>
				<li><a href="#prdQnAAnchor">상품Q&amp;A (<span class="count">6</span>)</a></li>
				<li class="selected"><a href="#prdRelation">관련상품</a></li>
			</ul>
		</div> -->
				<div class="cont"></div>
			</div>
			<!-- //관련상품-->
			<!-- 상품구매안내 -->
			<div id="prdInfo" class="ec-base-tab typeLight prdInfoDetail ">
				<a name="prdInfoAnchor" class="anchor"></a>
				<div class="menu-wrap">
					<ul class="menu">
						<li><a href="#prdDetailAnchor">상세정보</a></li>
						<li class="selected"><a href="#prdInfoAnchor">구매안내</a></li>
						<li><a href="#useReviewAnchor">사용후기 (<span
								class="count reviewtalk_count_display_91"><span
									class="reviewtalk_review_count" data-product-no="34"
									data-format="REVIEWTALKCOUNT">91</span></span>)
						</a></li>
						<li><a href="#prdQnAAnchor">상품Q&amp;A (<span
								class="count">6</span>)
						</a></li>
						<!-- <li><a href="#prdRelation">관련상품</a></li> -->
					</ul>
				</div>
				<div class="prdInfoDetail">
					<div class="cont">
						<h3>상품결제정보</h3>
						고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다. 확인과정에서 도난 카드의 사용이나 타인 명의의
						주문등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다. &nbsp; <br>
						<br> 무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면
						됩니다. &nbsp;<br> 주문시 입력한&nbsp;입금자명과 실제입금자의 성명이 반드시 일치하여야 하며,
						7일 이내로 입금을 하셔야 하며&nbsp;입금되지 않은 주문은 자동취소 됩니다. <br>
					</div>
					<div class="cont">
						<h3>배송정보</h3>
						- 산간벽지나 도서지방은 별도의 추가금액을 지불하셔야 하는 경우가 있습니다.<br> 고객님께서 주문하신 상품은
						입금 확인후 배송해 드립니다. 다만, 상품종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.<br>
						<!-- <ul class="delivery">
					<li>배송 방법 : 택배</li>
					<li>배송 지역 : 전국지역</li>
					<li>배송 비용 : &#8361;3,000</li>
					<li>배송 기간 : 3일 ~ 7일</li>
					<li>배송 안내 : - 산간벽지나 도서지방은 별도의 추가금액을 지불하셔야 하는 경우가 있습니다.<br>
    고객님께서 주문하신 상품은 입금 확인후 배송해 드립니다. 다만, 상품종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.<br>
</li>
				</ul> -->
					</div>
					<div class="cont">
						<h3>교환 및 반품정보</h3>
						<b>교환 및 반품 주소</b><br>- <b><br>
						<br>교환 및 반품이 가능한 경우</b><br> - 상품을 공급 받으신 날로부터 7일이내 단, 가전제품의<br>
						&nbsp;&nbsp;경우 포장을 개봉하였거나 포장이 훼손되어 상품가치가 상실된 경우에는 교환/반품이 불가능합니다.<br>
						- 공급받으신 상품 및 용역의 내용이 표시.광고 내용과<br> &nbsp;&nbsp;다르거나 다르게 이행된
						경우에는 공급받은 날로부터 3월이내, 그사실을 알게 된 날로부터 30일이내<br> <br> <b>교환
							및 반품이 불가능한 경우</b><br> - 고객님의 책임 있는 사유로 상품등이 멸실 또는 훼손된 경우. 단, 상품의
						내용을 확인하기 위하여<br> &nbsp;&nbsp;포장 등을 훼손한 경우는 제외<br> - 포장을
						개봉하였거나 포장이 훼손되어 상품가치가 상실된 경우<br> &nbsp;&nbsp;(예 : 가전제품, 식품,
						음반 등, 단 액정화면이 부착된 노트북, LCD모니터, 디지털 카메라 등의 불량화소에<br>
						&nbsp;&nbsp;따른 반품/교환은 제조사 기준에 따릅니다.)<br> - 고객님의 사용 또는 일부 소비에
						의하여 상품의 가치가 현저히 감소한 경우 단, 화장품등의 경우 시용제품을 <br> &nbsp;&nbsp;제공한
						경우에 한 합니다.<br> - 시간의 경과에 의하여 재판매가 곤란할 정도로 상품등의 가치가 현저히 감소한 경우<br>
						- 복제가 가능한 상품등의 포장을 훼손한 경우<br> &nbsp;&nbsp;(자세한 내용은 고객만족센터 1:1
						E-MAIL상담을 이용해 주시기 바랍니다.)<br> <br> ※ 고객님의 마음이 바뀌어 교환, 반품을
						하실 경우 상품반송 비용은 고객님께서 부담하셔야 합니다.<br> &nbsp;&nbsp;(색상 교환, 사이즈
						교환 등 포함)<br>
					</div>
					<div class="cont">
						<h3>서비스문의</h3>
					</div>
				</div>
			</div>
			<!-- //상품구매안내 -->
			<!--기존 후기 위치-->
			<!-- 상품 Q&A -->
			<div id="prdQnA" class="ec-base-tab typeLight ">
				<a name="prdQnAAnchor" class="anchor"></a>
				<div class="menu-wrap">
					<ul class="menu">
						<li><a href="#prdDetailAnchor">상세정보</a></li>
						<li><a href="#prdInfoAnchor">구매안내</a></li>
						<li><a href="#useReviewAnchor">사용후기 (<span
								class="count reviewtalk_count_display_91"><span
									class="reviewtalk_review_count" data-product-no="34"
									data-format="REVIEWTALKCOUNT">91</span></span>)
						</a></li>
						<li class="selected"><a href="#prdQnAAnchor">상품Q&amp;A (<span
								class="count">6</span>)
						</a></li>
						<!-- <li><a href="#prdRelation">관련상품</a></li> -->
					</ul>
				</div>

				<div class="board">
					<div class="xans-element- xans-product xans-product-qna">
						<a name="use_qna"></a>
						<p class="noAccess displaynone">글읽기 권한이 없습니다.</p>
						<div class="minor displaynone">
							<p>
								<img
									src="http://img.echosting.cafe24.com/skin/base_ko_KR/product/ico_under19.gif"
									alt=""> &nbsp;<strong>"19세 미만의 미성년자"</strong>는 출입을 금합니다!
							</p>
							<p class="button">
								<a href="/intro/board.html"><img
									src="http://img.echosting.cafe24.com/skin/base_ko_KR/product/btn_adult_certification.gif"
									alt="성인인증 하기"></a>
							</p>
						</div>
						<div class="ec-base-table typeList">
							<table border="0" summary="" class="">
								<caption>상품 Q&amp;A</caption>
								<colgroup>
									<col style="width: 40px">
									<col style="width: auto">
									<col style="width: 120px;">
									<col style="width: 100px;">
								</colgroup>
								<!-- <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">카테고리</th>
                                <th scope="col">제목</th>
                                <th scope="col">작성자</th>
                                <th scope="col">작성일</th>
                                <th scope="col">조회</th>
                            </tr>
                        </thead> -->
								<tbody align="center">
									<tr class="xans-record-">
										<td><b>Q.</b></td>
										<td class="subject left txtBreak"><img
											src="http://img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_lock.gif"
											alt="비밀글" class="ec-common-rwd-image"> <a
											href="/product/provider/review_read.xml?no=11189&amp;board_no=6&amp;spread_flag=T">문의드립니다.</a>
											<img
											src="http://img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_new.gif"
											alt="NEW" class="ec-common-rwd-image"><span
											class="txtWarn"></span></td>
										<td>.****</td>
										<td class="txtInfo txt11">2022-02-04</td>
									</tr>
									<tr class="xans-record-">
										<td><b>Q.</b></td>
										<td class="subject left txtBreak">&nbsp;&nbsp;&nbsp;<img
											src="http://img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_re.gif"
											alt="답변" class="ec-common-rwd-image"> <img
											src="http://img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_lock.gif"
											alt="비밀글" class="ec-common-rwd-image"> <a
											href="/product/provider/review_read.xml?no=11194&amp;board_no=6&amp;spread_flag=T">문의드립니다.</a>
											<img
											src="http://img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_new.gif"
											alt="NEW" class="ec-common-rwd-image"><span
											class="txtWarn"></span>
										</td>
										<td></td>
										<td class="txtInfo txt11">2022-02-04</td>
									</tr>
									<tr class="xans-record-">
										<td><b>Q.</b></td>
										<td class="subject left txtBreak"><img
											src="http://img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_lock.gif"
											alt="비밀글" class="ec-common-rwd-image"> <a
											href="/product/provider/review_read.xml?no=11175&amp;board_no=6&amp;spread_flag=T">문의드립니다.</a>
											<span class="txtWarn"></span></td>
										<td>이****</td>
										<td class="txtInfo txt11">2022-02-04</td>
									</tr>
									<tr class="xans-record-">
										<td><b>Q.</b></td>
										<td class="subject left txtBreak">&nbsp;&nbsp;&nbsp;<img
											src="http://img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_re.gif"
											alt="답변" class="ec-common-rwd-image"> <img
											src="http://img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_lock.gif"
											alt="비밀글" class="ec-common-rwd-image"> <a
											href="/product/provider/review_read.xml?no=11182&amp;board_no=6&amp;spread_flag=T">문의드립니다.</a>
											<img
											src="http://img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_new.gif"
											alt="NEW" class="ec-common-rwd-image"><span
											class="txtWarn"></span>
										</td>
										<td></td>
										<td class="txtInfo txt11">2022-02-04</td>
									</tr>
									<tr class="xans-record-">
										<td><b>Q.</b></td>
										<td class="subject left txtBreak"><img
											src="http://img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_lock.gif"
											alt="비밀글" class="ec-common-rwd-image"> <a
											href="/product/provider/review_read.xml?no=7372&amp;board_no=6&amp;spread_flag=T">문의드립니다.</a>
											<span class="txtWarn"></span></td>
										<td>.****</td>
										<td class="txtInfo txt11">2021-09-23</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>

					<p class="ec-base-button ">
						<span class="gRight"> <a
							href="/board/product/list.html?board_no=6"
							class="btnNormalFix sizeS">모두 전체보기</a> <a
							href="/board/product/write.html?board_no=6&amp;product_no=34&amp;cate_no=1&amp;display_group=2"
							class="btnSubmitFix sizeS">문의하기</a>
						</span>
					</p>

					<div
						class="xans-element- xans-product xans-product-qnapaging ec-base-paginate typeSub">
						<a href="#none" class="first"><img
							src="/_wp/img/btn_page_first2.jpg" alt="첫 페이지"></a> <a
							href="#none"><img src="/_wp/img/btn_page_prev2.jpg"
							alt="이전 페이지"></a>
						<ol>
							<li class="xans-record-"><a
								href="?product_no=34&amp;cate_no=1&amp;display_group=2&amp;page_6=1#use_qna"
								class="this">1</a></li>
							<li class="xans-record-"><a
								href="?product_no=34&amp;cate_no=1&amp;display_group=2&amp;page_6=2#use_qna"
								class="other">2</a></li>
						</ol>
						<a
							href="?product_no=34&amp;cate_no=1&amp;display_group=2&amp;page_6=2#use_qna"><img
							src="/_wp/img/btn_page_next2.jpg" alt="다음 페이지"></a> <a
							href="?product_no=34&amp;cate_no=1&amp;display_group=2&amp;page_6=2#use_qna"
							class="last"><img src="/_wp/img/btn_page_last2.jpg"
							alt="마지막 페이지"></a>
					</div>
				</div>
			</div>
			<!-- //상품Q&A -->
		</div>
		<script type="text/javascript">
(function(w, d, a){
    w.__beusablerumclient__ = {
        load : function(src){
            var b = d.createElement("script");
            b.src = src; b.async=true; b.type = "text/javascript";
            d.getElementsByTagName("head")[0].appendChild(b);
        }
    };w.__beusablerumclient__.load(a);
})(window, document, "//rum.beusable.net/script/b210108e142747u734/b9acf7913f");
</script>


		<!-- Enliple Tracker Start -->
		<script type="text/javascript">
    (function(a,g,e,n,t){a.enp=a.enp||function(){(a.enp.q=a.enp.q||[]).push(arguments)};n=g.createElement(e);n.async=!0;n.defer=!0;n.src="https://cdn.megadata.co.kr/dist/prod/enp_tracker_cafe24_smart.min.js";t=g.getElementsByTagName(e)[0];t.parentNode.insertBefore(n,t)})(window,document,"script");
    enp('create', 'collect', 'paperbag', { device: 'W' });
    enp('create', 'cart', 'paperbag', { device: 'W' });
    enp('create', 'wish', 'paperbag', { device: 'W' });
    enp('create', 'conversion', 'paperbag', { device: 'W', paySys: 'naverPay' });
</script>
		<!-- Enliple Tracker End -->

		<script type="text/javascript">
(function(w, d, a){
    w.__beusablerumclient__ = {
        load : function(src){
            var b = d.createElement("script");
            b.src = src; b.async=true; b.type = "text/javascript";
            d.getElementsByTagName("head")[0].appendChild(b);
        }
    };w.__beusablerumclient__.load(a);
})(window, document, "//rum.beusable.net/script/b210127e133734u874/d06a5cf272");
</script>


	</div>
</div>