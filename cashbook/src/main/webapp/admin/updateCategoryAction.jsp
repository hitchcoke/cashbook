<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>  
<%
	

	request.setCharacterEncoding("utf-8");
 	int categoryNo= Integer.parseInt(request.getParameter("categoryNo"));
	String categoryKind =request.getParameter("categoryKind");
	String categoryName =request.getParameter("categoryName");
 	
 	
 	
 	if(categoryKind==null||categoryKind.equals("")||categoryName==null||categoryName.equals("")){
 	    String msg = URLEncoder.encode("내용을 채워주세요  ","utf-8"); // get방식 주소창에 문자열 인코딩
 	    response.sendRedirect(request.getContextPath()+"/admin/updateCategoryForm.jsp?msg="+msg+"&categoryNo="+categoryNo);
 	    return;	
 		}

 	CategoryDao categoryDao= new CategoryDao();
 	Category c =new Category();
 	
 	c.setCategoryKind(categoryKind);
 	c.setCategoryName(categoryName);
 	c.setCategoryNo(categoryNo);
 	
 	categoryDao.updateCategory(c);
 	
 	
 	
	response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
%>