<%@page import="xyz.itwill.dto.categoryDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.categoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}	
 
 	String orderNO = request.getParameter("orderNO");
 	String orderStatus = request.getParameter("orderStatus");
 %>

<form id="categoryForm" name="categoryForm" >
	<div>
		<h2 style="text-align:center">주문 상태 관리</h2>
	</div>
	
	<div>
		<table>
			<tr>
				<th>상태 변경창</th>
				<td>
					<select id="category_chios" name="category_chios" >
						<option value="" selected="selected">주문 상태</option>
						<option value="1">입금 대기</option>
						<option value="2">입금 완료</option>
						<option value="11">배송 준비중</option>
						<option value="12">배송 중</option>
						<option value="13">배송 완료</option>
						<option value="21">취소 신청</option>
						<option value="22">취소 완료</option>
						<option value="23">교환 신청</option>
						<option value="24">교환 완료</option>
						<option value="25">반품 신청</option>
						<option value="26">반품 완료</option>
						<option value="27">환불 신청</option>
						<option value="28">환불 완료</option>
					</select>
					
					<button type="button" id="cago_update">수정</button>
					<input type="hidden" id="orderNO" name="orderNO" value="<%= orderNO%>">
					<input type="hidden" id="cago_update_val" name="cago_update_val" value="">
				</td>
			</tr>
		</table>	
	</div>
</form>
<script type="text/javascript">

	$("select[name=category_chios]").change(function() {

		var chios = $(this).val();
		$("#category_input").val(chios);

	});

	$("#cago_update").click(function() {
		var chios = $("select[name=category_chios] option:selected").val();
		$("#cago_update_val").val(chios);
		
	    $("#categoryForm").attr("method", "post");
		$("#categoryForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_orderStatus_update_action");
		$("#categoryForm").submit();
	});

</script>
</body>
