<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="xyz.itwill.dao.ItemDAO"%>
<%@page import="xyz.itwill.dto.ItemDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" type="text/css" href="css/itemDetail.css">

<%
	if(request.getParameter("code")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;	
	}
	
	int code = Integer.parseInt(request.getParameter("code"));
	
	ItemDTO item=ItemDAO.getDAO().selectNumItem(code);

	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	if(loginMember==null) {
		
		String requestURI=request.getRequestURI();
		System.out.println("requestURI = "+requestURI);
		
		String queryString=request.getQueryString();
		
		System.out.println("queryString = "+queryString);
		
		if(queryString==null || queryString.equals("")) {
			queryString="";	
		} else {
			queryString="?"+queryString;
		}
		session.setAttribute("url", requestURI+queryString);
		
	}
	
%>
<body onload="init();">
<script type="text/javascript">
	var sell_price;
	var amount;
	function priceToString(price) {
	    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}
	
	function init () {
		sell_price = document.form.sell_price.value;
		amount = document.form.amount.value;
		document.form.sum.value = sell_price;
		change();
	}
	
	function add () {
		hm = document.form.amount;
		sum = document.form.sum;
		hm.value ++ ;
	
		sum.value = '₩'+priceToString(parseInt(hm.value) * sell_price);
		document.getElementById("result").innerText = sum.value;
		document.getElementById("count").innerText	= hm.value;
	}
	
	function del () {
		hm = document.form.amount;
		sum = document.form.sum;
			if (hm.value > 1) {
				hm.value -- ;
				sum.value ='₩'+priceToString(parseInt(hm.value) * sell_price);
				document.getElementById("result").innerText = sum.value;
			}
			
		document.getElementById("count").innerText	= hm.value;
	}
	
	
	function change () {
		hm = document.form.amount;
		sum = document.form.sum;
	
			if (hm.value < 0) {
				hm.value = 0;
			}
		sum.value = '₩'+ priceToString(parseInt(hm.value) * sell_price);
		document.getElementById("result").innerText = sum.value;
		document.getElementById("count").innerText	= hm.value;

	}  
	
	
</script>


    <div id="wrap">
        <div class="site-wrap">
            <div class="xans-element- xans-product xans-product-headcategory path ">
                <span>현재 위치</span>
                <ol>
                    <li><a href="/">홈</a></li>
                    <li class=""><a href="/category/제품구매/24/">제품구매</a></li>
                    <li class=""><a href="/category/쇼핑하기/29/">쇼핑하기</a></li>
                </ol>
            </div>
            <br><br>
            
            <div class="xans-element- xans-product xans-product-detail">
                <div class="detailArea">
                    <!-- 이미지 영역 -->
                    <div class="xans-element- xans-product xans-product-image imgArea ">
                        <div class="keyImg">
                            <div class="thumbnail">
                                <img src="<%=request.getContextPath()%>/site/item_image/<%=item.getItemMainImage()%>" height="600" width="600" alt="<%=item.getItemMainImage()%>" class="BigImage">
                            </div>
                        </div>
                    </div>
                    <!-- 상세정보 내역 -->
                    <div class="infoArea wp-detail-info">
                        <!-- 상품명 -->
                        <div class="headingArea ">
                            <h2><%=item.getItemNm() %></h2>
                        </div>
                        <!-- 할인율 -->
                        <div class="xans-element- xans-product xans-product-detaildesign wp-detail-info">
                            <!-- 메인 타이틀 이하 옵션 전까지  -->
                            <ul class=" product_name_css xans-record-">
                                <li class="w-title"><span style="font-size: 16px; color: #555555;"
                                        data-i18n="PRODUCT.PRD_INFO_PRODUCT_NAME">상품명</span></li>
                                <li class="w-cont"><span style="font-size: 16px; color: #555555;"><%=item.getItemNm() %></span>
                                </li>
                            </ul>
                            <ul class=" product_price_css xans-record-">
                                <li class="w-title"><span style="font-size: 18px; color: #000000; font-weight: bold;"
                                        data-i18n="PRODUCT.PRD_INFO_PRODUCT_PRICE">판매가</span></li>
                                <li class="w-cont"><span
                                        style="font-size: 18px; color: #000000; font-weight: bold;"><strong
                                            id="span_product_price_text">₩<%=DecimalFormat.getInstance().format(item.getItemPrice()) %>
                                            </strong><input id="product_price"
                                            name="product_price" value="" type="hidden"></span></li>
                            </ul>
                            <ul class=" delivery_css xans-record-">
                                <li class="w-title"><span style="font-size: 12px; color: #555555;"
                                        data-i18n="PRODUCT.PRD_INFO_DELIVERY">배송방법</span></li>
                                <li class="w-cont"><span style="font-size: 12px; color: #555555;">택배</span></li>
                            </ul>
                            <ul class=" delivery_price_css xans-record-">
                                <li class="w-title"><span style="font-size: 12px; color: #555555;"
                                        data-i18n="PRODUCT.PRD_INFO_DELIVERY_PRICE">배송비</span></li>
                                <li class="w-cont"><span style="font-size: 12px; color: #555555;"><span
                                            class="delv_price_B"><input id="delivery_cost_prepaid"
                                                name="delivery_cost_prepaid" value="P"
                                                type="hidden"><strong>₩5,000</strong>
                                            </span></span></li>
                            </ul>
                        </div>
                        <div id="option-box" class="option_layer ">
                            <div id="totalProducts" class="">
                              <form name="form" method="get">                                   
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
                                    <tbody class="option_products">
                                        <tr class="option_product ">
                                            <td style="color: #555555;">수량</td>
                                            <td width=""><span class="quantity"> 
                                           	   <input type=hidden name="sell_price" value="<%=item.getItemPrice() %>">
                                        	    <input id="quantity" name="amount" style="" value="1" type="text" onchange="change();">
                                        	    	 <a href="javascript:add()">
                                        	    	 	<img src="http://img.echosting.cafe24.com/skin/base_ko_KR/product/btn_count_up.gif" alt="수량증가" class="QuantityUp up">
                                        	    	 </a> 
                                        	    	 <a href="javascript:del()">
                                        	    	 	<img src="http://img.echosting.cafe24.com/skin/base_ko_KR/product/btn_count_down.gif" alt="수량감소" class="QuantityDown down">
                                        	    	 </a>
                                                </span>
                                           	</td>
                                         	   <td width="" class="right">
                                           		 <span class="quantity_price">
                                           		 	<input type="text" name="sum" size="6" readonly style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px; text-align:right;" >
                                           		 </span>
										
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                        	 </form>                                
                            </div>			
                            <div class="block">
                                <!-- //참고 -->
                                <div id="totalPrice" class="totalPrice">
                                    <strong>총 상품금액</strong>(수량) : <span class="total"><strong><em><span id="result"></span></em></strong>
                                        (<span id="count"></span>개)</span>
                                </div>
                                <div class="xans-element- xans-product xans-product-action ">
                                    <div class="ec-base-button gColumn">
<!--                                         <a href="#none" class="btnSubmit sizeL " onclick="check_action_nologin();"><span id="btnBuy">바로 구매</span></a> 
                                        <a href="#none" class="btnNormal sizeL " onclick="check_action_nologin();" id="btnAddToCart">장바구니</a> -->
                                        <button type="button" id="buyBtn" class="btnSubmit sizeL">바로 구매</button>
                                        <button type="button" id="cartBtn" class="btnNormal sizeL">장바구니</button>
                                    </div>
                                </div>
                            </div>
                        </div>                       
                    </div>
                </div>
            </div>
            <div class="xans-element- xans-product xans-product-additional">
                <!-- 상품상세정보 -->
                <!-- 구매후기 -->
                <div id="use_review" class="ec-base-tab typeLight ">
                    <a name="useReviewAnchor" class="anchor"></a>
                    <div class="menu-wrap">
                        <ul class="menu">
                            <li><a href="#prdDetail">상품상세정보</a></li>
                            <li><a href="#prdInfoAnchor">구매안내</a></li>
                            <li class="selected"><a href="#useReviewAnchor">사용후기
                                </a></li>
                            <li><a href="#prdQnA">상품문의
                                </a></li>
                            <!-- <li><a href="#prdRelation">관련상품</a></li> -->
                        </ul>
                        
                        <div>
                        	<jsp:include page="/site/review/review_item_list.jsp" />
                    	</div>
                    	
                    </div>
                </div>
                <!-- //구매후기 -->
                <div id="prdDetail" class="ec-base-tab typeLight ">
                    <a name="prdDetailAnchor" class="anchor"></a>
                    <div class="menu-wrap">
                        <ul class="menu">
                            <li class="selected"><a href="#prdDetailAnchor">상세정보</a></li>
                            <li><a href="#prdInfoAnchor">구매안내</a></li>
                            <li><a href="#useReviewAnchor">사용후기
                                </a></li>
                            <li><a href="#prdQnAAnchor">상품Q&amp;A
                                </a></li>
                        </ul>
                        <div class="cont">
						    <div style="text-align:center;">
						        <div style="text-align:center !important; max-width:750px; margin:0 auto;">
						            <img src="<%=request.getContextPath()%>/site/item_image/<%=item.getItemCttImage1()%>"><br>
						            <img src="<%=request.getContextPath()%>/site/item_image/<%=item.getItemCttImage2()%>"><br>
						            <img src="<%=request.getContextPath()%>/site/item_image/<%=item.getItemCttImage3()%>">
						        </div>
						    </div>
						</div>
                    </div>
                </div>
                <!-- //상품상세정보 -->
                <!-- 상품구매안내 -->
                <div id="prdInfo" class="ec-base-tab typeLight prdInfoDetail " style="display: block;">
                    <a name="prdInfoAnchor" class="anchor"></a>
                    <div class="menu-wrap">
                        <ul class="menu">
                            <li><a href="#prdDetailAnchor">상세정보</a></li>
                            <li class="selected"><a href="#prdInfoAnchor">구매안내</a></li>
                            <li><a href="#useReviewAnchor">사용후기
                                </a></li>
                            <li><a href="#prdQnAAnchor">상품Q&amp;A
                                </a></li>
                            <!-- <li><a href="#prdRelation">관련상품</a></li> -->
                        </ul>
                    </div>
                    <div class="prdInfoDetail" style="display: block;">
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
                        </div>
                        <div class="cont">
                            <h3>교환 및 반품정보</h3>
                            <b>교환 및 반품 주소</b><br>- <b><br> <br>교환 및 반품이 가능한
                                경우</b><br> - 상품을 공급 받으신 날로부터 7일이내 단, 가전제품의<br>
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
                    </div>
                </div>
                <div id="prdQnA" class="ec-base-tab typeLight ">
                    <a name="prdQnAAnchor" class="anchor"></a>
                    <div class="menu-wrap">
                        <ul class="menu">
                            <li><a href="#prdDetailAnchor">상세정보</a></li>
                            <li><a href="#prdInfoAnchor">구매안내</a></li>
                            <li><a href="#useReviewAnchor">사용후기
                                </a></li>
                            <li class="selected"><a href="#prdQnAAnchor">상품Q&amp;A
                                </a></li>
                        </ul>
                    </div>
                    <div>
                        <jsp:include page="/site/qa/qa_list.jsp" />
                    </div>
                </div>
            </div>
        </div>  
       <form id="itemForm" method="post">

	       <input type="hidden" name="buy_ItemCD" value="<%=item.getItemCd()%>">;
	       <input type="hidden" name="buy_ItemName" value="<%=item.getItemNm()%>">;
	       <input type="hidden" id="each" name="buy_ItemEach" value="">;
       </form>       
    </div>
</body> 
<script type="text/javascript">
$("#buyBtn").click(function(){
	
	var each =$("#quantity").val();
	$("#each").val(each);
	
	$("#itemForm").attr("action", "<%=request.getContextPath() %>/site/index.jsp?workgroup=order&work=order_item_join");
	$("#itemForm").submit();
})
$("#cartBtn").click(function(){
	var each =$("#quantity").val();
	$("#each").val(each);
	
	$("#itemForm").attr("action", "<%=request.getContextPath() %>/site/index.jsp?workgroup=cart&work=cart_check");
	$("#itemForm").submit();
})
</script>


