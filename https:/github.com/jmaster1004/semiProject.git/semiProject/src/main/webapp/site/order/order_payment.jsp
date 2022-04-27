<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
<table border="1" summary="">

<tr>
	<td>
		<label for="email">결제 금액</label>
		<input id="payment1" value="" disabled="disabled">
	</td>
	<td>
		<form id="reviewWriteBtnForm" name="reviewWriteBtnForm" method="post" action="<%=request.getContextPath()%>/site/index.jsp?workgroup=order&work=order_payment_action">
		<input id="payment3" name="payment3" value="">
		<input type="hidden" id="payment2" name="payment2">
		<input type="hidden" id="payment4" name="payment4">
		<button type="submit" >입금</button>
		</form>
	</td>
</tr>


</table>
<script type="text/javascript">

	$(function() {
        document.getElementById("payment1").value = opener.document.getElementById("order_price").value;
        document.getElementById("payment2").value = opener.document.getElementById("order_price").value;
        document.getElementById("payment4").value = opener.document.getElementById("order_no").value;
    });
	
	
	
   </script>
</div>
