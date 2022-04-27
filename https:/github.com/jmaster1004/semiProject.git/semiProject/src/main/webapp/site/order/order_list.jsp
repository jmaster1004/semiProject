<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@page import="xyz.itwill.dto.OrdersDTO"%>
<%@page import="xyz.itwill.dao.OrdersDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");

	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {//전달값이 있는 경우 =null 이 아닌 경우
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	int pageSize=10;
	//int totalOrders=OrdersDAO.getDAO().selectOrdersCount();
	int totalOrders=OrdersDAO.getDAO().selectOrdersCount(loginMember.getMemberEmail());
	
	int totalPage=(int)Math.ceil((double)totalOrders/pageSize);
	
	if(pageNum<=0 || pageNum>totalPage) {//전달된 페이지 번호가 비정상적인 경우 
		pageNum=1;
	}
	int startRow=(pageNum-1)*pageSize+1;
	int endRow=pageNum*pageSize;
	if(endRow>totalOrders) {
		endRow=totalOrders;
	}
	
	int orderStatus=0;
	
	if(request.getParameter("orderStatus")!=null){
		orderStatus=Integer.parseInt(request.getParameter("orderStatus"));
	}	
	
	List<OrdersDTO> ordersList=OrdersDAO.getDAO().selectOrdersList(orderStatus, startRow, endRow, loginMember.getMemberEmail());
	
	int number=totalOrders-(pageNum-1)*pageSize;
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
%>
<style type="text/css">
.order_list_print {
	text-align: center;
}
</style>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<div id="wrap">
    <div class="site-wrap">
		<div class="path">
    		<span>현재 위치</span>
    		<ol><li><a href="/">홈</a></li>
    		    <li><a href="/myshop/index.html">마이쇼핑</a></li>
     		   <li title="현재 위치"><strong>주문조회</strong></li>
  			  </ol>
		</div>

		<div class="titleArea">
			<br>
		    <h2>주문조회</h2>
		</div>

		<div class="xans-element- xans-myshop xans-myshop-orderhistorytab ec-base-tab ">
			<ul class="menu">
				<li class="tab_class">
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_list">주문내역조회</a>
				</li>
				<li class="tab_class_cs">
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_cancel_page">취소/반품/교환 내역</a>
				</li>
			</ul>
		</div>

			<div class="xans-element- xans-myshop xans-myshop-orderhistoryhead">
				<fieldset class="ec-base-box">
					<div class="stateSelect ">
						<select id="order_status" name="order_status" class="fSelect" onchange="if(this.value) location.href=(this.value);">
							<option value="<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_list&pageNum=<%=pageNum%>">전체 주문처리상태</option>		
							<option value="<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_list&pageNum=<%=pageNum%>&orderStatus=1">입금대기</option>		
							<option value="<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_list&pageNum=<%=pageNum%>&orderStatus=2">입금완료</option>		
							<option value="<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_list&pageNum=<%=pageNum%>&orderStatus=11">배송준비중</option>
							<option value="<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_list&pageNum=<%=pageNum%>&orderStatus=12">배송중</option>
							<option value="<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_list&pageNum=<%=pageNum%>&orderStatus=13">배송완료</option>
							<option value="<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_list&pageNum=<%=pageNum%>&orderStatus=21">취소</option>
							<option value="<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_list&pageNum=<%=pageNum%>&orderStatus=23">교환</option>
							<option value="<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_list&pageNum=<%=pageNum%>&orderStatus=25">반품</option>
							<option value="<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_list&pageNum=<%=pageNum%>&orderStatus=27">환불완료</option>
						</select>
					</div>
					<div>
							<form id="dateSearchForm" name="dateSearchForm" action="<%=request.getContextPath() %>/site/index.jsp?workgroup=order&work=order_list">
								<input type="text" id="dateS" name="dateS">
								~<input type="text" id="dateE" name="dateE">
								<button type="submit" id="dateSearchBtn">검색</button>
							</form>
					</div>	
				</div>
				</fieldset>
			<ul>
				<li class=" ">주문번호를 클릭하시면 해당 주문에 대한 상세내역을 확인하실 수 있습니다</li>
				<li class="">취소/교환/반품 신청은 배송완료일 기준 30일까지 가능합니다.</li>
			</ul>
			<input id="mode" name="mode" value="" type="hidden" /> 
			<input id="term" name="term" value="" type="hidden" />
		</form>



		<div class="xans-element- xans-myshop xans-myshop-orderhistorylistitem ec-base-table typeList">
			<!--
		        $login_url = /member/login.html
		    -->
			<div class="title">
				<br>
				<h3>주문 상품 정보</h3>
			</div>
		
			<table border="1" summary="">
				<caption>주문 상품 정보</caption>
				<colgroup>
					<col style="width: 135px;" />
					<col style="width: 135px;" />
					<col style="width: auto;" />
					<col style="width: 65px;" />
					<col style="width: 120px;" />
					<col style="width: 120px;" />
					<col style="width: 60px;" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">주문일자</th>
						<th scope="col">주문번호</th>
						<th scope="col">상품정보</th>
						<th scope="col">수량</th>
						<th scope="col">상품구매금액</th>
						<th scope="col">주문처리상태</th>
						<th scope="col">결제여부</th>
					</tr>
				</thead>
				
				<tbody>
				<% if(totalOrders==0) { %>
				<tr>
					<td colspan="7">주문 내역이 없습니다.</td>
				</tr>
				<% } else { %>
					<% for(OrdersDTO orders:ordersList) { %>	

						<tr class="order_list_print">
							<%--주문일자 --%>
							<td class="order_date"><%=orders.getOrderDate().substring(0, 10) %></td>
							<%--주문번호 --%>
							<td class="order_no"><%=orders.getOrderNo() %></td>
							<%--상품정보 --%>
							<td class="order_itemNm"><%=orders.getItemNm() %></td>
							<%--수량 --%>
							<td class="order_quantity"><%=orders.getOrderQuantity() %></td>
							<%--상품구매금액 --%>
							<td class="order_price"><%=orders.getItemPrice() * orders.getOrderQuantity() %></td>
							<%--주문처리상태 --%>
							<td class="order_status">
									<% if (orders.getOrderStatus()==1) { %>
									입금대기
									<%--<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_cancel">취소신청</a>--%>
									<form id="cancelSubmitForm" name="cancelSubmitForm" method="post">
										<input type="hidden" id="cancelOrderNo" name="cancelOrderNo" value="<%=orders.getOrderNo() %>">
										<input type="hidden" id="cancelOrderStatus" name="cancelOrderStatus" value="<%=orders.getOrderStatus() %>">
										<button type="button" id="cancelSubmitBtn" name="cancelSubmitBtn" >취소신청</button>
									</form>
								<% } else if(orders.getOrderStatus()==2) { %>
									입금완료
									<form id="cancelSubmitForm" name="cancelSubmitForm" method="post">
										<input type="hidden" id="cancelOrderNo" name="cancelOrderNo" value="<%=orders.getOrderNo() %>">
										<input type="hidden" id="cancelOrderStatus" name="cancelOrderStatus" value="<%=orders.getOrderStatus() %>">
										<button type="button" id="cancelSubmitBtn" name="cancelSubmitBtn" >취소신청</button>
									</form>
								<% } else if(orders.getOrderStatus()==11) { %>
									배송준비중
									<form id="cancelSubmitForm" name="cancelSubmitForm" method="post">
										<input type="hidden" id="cancelOrderNo" name="cancelOrderNo" value="<%=orders.getOrderNo() %>">
										<input type="hidden" id="cancelOrderStatus" name="cancelOrderStatus" value="<%=orders.getOrderStatus() %>">
										<button type="button" id="cancelSubmitBtn" name="cancelSubmitBtn" >취소신청</button>
									</form>
								<% } else if(orders.getOrderStatus()==12) { %>
									배송중
									<button type="button" id="refundBtn" onclick="location.href='<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_exchange_return';">교환/반품신청</button>
								<% } else if(orders.getOrderStatus()==13) { %>
									배송완료<br>
										<button type="button" id="refundBtn" onclick="location.href='<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_exchange_return';">교환/반품신청</button>
												<form id="reviewWriteBtnForm" name="reviewWriteBtnForm" method="post" action="<%=request.getContextPath()%>/site/index.jsp?workgroup=review&work=review_write">
													<button type="submit" id="reviewWriteBtn" >리뷰작성</button>
													<input id="orderItem" name="orderItem" type="hidden" value="<%=orders.getItemNm() %>">
													<input id="orderItemCD" name="orderItemCD" type="hidden" value="<%=orders.getItemCd() %>">
												</form>
								<% } else if(orders.getOrderStatus()==21) { %>
									취소진행중
								<% } else if(orders.getOrderStatus()==22) { %>
									취소완료
								<% } else if(orders.getOrderStatus()==23) { %>
									교환진행중
								<% } else if(orders.getOrderStatus()==24) { %>
									교환완료
								<% } else if(orders.getOrderStatus()==25) { %>
									반품진행중
								<% } else if(orders.getOrderStatus()==26) { %>
									반품완료
								<% } else if(orders.getOrderStatus()==27) { %>
									환불진행중
								<% } else if(orders.getOrderStatus()==28) { %>
									환불완료
								<% } %>
							</td>
							<td>
								<% if(orders.getOrderStatus()==1) { %>
								<input type="button" value="결제" onclick="window.open('<%=request.getContextPath() %>/site/index.jsp?workgroup=order&work=order_payment', '결제창', 'width=1000, height=400')">
								<input type="hidden" id="order_price" value="<%=orders.getItemPrice() * orders.getOrderQuantity() %>">
								<input type="hidden" id="order_no" value="<%=orders.getOrderNo() %>">
								<% } else { %>
									&nbsp;
								<% } %>
							</td>
						</tr>
						
						<%-- 출력 글번호의 변수값 1 감소 --%>
						<% number--; %>

					<% } %>
				<% } %>

				</tbody>
			</table>
		</div>
	</div>
</div> 
<%
//페이지 블럭에 출력될 페이지의 갯수 설정
	int blockSize=5;////한 블럭당 페이지를 5개씩만 출력되도록 ex) 1~5, 6~10, 11~15, ...
	
	//페이지 블럭에 출력될 시작 페이지 번호를 계산하여 저장
	//ex) 1Block : 1, 2Block : 6, 3Block : 11, 4Block : 16, ...  
	int startPage=(pageNum-1)/blockSize*blockSize+1;
	
	//페이지 블럭에 출력될 종료 페이지 번호를 계산하여 저장
	//1Block : 5, 2Block : 10, 3Block : 15, 4Block : 20, ...   
	int endPage=startPage+blockSize-1;
	
	//마지막 페이지 블럭의 종료 페이지 번호 변경
	if(endPage>totalPage) {
		endPage=totalPage;
	}
%>

<%--
		<tbody class="center displaynone">
			<tr class="">
				<td class="number displaynone">
					<p></p>
					<a href="" class="btnNormal displaynone" onclick="">주문취소</a> 
					<a href="" class="btnNormal displaynone">취소신청</a> 
					<a href="" class="btnNormal displaynone">교환신청</a> 
					<a href="" class="btnNormal displaynone">반품신청</a>
				</td>
				<td class="thumb"><a href=""><img src="" onerror="this.src='//img.echosting.cafe24.com/thumb/img_product_small.gif';" alt="" /></a></td>
				<td class="product left top"><strong class="name"></strong>
					<div class="option displaynone"></div>
					<ul class="xans-element- xans-myshop xans-myshop-optionset option">
						<li class=""><strong></strong> (개)</li>
					</ul>
					<p class="gBlank5 displaynone">무이자할부 상품</p></td>
				<td></td>
				<td class="right"><strong></strong>
					<div class="displaynone"></div></td>
				<td class="state">
					<p class="txtEm"></p>
					<p class="displaynone">
						<a href="" target=""></a>
					</p>
					<p class="displaynone">
					</p> <!--<a href="/board/product/write.html" class="btnSubmit displaynone">구매후기</a>-->
					<a href="#none" class="btnNormal displaynone" onclick="">취소철회</a>
					<a href="#none" class="btnNormal displaynone" onclick="">교환철회</a>
					<a href="#none" class="btnNormal displaynone" onclick="">반품철회</a> 
					<!-- 리뷰톡톡 주문 내역조회-->
					<!-- 리뷰톡톡 주문 내역조회-->
				</td>
				<td>
					<p class="displaynone">
						<a href="#none" class="btnNormal" onclick="">상세정보</a>
					</p>
					<p class="displaynone">-</p>
				</td>
			</tr>
			<tr class="">
				<td class="number displaynone">
					<p></p>
					<p>
						<a href="detail.html" class="line">[]</a>
					</p>
					<a href="" class="btnNormal displaynone" onclick="">주문취소</a>
					<a href="" class="btnNormal displaynone">취소신청</a> 
					<a href="" class="btnNormal displaynone">교환신청</a> 
					<a href="" class="btnNormal displaynone">반품신청</a>
				</td>
				<td class="thumb">
					<a href="/product/detail.html">
					<img src="" onerror="this.src='//img.echosting.cafe24.com/thumb/img_product_small.gif';" alt="" /></a>
				</td>
				<td class="product left top"><strong class="name"></strong>
					<div class="option displaynone"></div>
					<ul class="xans-element- xans-myshop xans-myshop-optionset option">
						<li class=""><strong></strong> (개)</li>
					</ul>
					<p class="gBlank5 displaynone">무이자할부 상품</p></td>
				<td></td>
				<td class="right"><strong></strong>
				<div class="displaynone"></div></td>
				<td class="state">
					<p class="txtEm"></p>
					<p class="displaynone">
						<a href="" target=""></a>
					</p>
					<p class="displaynone">
						<a href="" class="line" onclick="">[]</a>
					</p> <!--<a href="/board/product/write.html" class="btnSubmit displaynone">구매후기</a>-->
					<a href="" class="btnNormal displaynone" onclick="">취소철회</a> 
					<a href="" class="btnNormal displaynone" onclick="">교환철회</a> 
					<a href="" class="btnNormal displaynone" onclick="">반품철회</a> <!-- 리뷰톡톡 주문 내역조회-->
					<!-- 리뷰톡톡 주문 내역조회-->
				</td>
				<td>
					<p class="displaynone">
						<a href="" class="btnNormal" onclick="">상세정보</a>
					</p>
					<p class="displaynone">-</p>
				</td>
			</tr>
		</tbody>

	

</div>

<!-- 리뷰톡톡 주문 내역조회-->
<!-- 
    참고 : 이 페이지는 나의 주문내역 입니다 
    사용되는 페이지들 : 나의 주문내역
-->
<!-- 비동기로 전달할 템플릿 영역(반드시 포함이 되어있어야함) -->
<div id="ec-board-myshoporderlist-wrapper" style="display: none;">
</div>
<div async_module="smartreview_dispMyshopOrderList"
	async_type="template">
	<!-- 비동기로 처리된 이후 노출되는 섹션 -->
	<div async_section="after" style="display: none;" data-key="{$*no}">
		<a href="#none" onclick="{$*display_write_link_onclick}" class="{$*review_write_display}">
		<img src="//img.echosting.cafe24.com/skin/base_ko_KR/myshop/btn_review_write.gif" alt="리뷰작성" /></a> 
		<a href="" onclick="{$*display_read_link_onclick}" class="{$*review_view_display}">
		<img src="//img.echosting.cafe24.com/skin/base_ko_KR/myshop/btn_review_check.gif" alt="리뷰확인" /></a>
	</div>
</div>
<!-- 리뷰톡톡 주문 내역조회-->
 --%>
<%--
<div
	class="xans-element- xans-myshop xans-myshop-orderhistorypaging ec-base-paginate">
	<a href="?page=1&history_start_date=2021-10-29&history_end_date=2022-01-27&past_year=2021" class="first"> 
	<img src="<%=request.getContextPath()%>/site/_wp/img/btn_page_first2.jpg" alt="첫 페이지" /> </a>
	<a href="?page=1&history_start_date=2021-10-29&history_end_date=2022-01-27&past_year=2021">
	<img src="<%=request.getContextPath()%>/site/_wp/img/btn_page_prev2.jpg" alt="이전 페이지" /></a>
	<ol>
		<li class="xans-record-">
		<a href="?page=1&history_start_date=2021-10-29&history_end_date=2022-01-27&past_year=2021" class="this">1</a>
		</li> 
	</ol>
	<a href="?page=1&history_start_date=2021-10-29&history_end_date=2022-01-27&past_year=2021">
	<img src="<%=request.getContextPath()%>/site/_wp/img/btn_page_next2.jpg" alt="다음 페이지" /></a> 
	<a href="?page=1&history_start_date=2021-10-29&history_end_date=2022-01-27&past_year=2021" class="last"> 
	<img src="<%=request.getContextPath()%>/site/_wp/img/btn_page_last2.jpg" alt="마지막 페이지" /></a>
</div>
 --%>
<div class="xans-element- xans-board xans-board-paging-4 xans-board-paging xans-board-4 ec-base-paginate">
	<% if(startPage>blockSize) { %>
	<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_list&pageNum=<%=startPage-blockSize%>"><img src="_wp/img/btn_page_prev.jpg" alt="이전 페이지"></a>
	<% } %>
		<% for(int i=startPage;i<=endPage;i++) { %>
			<% if(pageNum!=i) {//요청 페이지 번호와 출력 페이지 번호가 같지 않은 경우 링크 설정 %>
				<ol>
					<li class="xans-record-">
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_list&pageNum=<%=i%>" class="other"><%=i %></a></li>
				</ol>
			<% } else {//요청 페이지 번호와 출력 페이지 번호가 같을 경우 링크 미설정 %>
				<ol>
					<li class="xans-record-"><a href="" class="this"><%=i %></a></li>
				</ol>
			<% } %>
		<% } %>
 
		<% if(endPage!=totalPage) {//종료 페이지 번호와 전체 페이지 갯수가 같지 않은 경우 링크 설정 %>
			<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_list&pageNum=<%=startPage+blockSize%>">
			<img src="_wp/img/btn_page_next.jpg" alt="다음 페이지"></a>
		<% } %>
		
</div>
<script type="text/javascript">

$("#cancelSubmitBtn").click(function(){
	if(confirm("취소 하시겠습니까?")){
		$("#cancelSubmitForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_cancel_action");
		$("#cancelSubmitForm").submit();
	}
});



$(".order_date").each(function () {
	var rows = $(".order_date:contains('"+$(this).text()+"')");
	if (rows.length > 1) {
		rows.eq(0).attr("rowspan", rows.length);
		rows.not(":eq(0)").remove();
	}
});


$("#orderStatus").change(function() {
	$("#orderStatusForm").submit();
});

<%--
$(document).ready(function () {
    $('#reviewWriteBtn').click(function () {
      var reviewWrite = $('input[name="reviewGrade"]:checked').val();
    });
  });
--%>
$(function() {
    fn_default_datepicker();
});
    
function fn_default_datepicker() {
var start = $( "#dateS" ).datepicker({
    dateFormat: 'yy-mm-dd' //Input Display Format 변경
    ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
    ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
    ,changeYear: true //콤보박스에서 년 선택 가능
    ,changeMonth: true //콤보박스에서 월 선택 가능                
    ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
    ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
    ,buttonImageOnly: false //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
    ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
    ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
    ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
    ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
    ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
    ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
    ,minDate: "-1Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
    ,maxDate: "0M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                
});
    
var end = $( "#dateE" ).datepicker({
    dateFormat: 'yy-mm-dd' //Input Display Format 변경
    ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
    ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
    ,changeYear: true //콤보박스에서 년 선택 가능
    ,changeMonth: true //콤보박스에서 월 선택 가능                
    ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
    ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
    ,buttonImageOnly: false //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
    ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
    ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
    ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
    ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
    ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
    ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
    ,minDate: "-1Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
    ,maxDate: "0M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
    ,defaultDate: "+1w"
  });

//초기값을 오늘 날짜로 설정
$('#dateS').datepicker('setDate', '-7D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
$('#dateE').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)

}

       
$("#dateSearchBtn").click(function () {
	$("#dateSearchForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_list");
	$("#dateSearchForm").submit();
	
});

function getDate( element ) {
    var date;
    var dateFormat = "yy-mm-dd";
    try {
      date = $.datepicker.parseDate( dateFormat, element.value );
    } catch( error ) {
      date = null;
    }
    return date;
 };


</script>
