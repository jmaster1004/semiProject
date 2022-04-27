<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/site/security/admin_check.jspf"%>     
<%
	String pageNum="1";

	 pageNum=request.getParameter("pageNum");
%>
	
<div id="wrap">
	<div class="site-wrap" style="width:50%">
		<div
			class="xans-element- xans-board xans-board-writepackage-4 xans-board-writepackage xans-board-4 ">
			<div
				class="xans-element- xans-board xans-board-title-4 xans-board-title xans-board-4 ">
				<div class="titleArea">
					<h2>
						<font color="333333">제품등록</font>
					</h2>
	  					<p>제품등록 화면</p>
				</div>
			</div>
			<form id="itemForm" name="" action="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=item_add_action"
				method="post" enctype="multipart/form-data">
				<div
					class="xans-element- xans-board xans-board-write-4 xans-board-write xans-board-4">
					<div class="ec-base-table typeWrite ">
						<table border="1" summary="">
							<caption>글쓰기 폼</caption>
							<colgroup>
								<col style="width: 130px;">
								<col style="width: auto;">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">카테고리</th>
									<td>
										<select name="category">
											<option value="1">다이어트식품</option>
											<option value="2">건강식품</option>
											<option value="3">간편식품</option>
											<option value="4">세트</option>
											<option value="5">소스</option>
										</select>	
									</td>
								</tr>
							
								<tr>
									<th scope="row">제품명</th>
									<td>
										<input type="text" name="name" id="name" size="80">
									</td>
								</tr>
								<tr>
									<th scope="row">제품수량</th>
									<td>
										<input type="text" name="qty" id="qty">
									</td>
								</tr>
								<tr>
									<th scope="row">제품가격</th>
									<td>
										<input type="text" name="price" id="price">
									</td>
								</tr>
							<tbody class="">
								<tr>
									<th scope="row">대표이미지</th>
									<td><input name="mainimage" type="file"></td>
								</tr>
								<tr>
									<th scope="row">소개이미지1</th>
									<td><input name="image1" type="file"></td>
								</tr>
								<tr>
									<th scope="row">소개이미지2</th>
									<td><input name="image2" type="file"></td>
								</tr>
								<tr>
									<th scope="row">소개이미지3</th>
									<td><input name="image3" type="file"></td>
								</tr>
							</tbody>						
						</table>
					</div>
					<br/>
					<div class="ec-base-button ">
						<span class="gRight"> 
							 <button type="submit" class="btnSubmitFix sizeS">등록</button>
							 <a href="<%-- <%=request.getContextPath()%>/site/index.jsp?workgroup=notice&work=notice_list&pageNum=<%=pageNum %> --%>" class="btnBasicFix sizeS">취소</a>
						</span>
					</div>
				</div>
			</form>
				<div id="message" style="color: red;"></div>	
			
		</div>

	</div>
	
</div>
<script>
$("#itemForm").submit(function() {
	if($("#name").val()=="") {
		$("#message").text("제품명을 입력해 주세요.");
		$("#name").focus();
		return false;
	}
	
	if($("#qty").val()=="") {
		$("#message").text("제품수량을 입력해 주세요.");
		$("#qty").focus();
		return false;
	}
	
	if($("#price").val()=="") {
		$("#message").text("제품가격을 입력해 주세요.");
		$("#price").focus();
		return false;
	}
	
	if($("#mainimage").val()=="") {
		$("#message").text("메인이미지를 입력해 주세요.");
		$("#image").focus();
		return false;
	}
	
	if($("#image1").val()=="") {
		$("#message").text("소개이미지1을 입력해 주세요.");
		$("#image").focus();
		return false;
	}
	
	if($("#image2").val()=="") {
		$("#message").text("소개이미지2를 입력해 주세요.");
		$("#image").focus();
		return false;
	}
	
	if($("#image3").val()=="") {
		$("#message").text("소개이미지3을 입력해 주세요.");
		$("#image").focus();
		return false;
	}	

});
</script>




