F<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="xyz.itwill.dao.ItemDAO"%>
<%@page import="xyz.itwill.dto.ItemDTO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/site/security/admin_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}

		String saveDirectory=request.getServletContext().getRealPath("/site/item_image");
		
		MultipartRequest multipartRequest= new MultipartRequest(request, saveDirectory
				, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());

		int category=Integer.parseInt(multipartRequest.getParameter("category"));
		String name=Utility.escapeTag(multipartRequest.getParameter("name"));
		String qty=multipartRequest.getParameter("qty");
		int price=Integer.parseInt(multipartRequest.getParameter("price"));
		String mainimage=multipartRequest.getFilesystemName("mainimage");
		String image1=multipartRequest.getFilesystemName("image1");
		String image2=multipartRequest.getFilesystemName("image2");
		String image3=multipartRequest.getFilesystemName("image3"); 
		 
		ItemDTO item=new ItemDTO();
		item.setItemNm(name);
		item.setItemQty(qty);
		item.setItemPrice(price);
		item.setCategoryNo(category);
		item.setItemMainImage(mainimage);
		item.setItemCttImage1(image1);
		item.setItemCttImage2(image2);
		item.setItemCttImage3(image3);
		

		
		int rows=ItemDAO.getDAO().insertItem(item);
		
		if(rows<=0){
			new File(saveDirectory, mainimage).delete();
			new File(saveDirectory, image1).delete();
			new File(saveDirectory, image2).delete();
			new File(saveDirectory, image3).delete();
		}
			
		//페이지 이동
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=admin&work=item_manager';");
		out.println("</script>"); 
	

		

%>