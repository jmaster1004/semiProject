<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="xyz.itwill.dao.cartDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dto.cartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%    
	request.setCharacterEncoding("UTF-8");
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	if(loginMember==null) {//비로그인 사용자인 경우
		//request.getRequestURI() : 클라이언트가 요청한 URI 주소를 반환하는 메소드
		//ex) http://localhost:8000/jsp/site/index.jsp?workgroup=cart&work=cart_list
		// => URI 주소 - http://localhost:8000/jsp/site/index.jsp
		// => request.getRequestURI() : /jsp/site/index.jsp
		String requestURI=request.getRequestURI();
		//System.out.println("requestURI = "+requestURI);
		
		//request.getQueryString() : 클라이언트가 요청한 URL 주소의 QueryString을 반환하는 메소드
		//ex) http://localhost:8000/jsp/site/index.jsp?workgroup=cart&work=cart_list
		// => request.getQueryString() : workgroup=cart&work=cart_list
		String queryString=request.getQueryString();
		//System.out.println("queryString = "+queryString);
		
		if(queryString==null || queryString.equals("")) {
			queryString="";	
		} else {
			queryString="?"+queryString;
		}
		
		//세션에 요청 페이지의 URL 주소를 저장
		session.setAttribute("url", requestURI+queryString);
		
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=member&work=login';");
		out.println("</script>");
		return;
	}
	
	
	String id = (String)loginMember.getMemberEmail();
	String[] cartNo = request.getParameterValues("checkNo");

	List<cartDTO> cartList = new ArrayList<cartDTO>();
	
	
	
	//String id2= id.substring(0, id.indexOf("@"));
	//String mail= id.substring(id.indexOf("@")+1);
	
	System.out.println(id);
	/*
	for(int i=0; i<(cartNo.length);i++) {
		cartList = cartDAO.getDAO().selectCart(cartNo[i], id);
		for(cartDTO cart: cartList){
						
		}
	}
	*/
%>


<form name="order_joinForm" id="order_joinForm" action="<%=request.getContextPath() %>/site/index.jsp?workgroup=order&work=order_insert_action" method="post">
	
	<input type="hidden" id="phone" name ="phone" value="">
	<input type="hidden" id="memo" name ="memo" value="">
	<input type="hidden" id="email" name ="email" value="">



    <header id="header">
        <!-- app tag -->
        <div id="ec-orderform-header-head"></div>

        <div class="header">
            <h1 class="xans-element- xans-layout xans-layout-logotop "><a href="/index.html">bag&amp;bag</a>
            </h1>
            <div class="headerMenu gLeft">
                <span class="xans-element- xans-layout xans-layout-mobileaction btnBack "><a href="#none" onclick="document.referrer ? history.go(-1) : location.href='/';return false;">뒤로가기</a>
                </span>
            </div>
            <div class="headerMenu gRight">
                <span class="xans-element- xans-layout xans-layout-orderbasketcount btnBasket "><a href="/order/basket.html">장바구니<span class="count EC-Layout_Basket-count-display"></span></a>
                </span>
                <a href="/myshop/index.html" class="xans-element- xans-layout xans-layout-statelogon btnMy ">마이쇼핑
                </a>
            </div>
        </div>
        <div class="titleArea">
            <h1>주문/결제</h1>
        </div>
    </header>

    <div id="mCafe24Order" class="xans-element- xans-order xans-order-form typeHeader xans-record-">
        <div class="billingNshipping">
            <!-- 주문자정보 -->
            <div id="ec-jigsaw-area-billingInfo" class="ec-base-fold eToggle displaynone">
                <div id="ec-jigsaw-title-billingInfo" class="title">
                    <h2>주문 정보</h2>
                    
                </div>
            </div>
            <!-- 배송정보  -->
            <!-- 수령자 정보   -->
            <div id="ec-jigsaw-area-shippingInfo" class="ec-base-fold eToggle selected">
                <div id="ec-jigsaw-title-shippingInfo" class="title">
                    <h2>배송지</h2>
                </div>
                <div class="contents">
                    <!-- 국내배송 정보 -->
                    <div class="">
                        <div id="ec-jigsaw-tab-shippingInfo" class="ec-base-tab displaynone">
                            <ul>
                                <li id="ec-jigsaw-tab-shippingInfo-newAddress" class="selected"><a href="#none">직접입력</a></li>
                            </ul>
                        </div>

                        <!-- 새 배송지 -->
                        <div id="ec-shippingInfo-newAddress" class="tabCont newShipArea ">
                            <div class="segment ec-shippingInfo-sameaddr ">
                                <input id="sameaddr" name="sameaddr" fw-filter="" fw-label="1" fw-msg="" value="M" type="radio" ><label for="sameaddr0" >회원 정보와 동일</label>
                                <input id="sameaddr1" name="sameaddr" fw-filter="" fw-label="1" fw-msg="" value="F" type="radio" checked="checked"><label for="sameaddr1">새로운 배송지</label> </div>
                            <div class="ec-base-table typeWrite">
                                <table border="1">
                                    <caption>배송 정보 입력</caption>
                                    <colgroup>
                                        <col style="width:102px">
                                        <col style="width:auto">
                                    </colgroup>
                                    <tbody>
                                        <tr class="ec-shippingInfo-newAddress-name">
                                            <th scope="row">받는사람 <span class="icoRequired">필수</span>
                                            </th>
	                                        <td>
	                                        	<input id="rname" name="rname" class="inputTypeText" placeholder="이름을 입력하세요" size="15" value="" type="text">
	                                            <div id="nameMsg" class="error">이름을 입력해 주세요.</div>
	                                            <div id="nameRegMsg" class="error">이름은 한글로만 작성 가능합니다.</div>
                                            </td>
                                        </tr>
                                        <tr id="ec-receiver-address">
                                            <th scope="row">주소 <span class=""><span class="icoRequired">필수</span></span>  
                                            </th>
                                            <td>
	                                            <input type="text" name="zipCode" id="sample3_postcode" placeholder="우편번호" style= "width: auto; height: auto; margin-bottom:5px;">
												<input type="button" onclick="sample3_execDaumPostcode()" value="우편번호 찾기"    style= "margin-bottom: 5px; padding: 5px;"><br>
												<input type="text" name="address" id="sample3_address" placeholder="주소" style= "width: 75%; height: auto; margin-bottom:5px;"><br>
												<input type="text" name="detailAddress" id="sample3_detailAddress" placeholder="상세주소" style= "width: 40%; height: auto;">
												<input type="text" id="sample3_extraAddress" placeholder="참고항목" style= "width: 30%; height: auto;">
												<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
												<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
												</div>
											</td>
                           
                                        </tr>
                                        
                                        <tr class="ec-shippingInfo-receiverCell ">
                                            <th scope="row">휴대전화 <span class=""><span class="icoRequired">필수</span></span>
                                            </th>
                                            <td><select id="rphone2_1" name="phone2" >
                                                    <option value="010">010</option>
                                                    <option value="011">011</option>
                                                    <option value="016">016</option>
                                                    <option value="017">017</option>
                                                    <option value="018">018</option>
                                                    <option value="019">019</option>
                                                </select>-<input id="rphone2_2" name="rphone2_[]" maxlength="4" fw-filter="isNumber&amp;isFill" fw-label="수취자 핸드폰번호" fw-alone="N" fw-msg="" size="4" value="" type="text">-<input id="rphone2_3" name="rphone2_[]" maxlength="4" fw-filter="isNumber&amp;isFill" fw-label="수취자 핸드폰번호" fw-alone="N" fw-msg="" size="4" value="" type="text">
                                                <div id="phoneMsg" class="error">핸드폰 번호를 입력해주세요</div>
	                                            <div id="phoneRegMsg" class="error">(가운데 번호)숫자만 3~4자리까지 입력해주세요</div>
	                                            <div id="phoneRegMsg2" class="error">(뒷 번호)숫자만 4자리 입력해주세요</div>
	                                        </td>
                                        </tr>
                                        <tr class="ec-orderform-emailRow ec-shop-deliverySimpleForm">
                                            <th scope="row">이메일 <span class="icoRequired">필수</span>
                                            </th>
                                            <td>
                                                <div class="ec-base-mail">
                                                <p>이메일은 아이디와 같습니다.</p>
                                                <!-- 
                                                    <input id="oemail1" name="oemail1" class="mailId" value="" type="text">@
                                                    <span class="mailAddress">
                                                        <select id="oemail3">
                                                            <option value="" selected="selected">-이메일 선택-</option>
                                                            <option value="naver.com">naver.com</option>
                                                            <option value="daum.net">daum.net</option>
                                                            <option value="nate.com">nate.com</option>
                                                            <option value="hotmail.com">hotmail.com</option>
                                                            <option value="yahoo.com">yahoo.com</option>
                                                            <option value="empas.com">empas.com</option>
                                                            <option value="korea.com">korea.com</option>
                                                            <option value="dreamwiz.com">dreamwiz.com</option>
                                                            <option value="gmail.com">gmail.com</option>
                                                            <option value="etc">직접입력</option>
                                                        </select>
                                                       
                                                    </span>
                                                      -->
                                                </div>
                                                <p class="ec-base-help">이메일로 주문 처리 과정을 보내드립니다.</p>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- 국내배송 메시지 -->
                    <div class="ec-shippingInfo-shippingMessage segment unique  ">
                        <select id="omessage_select" name="omessage_select" fw-filter="" fw-label="배송 메세지" fw-msg="">
                            <option value="oMessage-0" selected="selected">-- 메시지 선택 (선택사항) --</option>
                            <option value="oMessage-1">배송 전에 미리 연락바랍니다.</option>
                            <option value="oMessage-2">부재 시 경비실에 맡겨주세요.</option>
                            <option value="oMessage-3">부재 시 문 앞에 놓아주세요.</option>
                            <option value="oMessage-4">빠른 배송 부탁드립니다.</option>
                            <option value="oMessage-5">택배함에 보관해 주세요.</option>
                            <option value="oMessage-input">직접 입력</option>
                        </select>
                        <div class="ec-shippingInfo-omessageInput gBlank10" style="display:none;">
                            <textarea id="omessage" name="omessage" fw-filter="" fw-label="배송 메세지" fw-msg="" maxlength="255" cols="70"></textarea>
                            <div class="gBlank10 displaynone">
                                <label><input id="omessage_autosave0" name="omessage_autosave[]" fw-filter="" fw-label="배송 메세지 저장" fw-msg="" value="T" type="checkbox" disabled=""><label for="omessage_autosave0"></label>[]에 자동 저장</label>
                                <ul class="ec-base-help">
                                    <li>게시글은 비밀글로 저장되며 비밀번호는 주문번호 뒷자리로 자동 지정됩니다.</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="ec-jigsaw-area-orderProduct" class="ec-base-fold eToggle selected">
            <div id="ec-jigsaw-title-orderProduct" class="title">
                <h2>주문상품</h2>
                <span id="ec-jigsaw-heading-orderProduct" class="txtStrong gRight"><%= cartNo.length %>개</span>
            </div>
            <div class="contents">
                <!-- 국내배송상품 주문내역 -->
                <div class="orderArea ">
                    <!-- 업체기본배송 -->
                        <!-- 참고: 상품반복 -->
                        

    		
			<%	int total=0; %>
			<%
				for(int i=0; i<cartNo.length;i++) {
				cartList = cartDAO.getDAO().selectCart(cartNo[i], id);
					for(cartDTO cart: cartList){ %>
					
    				<input type="hidden" name ="cartNo" value="<%=cartNo[i]%>">
					<input type="hidden" name ="cart_ItemCD" value="<%=cart.getItemCD()%>">
					<input type="hidden" name ="cart_Each" value="<%=cart.getCartEach()%>">
					
					
                    <div class="xans-element- xans-order xans-order-supplierlist">
                        <div class="ec-base-prdInfo xans-record-">
                            <div class="prdBox">
                                <div class="thumbnail"><a href=""><img src="<%=request.getContextPath() %>/site/item_image/<%=cart.getItemMainImage() %>" alt="<%= cart.getItemMainImage() %>" width="90" height="90"></a></div>
                                <div class="description">
                                    <strong class="prdName" title="상품명"> <a href="" class="ec-product-name"><%= cart.getItemNM() %></a></strong>
                                    <ul class="info">
                                        <li>수량: <%= cart.getCartEach() %>개</li>
                                        <li>
                                            <span id="">상품구매금액: ₩<%= cart.getItem_price() * cart.getCartEach() %> </span>
                                            <span class="displaynone">()</span>
                                        </li>
                                       
                                        <li title="배송">[고정] / 업체기본배송 </li>
                                    </ul>  
                                </div>
                                <button type="button" class="btnRemove " id="btn_product_one_delete_id0" prd="35:000K:F:148964" set_prd_type="">삭제</button>
                            </div>
                        </div>
                    </div>
				<% 
						total += (cart.getItem_price() * cart.getCartEach());
					}
				}%>  
                        <!-- //참고 -->
                    <div class="totalPrice ec-base-fold eToggle selected">
                        <div class="title">
                            <h3>[업체기본배송]</h3>
                        </div>
                        <div class="contents">
                            <div class="ec-base-table gCellNarrow">
                                <table border="1">
                                    <caption>금액정보</caption>
                                    <colgroup>
                                        <col style="width:122px">
                                        <col style="width:auto">
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th scope="row">상품구매금액</th>
                                            <td class="right"><span class="txtStrong" >+₩<span id="cart_total_price"><%= total %></span></span></td>
                                        </tr>
                                                                               <tr>
                                            <th scope="row">배송비</th>
                                            <td class="right"><span class="txtStrong" >+₩<span id="cart_total_car_price"></span></span></td>
                                        </tr>
                                        <tr class="displaynone">
                                            <th scope="row">합계</th>
                                            <td class="right"><span class="txtStrong" >+₩<span id="cart_total_All_price"></span></span></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="ec-jigsaw-area-payment" class="ec-base-fold eToggle selected">
            <div id="ec-jigsaw-title-payment" class="title">
                <h2>결제정보</h2>
            </div>
            <div class="contents">
                <!-- app tag -->
                <div id="ec-orderform-payment-head"></div>

                <div class="segment">
                    <div class="ec-base-table gCellNarrow">
                        <table border="1">
                            <caption>결제정보 상세</caption>
                            <colgroup>
                                <col style="width:122px">
                                <col style="width:auto">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">주문상품</th>
                                    <td class="right">₩<span id="total_product_base_price_id"></span></td>
                                </tr>
                                <tr>
                                    <th scope="row">배송비</th>
                                    <td class="right">+<span id="total_ship_price_id">₩5,000</span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="totalPay gBlank10">
                        <h3 class="heading">결제금액</h3>
                        <strong class="txtStrong">
                            ₩<span id="payment_total_order_sale_price_view"></span>
                        </strong>
                        
                    </div>
                </div>

                <!-- app tag -->
                <div id="ec-orderform-payment-tail"></div>
            </div>
        </div>
        <!-- [결제수단] -->

        <div id="ec-jigsaw-area-paymethod" class="ec-base-fold eToggle selected">
            <div id="ec-jigsaw-title-paymethod" class="title">
                <h2>결제수단</h2>
            </div>
            <div class="contents">
                <!-- app tag -->
                <div id="ec-orderform-paymethod-head"></div>

                <div class="segment">
                    <ul class="payMethod">
                        
                        <li class="ec-paymethod-newArea selected">
                            <input type="radio" name="paymethod" id="paymethod-new" class="fRadio displaynone" checked=""><label for="paymethod-new"><span class="displaynone">다른 </span>결제수단 선택</label>
                            <div class="inner">
                                <span class="ec-base-label"><input id="addr_paymethod0" name="addr_paymethod" fw-filter="isFill" fw-label="결제방식" fw-msg="" value="cash" type="radio" checked="checked"><label for="addr_paymethod0">무통장입금</label></span>
                                
                                
                                 </div>
                        </li>
                    </ul>
                </div>

                <div class="ec-paymethod-input-detail">
                    <div id="payment_input_cash" class="ec-base-table typeWrite" style="">
                        <table border="1">
                            <caption>무통장입금 정보 입력</caption>
                            <colgroup>
                                <col style="width:100px">
                                <col style="width:auto">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">입금은행 <span class="icoRequired">필수</span>
                                    </th>
                                    <td><select id="bankaccount" name="bankaccount" fw-filter="" fw-label="무통장 입금은행" fw-msg="">
                                            <option value="-1">::: 선택해 주세요. :::</option>
                                            <option value="1">SC제일은행:12345678 Bag&Bag</option>
                                        </select></td>
                                </tr>
                                <tr>
                                    <th scope="row">입금자명 <span class="icoRequired">필수</span>
                                    </th>
                                    <td>
                                    	<input id="pname" name="pname" fw-filter="" fw-label="무통장 입금자명" fw-msg="" class="inputTypeText" placeholder="" size="15" maxlength="20" value="" type="text">
                                    	<div id="pnameMsg" class="error">입금자명을 입력해 주세요.</div>
	                                    <div id="pnameRegMsg" class="error">입금자명은 한글로만 작성 가능합니다.</div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div id="cashreceipt_display_area" class="receiptArea ">
                    <div class="title">
                        <h3>현금영수증</h3>
                    </div>
                    <input id="cashreceipt_regist0" name="cashreceipt_regist" fw-filter="" fw-label="현금영수증 신청 여부" fw-msg="" value="1" type="radio"><label for="cashreceipt_regist0">현금영수증 신청</label>
                    <input id="cashreceipt_regist1" name="cashreceipt_regist" fw-filter="" fw-label="현금영수증 신청 여부" fw-msg="" value="99" type="radio" checked="checked"><label for="cashreceipt_regist1">신청안함</label>
                </div>
            </div>
        </div>

        <!-- [약관동의] -->
        <div id="ec-jigsaw-area-agreement">
            <div class="agreeArea" id="all_agreement_checkbox">
                <div class="allAgree">
                    <input type="checkbox" id="allAgree" name="selectall"><label for="allAgree" ><strong>모든 약관 동의</strong></label>
                </div>
                <div class="agreement">
                    <ul>
                        <!-- 구매조건 확인 및 결제진행 동의 -->
                        <li id="chk_purchase_agreement" style="">
                            <div class="agree">
                            	<span style=""><input  class="check" id="chk_purchase_agreement0" name="checkNo" fw-filter="" fw-label="구매진행 동의" fw-msg="" value="T" type="checkbox" style="" onclick="checkSelectAll(this)"><label for="chk_purchase_agreement0"><span class="txtEm">[필수]</span> 구매조건 확인 및 결제진행 동의</label></span></div>
                        </li>
                       
                        <!-- 쇼핑몰 이용약관 동의 -->
                        <li class="displaynone">
                            <div class="agree">
                                <span ><input class="check" id="mallAgree" name="checkNo" type="checkbox" onclick="checkSelectAll(this)" ><label for="mallAgree"><span class="txtEm">[필수]</span> 쇼핑몰 이용약관 동의</label></span>
                                
                            </div>
                        </li>
                        <!-- 고유식별정보 수집 동의 -->
                        <li id="ec-shop-privacy_agreement_for_identification" class="displaynone">
                            <div class="agree">
                                <span ><input class="check" id="privacy_agreement_for_identification_check_box0" name="checkNo" fw-filter="" fw-label="" fw-msg="" value="T" type="checkbox" onclick="checkSelectAll(this)"><label for="privacy_agreement_for_identification_check_box0"></label><label for="privacy_agreement_for_identification_check_box0"><span class="txtEm">[필수]</span> 고유식별정보 수집 동의</label></span>
                                <button type="button" class="btnAgree" onclick="viewIdentification();">내용보기</button>
                            </div>
                        </li>
                        <!-- 개인정보수집 이용동의 -->
                        <li id="ec-orderform-PrivacyAgreementRow" class="displaynone" style="display: none;">
                            <div class="agree">
                                <span class="check" ><label for="privacy_agreement_check_box0"><span class="txtEm">[필수]</span> 개인정보 수집 및 이용 동의</label></span>
                                <span style="display:none;"></span>
                                <button type="button" class="btnAgree" onclick="viewMemberJoinAgree();">내용보기</button>
                            </div>
                        </li>
                        <!-- 청약철회방침 -->
                        <li class="displaynone">
                            <div class="agree">
                                <span><input  class="check" id="subscription_agreement_chk0" name="checkNo" fw-filter="" fw-label="" fw-msg="" value="T" type="checkbox" onclick="checkSelectAll(this)"><label for="subscription_agreement_chk0"></label><label for="subscription_agreement_chk0"><span class="txtEm displaynone">[필수]</span> 청약철회방침 동의</label></span>
                                <button type="button" class="btnAgree" onclick="viewSubscription();">내용보기</button>
                            </div>
                        </li>
                        <!-- 개인정보 제3자 제공 동의 -->
                        <li id="ec-orderform-informationAgreementRow" class="displaynone" style="display: none;">
                            <div class="agree">
                                <span class="check"><label for="information_agreement_check_box0">[선택] 개인정보 제3자 제공 동의</label></span>
                                <button type="button" class="btnAgree" onclick="viewInformationAgree();">내용보기</button>
                            </div>
                        </li>
                        <!-- 개인정보취급 위탁 동의 -->
                        <li id="ec-orderform-ConsignmentAgreementRow" class="displaynone" style="display: none;">
                            <div class="agree">
                                <span class="check"><label for="consignment_agreement_check_box0">[선택] 개인정보취급 위탁 동의</label></span>
                                <button type="button" class="btnAgree" onclick="viewConsignmentAgree();">내용보기</button>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="ec-base-button gFull" id="orderFixItem" >
            <button type="submit" class="btnSubmit" id="btn_payment">
                ₩<span id="total_order_sale_price_view"></span> <span class="">결제하기</span>
            </button>
        </div>
        <div class="helpArea">
            <ul class="ec-base-help typeDash">
                <li class="displaynone"><span class="txtEm">상기 금액은 결제 시점의 금액과 다를 수 있습니다.</span></li>
                <li>무이자할부가 적용되지 않은 상품과 무이자할부가 가능한 상품을 동시에 구매할 경우 전체 주문 상품 금액에 대해 무이자할부가 적용되지 않습니다. 무이자할부를 원하시는 경우 장바구니에서 무이자할부 상품만 선택하여 주문하여 주시기 바랍니다.</li>
                <li>최소 결제 가능 금액은 결제금액에서 배송비를 제외한 금액입니다.</li>
            </ul>
        </div>
    </div>
</form>
    
    <script type="text/javascript">
    $(function() {
    	var total_price =0;
		total_price= $('#cart_total_price').html();
		var total_car_price=5000;



		$('#cart_total_price').html($.numberWithCommas(total_price));
		$('#cart_total_car_price').html($.numberWithCommas(total_car_price));
		$('#cart_total_All_price').html($.numberWithCommas((total_price*1)+5000));
		$('#total_product_base_price_id').html($.numberWithCommas(total_price));
		$('#payment_total_order_sale_price_view').html($.numberWithCommas((total_price*1)+5000));
		$('#total_order_sale_price_view').html($.numberWithCommas((total_price*1)+5000));
	});
	
	//3자리수 마다 , 추가
	$.numberWithCommas = function (x) {
	  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}
	
	//, 제거
	$.withoutCommas = function (x) {
		return x.toString().replace(",", '');
	}
    
	$(function() {
		$("#allAgree").change(function() {
			if($(this).is(":checked")) {
				$(".check").prop("checked",true);
			} else {
				$(".check").prop("checked",false);
			}
		})

		
	});
	
	//회원 정보와 동일
	$("#sameaddr").change(function() {
		
		if($(this).val()=="M"){ //사용자값 받아오기

			$("#rname").val("<%= loginMember.getMemberName()%>");
			
			var p1 = "<%= loginMember.getMemberPhone().substring(0,3)%>";
			var p2 = "<%= loginMember.getMemberPhone().substring(4,8)%>";
			var p3 = "<%= loginMember.getMemberPhone().substring(9)%>";

			$("select[name=phone2] option:selected").text(p1);//수정 필요
			$("#rphone2_2").val(p2);
			$("#rphone2_3").val(p3);
			
			var postcode = "<%= loginMember.getMemberZipcode() %>";
			var address = "<%= loginMember.getMemberAddress1() %>";
			var detailAddress = "<%= loginMember.getMemberAddress2() %>";
			
			
			
			$("#sample3_extraAddress").val("");
			$("#sample3_postcode").val(postcode);
			$("#sample3_address").val(address);
			$("#sample3_detailAddress").val(detailAddress);
		}
	});
	//새로 작성 
	$("#sameaddr1").change(function() {
			if($(this).val()=="F"){ //사용자값 받아오기
				$("#rname").val("");
				$("#sample3_extraAddress").val("");
				$("#rphone2_2").val("");
				$("#rphone2_3").val("");
				$("#sample3_postcode").val("");
				$("#sample3_address").val("");
				$("#sample3_detailAddress").val("");
			}
		});
	
	

	function checkSelectAll(checkbox)  {
	  const selectall 
	    = document.querySelector('input[name="selectall"]');
	  
	  if(checkbox.checked === false)  {
	    selectall.checked = false;
	  }
	}
	
	function selectAll(selectAll)  {
		  const checkboxes 
		     = document.getElementsByName('checkNo');
		  
		  checkboxes.forEach((checkbox) => {
		    checkbox.checked = selectAll.checked
		  })
		}
	
	$("#order_joinForm").submit(function() {
		
		var submitResult=true;
		$(".error").css("display","none");
		
		var nameReg = /^[가-힣]+$/; //한글만-모음 자음 띄어쓰기 불가
		if($("#rname").val()=="") {
			$("#nameMsg").css("display","block");
			alert("받는 사람 이름을 입력해 주세요");
			submitResult=false;
		} else if(!nameReg.test($("#rname").val())) {
			$("#nameRegMsg").css("display","block");
			alert("받는 사람 이름을 다시 확인해 주세요");
			submitResult=false;
		}
		
		var phoneReg1 = /^[0-9]{3,4}$/; //폰 중간번호
		var phoneReg2 = /^[0-9]{4}$/; //폰 뒷자리
		if($("#rphone2_2").val()==""||$("#rphone2_3").val()=="") {
			$("#phoneMsg").css("display","block");
			alert("연락처를 확인해 주세요");
			submitResult=false;
		} else if(!phoneReg1.test($("#rphone2_2").val())){
			$("#phoneRegMsg").css("display","block");
			alert("연락처를 확인해 주세요");
			submitResult=false;
		} else if(!phoneReg2.test($("#rphone2_3").val())){
			$("#phoneRegMsg2").css("display","block");
			alert("연락처를 확인해 주세요");
			submitResult=false;
		}
		
		
		var pattern = /^[a-zA-Zㄱ-힣0-9\s\-\.]*$/;//한글,숫자,영어,공백 허용 특수문자 ㄴㄴ
		var zipcode = /^[0-9]{5,6}$/; //우편번호
		if(!zipcode.test($("#sample3_postcode").val())){
			alert("우편번호는 5글자(신 주소) 또는 6글자(구 주소)의 숫자로만 이루어져있습니다");
			submitResult=false;
		}
		
		if($("#sample3_address").val()=="") {
			alert("주소를 입력해주세요");
			submitResult=false;
		} else if(!pattern.test($("#sample3_address").val())){
			alert("주소에 특수문자는 허용되지 않습니다.");
			submitResult=false;
		}
		
		if($("#sample3_detailAddress").val()=="") {
			alert("상세주소를 입력해주세요");
			submitResult=false;
		} else if(!pattern.test($("#sample3_detailAddress").val())){
			alert("상세주소에 특수문자는 허용되지 않습니다.");
			submitResult=false;
		}
		
		if($("#bankaccount").val()=="-1"||$("#bankaccount").val()=="") {
			alert("입금은행을 선택해주세요");
			submitResult=false;
		}
		
		if($("#pname").val()=="") {
			$("#pnameMsg").css("display","block");
			alert("입금자명을 입력해 주세요");
			submitResult=false;
		} else if(!nameReg.test($("#pname").val())) {
			$("#pnameRegMsg").css("display","block");
			alert("입금자명을 다시 확인해 주세요");
			submitResult=false;
		}
		
		//$("input:checkbox[name=is_check]").length //전체?
		//$("input:checkbox[name=is_check]:checked").length //선택된?
		if($("input:checkbox[name=checkNo]").length!=$("input:checkbox[name=checkNo]:checked").length) {
			alert("필수체크 항목을 체크해주세요");
			submitResult=false;
		}
		
		/*
		var id = $("#oemail1").val();
		var mail = $("select[id=oemail3] option:selected").text();
		var email = id+"@"+mail;
		$("#email").val(allPhone);
		*/
		
		var phone1 = $("select[name=phone2] option:selected").text();
		var phone2 = $("#rphone2_2").val();
		var phone3 = $("#rphone2_3").val();
		
		var allPhone = phone1 + phone2 + phone3; 
		$("#phone").val(allPhone);
		
		var memo = $("select[name=omessage_select] option:selected").text();
		$("#memo").val(memo);

		return submitResult;
	});
	
	
	
	
	//주소 API

    // 우편번호 찾기 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function sample3_execDaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample3_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample3_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample3_postcode').value = data.zonecode;
                document.getElementById("sample3_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample3_detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script>
 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
