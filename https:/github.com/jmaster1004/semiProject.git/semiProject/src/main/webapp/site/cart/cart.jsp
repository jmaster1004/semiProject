<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="xyz.itwill.dao.cartDAO"%>
<%@page import="xyz.itwill.dto.cartDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	

	//세션에 저장된 권한 관련 정보를 반환받아 저장
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




    //String id ="redmango1446@gmail.com";
	//session.setAttribute("member_Id", ld);
    List<cartDTO> cartList = cartDAO.getDAO().selectAllCart((String)loginMember.getMemberEmail());
    	
%>
    

<body>
<form name="cartForm" id="cartForm">
    <div id="wrap">
        <div class="site-wrap">
            <div class="titleArea">
                <h2>장바구니</h2>
            </div>
            <div class="xans-element- xans-order xans-order-basketpackage ">
                <div class="xans-element- xans-order xans-order-tabinfo ec-base-tab typeLight ">
                    <ul class="menu">
                        <li class="selected "><a href="/order/basket.html">국내배송상품</a></li>
                    </ul>
                    
                </div>
                <div class="orderListArea ec-base-table typeList gBorder">
                    <div class="xans-element- xans-order xans-order-normtitle title ">
                        <h3>일반상품</h3>
                    </div>
                    <table border="1" summary="" class="xans-element- xans-order xans-order-suppnormal xans-record-">
                        <caption>업체기본배송</caption>
                        <colgroup>
                            <col style="width:27px">
                            <col style="width:92px">
                            <col style="width:75%">
                            <col style="width:98px">
                            <col style="width:75px">
                            <col style="width:98px">
                            <col style="width:98px">
                            <col style="width:85px">
                            <col style="width:98px">
                            <col style="width:110px">
                        </colgroup>

                        <thead>
                           <tr>
								<th><input type="checkbox" id="allCheck" checked="on"  name="selectall"></th>
                                <th scope="col">이미지</th>
                                <th scope="col">상품정보</th>
                                <th scope="col">판매가</th>
                                <th scope="col">수량</th>
                                <th scope="col">배송비</th>
                                <th scope="col">합계</th>
                            </tr>
                        </thead>
							            
							<tfoot class="right">
                            <tr>
                                <td colspan="10">
                                    <span class="gLeft">[업체기본배송]</span> 상품구매금액 <strong id="cart_total_price"><span class="displaynone">()</span></strong><span class="displaynone"> </span> + 배송비 <span id="cart_total_car_price"></span><span class="displaynone"> </span>  = 합계 : <strong class="txtEm gIndent10">₩<span id="cart_total_All_price" class="txt18"></span></strong> <span class="displaynone"> </span>
                                </td>
                            </tr>
                        	</tfoot>           
							
							<tbody name="cartdate">            
							<%
				            int i = 0;
				            for (; i < cartList.size(); i++) {
				            %>            
							
								<tr>
									<input type="hidden" name ="cart_ItemCD" value="<%=cartList.get(i).getItemCD()%>">
									<td class="cart_check">
										<input type="checkbox" id="check<%=i %>"  name="checkNo" value="<%=cartList.get(i).getCartNo()%>" class="check" checked="on"  onclick="checkSelectAll(this)">
									</td>
									<td class="cart_mainImage"><img src="<%=request.getContextPath() %>/site/item_image/<%=cartList.get(i).getItemMainImage() %>" style = "max-width:80px"></td>
									<td class="cart_NM" name ="cart_NM"><%=cartList.get(i).getItemNM() %></td>
									<td class="cart_price" name ="cart_price" id="cart_price<%=i %>"><%=cartList.get(i).getItem_price() %></td>
									<td class="cart_Each">
										<span class="ec-base-qty">
											<input type="text" name="cart_each" id="cart_Each<%=i %>" value="<%=cartList.get(i).getCartEach() %>" size="2">
											<a href="javascript:;" class="up" onclick="fnCalCount('p', this);">
												<img src="//img.echosting.cafe24.com/skin/base/common/btn_quantity_up.gif" alt="수량증가">
											</a>
											<a href="javascript:;" class="down" onclick="fnCalCount('m', this);">
												<img src="//img.echosting.cafe24.com/skin/base/common/btn_quantity_down.gif" alt="수량감소">
											</a>
										</span>
										<a href="javascript:;" class="gBlank5" style="padding: 2px 12px; border: 1px solid #d1d1d1; " onclick="gogo(this)">변경</a>
										
									</td>
									 
									<%if(i< 1){%>
									<td class="cart_car_price"   rowspan ="<%=cartList.size()%>" ><span id="cart_car_price">5000</span> <br><strong>고정</strong></td>
									<%}%>

									<td class="cart_total" id="cart_total<%=i%>"><%=cartList.get(i).getItem_price() * cartList.get(i).getCartEach()%></td>
								</tr>

							<% } %>
							</tbody>
                        
                        
                    </table>
                </div>

                <div class="xans-element- xans-order xans-order-selectorder ec-base-button ">
                    <span class="gLeft">
                        <strong class="text">선택상품을</strong>
                        <a href="#none" class="btnEm" id="removeBtn"><i class="icoDelete"></i> 삭제하기</a>
                    </span>
                    <span class="gRight">
                        <a href="#none" class="btnNormal" id="removeAllBtn">장바구니비우기</a>
                    </span>
                </div>

                <div class="xans-element- xans-order xans-order-totalsummary ec-base-table typeList gBorder total  ">
                    <table border="1" summary="">
                        <caption>총 주문금액</caption>
                        <colgroup>
                            <col style="width:17%;">
                            <col style="width:17%;" class="displaynone">
                            <col style="width:19%;">
                            <col style="width:17%;" class="displaynone">
                            <col style="width:auto;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col"><strong>총 상품금액</strong></th>
                                <th scope="col" class="displaynone"><strong>총 부가세</strong></th>
                                <th scope="col"><strong>총 배송비</strong></th>
                                <th scope="col"><strong>결제예정금액</strong></th>
                            </tr>
                        </thead>

                        <tbody class="center">
                            <tr>
                            
                            	<td ><strong id="cart_chios_total_price"></strong></td>
                            	<td ><strong id="cart_chios_total_car_price"></strong></td>
                            	<td ><strong id="cart_chios_total_All_price"></strong></td>
                            </tr>
                            
                            
                        </tbody>
                    </table>
	     			<div class="xans-element- xans-order xans-order-totalorder ec-base-button justify">
	     				<a href="#none" id="AllselectOrder" class="btnSubmitFix sizeM  ">전체상품주문</a>
	 					<a href="#none" id="selectOrder"  class="btnEmFix sizeM ">선택상품주문</a><span class="gRight">
	    				<a href="#none" class="btnNormalFix sizeM" id="selectBtn">쇼핑계속하기</a>
	 					</span>
					    <!-- 네이버 체크아웃 구매 버튼  -->
					    <div id="NaverChk_Button"></div>
					</div>
                </div>
            </div>
        </div>
    </div>
</form> 
<script type="text/javascript">


	$(function() {
		var total_price=0;
		var total_car_price=5000;
		<%
		for(cartDTO cart:cartList) {
			int a = cart.getItem_price()*cart.getCartEach();%>
			total_price += <%=a%>
		<%}%>

		$('#cart_total_price').html($.numberWithCommas("₩"+total_price));
		$('#cart_total_car_price').html($.numberWithCommas("₩"+total_car_price));
		$('#cart_total_All_price').html($.numberWithCommas(total_price+total_car_price));
	});
	
	//3자리수 마다 , 추가
	$.numberWithCommas = function (x) {
	  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}
	
	//, 제거
	$.withoutCommas = function (x) {
		return x.toString().replace(",", '');
	}
	
	$.sal = function() {
		var total_chios_price = 0;
		var car_price = 0;
		
		for(i=0; i< <%=cartList.size()%>; i++){
			if($("#check"+i).is(':checked')){
				total_chios_price += $('#cart_price'+i).text() * ($('#cart_Each'+i).val()*1);
			}
		}
		
		if(total_chios_price != 0) {
			car_price = $('#cart_car_price').text();
		}
		
		$('#cart_chios_total_price').html($.numberWithCommas("₩"+total_chios_price));
		$('#cart_chios_total_car_price').html($.numberWithCommas("+₩"+car_price));
		$('#cart_chios_total_All_price').html($.numberWithCommas("=₩"+((total_chios_price*1) + (car_price*1)))+"원");
	};

	$(function() {
		$.sal();
		$("#allCheck").change(function() {
			if($(this).is(":checked")) {
				$(".check").prop("checked",true);
			} else {
				$(".check").prop("checked",false);
			}
			$.sal();	
		})
		
		$(".check").change (function() {
			$.sal();
		})
		
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
	
	function fnCalCount(type, ths){
	    var $input = $(ths).parents("td").find("input[name='cart_each']");
	    var tCount = Number($input.val());
	    
	    
	    if(type=='p'){
	        if(tCount < 100) $input.val(Number(tCount)+1);
	    }else{
	        if(tCount > 1) $input.val(Number(tCount)-1);    
	    }
	    
	    $("#cartForm").attr("method", "post");
		$("#cartForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=cart&work=cart_update_action");
		$("#cartForm").submit();
	}
	
	function gogo(ths) {
	    
		$("#cartForm").attr("method", "post");
		$("#cartForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=cart&work=cart_update_action");
		$("#cartForm").submit();
	};
	
	$("#AllselectOrder").click(function() {
		
		$(".check").prop("checked",true);

		
		$("#cartForm").attr("method", "post");
		$("#cartForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_join");
		$("#cartForm").submit();
	});
	
	$("#selectOrder").click(function() {
		if($(".check").filter(":checked").length==0) {
			$("#message").text("선택된 상품이 하나도 없습니다.");
			return;
		}
		
		$("#cartForm").attr("method", "post");
		$("#cartForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_join");
		$("#cartForm").submit();
	});
	
	
	
	$("#removeBtn").click(function() {
		if($(".check").filter(":checked").length==0) {
			$("#message").text("선택된 상품이 하나도 없습니다.");
			return;
		}
		
		$("#cartForm").attr("method", "post");
		$("#cartForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=cart&work=cart_remove_action");
		$("#cartForm").submit();
	});
	
	$("#removeAllBtn").click(function() {
		
		$("#cartForm").attr("method", "post");
		$("#cartForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=cart&work=cart_removeAll_action");
		$("#cartForm").submit();
	});
	
</script>

</body>
</html>

