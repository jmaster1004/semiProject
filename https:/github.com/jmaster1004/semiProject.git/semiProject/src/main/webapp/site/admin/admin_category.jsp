<%@page import="xyz.itwill.dto.categoryDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.categoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%


 	List<categoryDTO> cagoList= categoryDAO.getDAO().selectAllCategoryList();
 %>

<form id="categoryForm" name="categoryForm" >
	<div>
		<h2 style="text-align:center">카테고리 관리</h2>
	</div>
	
	<div>
		<table>
			<tr>
				<th>카테고리 조회창</th>
				<td>
					<select id="category_chios" name="category_chios" >
						<option value="" selected="selected">카테고리 선택</option>
						<%
						for(categoryDTO category:cagoList){
						%>
						<option value="<%= category.getCategogyName() %>"><%= category.getCategogyName() %></option>
						<%}%>
					</select>
					<input type="hidden" id="cago_delete_val" name="cago_delete_val" value="">
					<input type="hidden" id="cago_update_val" name="cago_update_val" value="">
					<button type="button" id="cago_delete">삭제</button>
				</td>
			</tr>
			<tr>
				<th>카테고리 입력창</th>
				<div>
					<td>
						<div>
						<input id="category_input" name="category_input" value="">
						<button type="button" id="cago_insert">추가</button>
						<button type="button" id="cago_update">수정</button>
						</div>
					</td>
				</div>
			</tr>
		</table>	
	</div>
</form>
<script type="text/javascript">

	$("select[name=category_chios]").change(function() {

		var chios = $(this).val();
		$("#category_input").val(chios);

	});
	
	
	$("#cago_delete").click(function() {
		var chios = $("select[name=category_chios] option:selected").val();
		$("#cago_delete_val").val(chios);
		if(!chios==null) {
	    	$("#categoryForm").attr("method", "post");
			$("#categoryForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_category_delete_action");
			$("#categoryForm").submit();
		} else{
			alert("삭제할 카테고리를 선택해주세요");
		}
	});
	
	$("#cago_insert").click(function() {
		
		var insert = $("#category_input").val();
		if(!insert==null) {
		    $("#categoryForm").attr("method", "post");
			$("#categoryForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_category_insert_action");
			$("#categoryForm").submit();
		} else{
			alert("공백은 놉..");
		}
	});
	
	$("#cago_update").click(function() {
		var chios = $("select[name=category_chios] option:selected").val();
		$("#cago_update_val").val(chios);
		
		if(!chios==null) {
		    $("#categoryForm").attr("method", "post");
			$("#categoryForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_category_update_action");
			$("#categoryForm").submit();
		} else{
			alert("공백은 놉..");
		}
	});

</script>
</body>
