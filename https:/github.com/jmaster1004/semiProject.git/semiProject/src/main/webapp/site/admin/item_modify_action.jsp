<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="xyz.itwill.dao.ItemDAO"%>
<%@page import="xyz.itwill.dto.ItemDTO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/site/security/admin_check.jspf"%>     
<%
		//비정상적인 요청에 대한 응답 처리
		if(request.getMethod().equals("GET")) {
			out.println("<script type='text/javascript'>");
			out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400';");
			out.println("</script>");

		}

		String saveDirectory=request.getServletContext().getRealPath("/site/item_image");
		
		MultipartRequest multipartRequest= new MultipartRequest(request, saveDirectory
				, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());

		int num=Integer.parseInt(multipartRequest.getParameter("num"));
		int category=Integer.parseInt(multipartRequest.getParameter("category"));
		String name=Utility.escapeTag(multipartRequest.getParameter("name"));
		String qty=multipartRequest.getParameter("qty");
		int price=Integer.parseInt(multipartRequest.getParameter("price"));
	 	String mainimage=multipartRequest.getParameter("mainimage");
		String image1=multipartRequest.getFilesystemName("image1");
		String image2=multipartRequest.getFilesystemName("image2");
		String image3=multipartRequest.getFilesystemName("image3"); 
		
		String curmainimage=multipartRequest.getParameter("curmainimage");
		String curimage1=multipartRequest.getParameter("curimage1");
		String curimage2=multipartRequest.getParameter("curimage2");
		String curimage3=multipartRequest.getParameter("curimage3");
		
		
		ItemDTO item=new ItemDTO();
		item.setItemCd(num);
		item.setItemNm(name);
		item.setItemQty(qty);
		item.setItemPrice(price);
		item.setCategoryNo(category);		
		if(mainimage!=null){
			item.setItemMainImage(mainimage);			
			new File(saveDirectory, curmainimage).delete();
		}else{
			item.setItemMainImage(curmainimage);
		}
		if(image1!=null){
			item.setItemCttImage1(image1);			
			new File(saveDirectory, curimage1).delete();
		}else{
			item.setItemCttImage1(curimage1);
		}
		if(image2!=null){
			item.setItemCttImage2(image2);			
			new File(saveDirectory, curimage2).delete();
		}else{
			item.setItemCttImage2(curimage2);
		}
		if(image3!=null){
			item.setItemCttImage3(image3);			
			new File(saveDirectory, curimage3).delete();
		}else{
			item.setItemCttImage3(curimage3);
		}	
/* 		

 		item.setItemMainImage(mainimage);
		item.setItemCttImage1(image1);
		item.setItemCttImage2(image2);
		item.setItemCttImage3(image3); 
		item.setItemCd(num);  */
		
		ItemDAO.getDAO().updateItem(item);
			
		//페이지 이동
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=admin&work=item_detail&num="+num+"';");
		out.println("</script>"); 
%>