<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 에러 메세지를 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => [메인으로]를 클릭한 경우 제품목록 출력페이지(product_list.jsp)로 이동 --%>
<div align="center">
	<div>
		<h3>비정상적인 방법으로 페이지를 요청 하였습니다.</h3>
		<h3>정상적인 방법으로 사이트를 이용해 주세요.</h3>
	</div>
	<div align="center">
		<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=main&work=main"  align="center" >메인으로</a>
	</div>
</div>