<%@page import="xyz.itwill.dao.ItemDAO"%>
<%@page import="xyz.itwill.dto.ItemDTO"%>
<%@page import="xyz.itwill.dto.MemberDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/site/security/admin_check.jspf"%>     
<%
 	if(request.getParameter("num")==null){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;		
	} 

	int num=Integer.parseInt(request.getParameter("num"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");

	ItemDTO item=ItemDAO.getDAO().selectNumItem(num); 

%>
<style type="text/css">
table {
	margin: 0 auto;
	border: 1px solid black;
	border-collapse: collapse;
}
</style>

<div id="wrap">
	<div class="site-wrap" style="width:50%">
		<div
			class="xans-element- xans-board xans-board-readpackage-4 xans-board-readpackage xans-board-4 ">
			<div
				class="xans-element- xans-board xans-board-title-4 xans-board-title xans-board-4 ">

				<div class="titleArea">
				<br>
					<h2>
						상세정보
					</h2>
				</div>
			</div>
				<div
					class="xans-element- xans-board xans-board-read-4 xans-board-read xans-board-4">
			<div class="ec-base-table typeWrite ">
						<table border="1" summary="">
							<caption>제품 상세 정보</caption>
							<colgroup>
								<col style="width: 130px;">
								<col style="width: auto;">
								<col style="width: auto;">
								<col style="width: auto;">
								<col style="width: auto;">
								<col style="width: auto;">
								<col style="width: auto;">
								<col style="width: auto;">
								<col style="width: auto;">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">제품번호</th>
									<td>
										<%=item.getItemCd() %>
									</td>
								</tr>
								<tr>
									<th scope="row">제품명</th>
									<td>
										<%=item.getItemNm() %>
									</td>
								</tr>
								<tr>
									<th scope="row">카테고리</th>
									<td><%=item.getCategoryName() %></td>
								</tr>
								<tr>
									<th scope="row">제품수량</th>
									<td><%=item.getItemQty() %></td>
								</tr>
								<tr>
									<th scope="row">제품가격</th>
									<td><%=item.getItemPrice() %></td>
								</tr>																
								<tr>
									<th scope="row">메인이미지</th>
									<td><img src="<%=request.getContextPath()%>/site/item_image/<%=item.getItemMainImage()%>" height="200" width="200" alt="<%=item.getItemMainImage() %>"></td>
								</tr>
								<tr>
									<th scope="row">소개이미지1</th>
									<td><img src="<%=request.getContextPath()%>/site/item_image/<%=item.getItemCttImage1()%>" height="200" width="200" alt="<%=item.getItemCttImage1() %>"></td>
								</tr>
								<tr>
									<th scope="row">소개이미지2</th>	
									<td><img src="<%=request.getContextPath()%>/site/item_image/<%=item.getItemCttImage2()%>" height="200" width="200" alt="<%=item.getItemCttImage2() %>"></td>
								</tr>
								<tr>
									<th scope="row">소개이미지3</th>
									<td><img src="<%=request.getContextPath()%>/site/item_image/<%=item.getItemCttImage3()%>" height="200" width="200" alt="<%=item.getItemCttImage3() %>"></td>
								</tr>																								
							</tbody>
						</table>
					</div>
					<div class="ec-base-button ">
						<span class="gLeft">
						 <a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_manager&pageNum=<%=pageNum %>" class="btnNormalFix sizeS">목록</a>
						</span> 
						<span class="gRight"> 
							<button type="button" id="removeBtn" class="btnNormalFix sizeS displaynone">삭제</button>
							<button type="button" id="modifyBtn" class="btnEmFix sizeS displaynone">수정</button>
						</span>
					</div>
				</div>
		</div>
		<div>
			<form id="itemForm" method="post">
				<%-- 글 삭제와 글변경을 클릭한 경우 요청 JSP 문서에 전달되는 값  --%>
				<input type="hidden" name="num" value="<%=item.getItemCd()%>"> 
				
			<%-- 답글쓰기를 클릭한 경우 요청 JSP 문서에 전달되는 값  --%>
				<input type="hidden" name="pageNum" value="<%=pageNum%>"> 
				<input type="hidden" name="search" value="<%=keyword%>"> 
				<input type="hidden" name="keyword" value="<%=search%>"> 
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
$("#removeBtn").click(function(){
	if(confirm("게시글을 삭제 하시겠습니까?")){
		$("#itemForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_remove_action");
		$("#itemForm").submit();
	}
})

$("#modifyBtn").click(function(){
	$("#itemForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_modify");
	$("#itemForm").submit();
})

$("#listBtn").click(function(){
	$("#itemForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=item&work=item_list");
	$("#itemForm").submit();
})

</script>

