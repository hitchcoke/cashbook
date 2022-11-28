<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %><%@page import="java.net.URLEncoder" %>  
<%@page import="dao.*" %>
<%
	Member loginMember = (Member)session.getAttribute("resultMember");
	if(loginMember==null|| loginMember.getMemberLevel() < 1 ){
	String msg = URLEncoder.encode("권한이 없습니다 ","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
	return;
	}
 	String categoryNo= request.getParameter("categoryNo");
 	
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	
<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<title>categoryUpdateForm</title>
</head>
<body>
	<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">카테고리 수정 </h1>
	<br>
	<br>
	<form method="post" action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp">
		<div class="container">
		<label for="exampleFormControlInput1" class="form-label">&nbsp;카테고리종류</label><br>
  			<input type="radio" name="categoryKind" value="지출"> 💸 지출
			<input type="radio" name="categoryKind" value="수입"> 💰 수입<br><br>
  		<label for="exampleFormControlInput1" class="form-label">&nbsp;카테고리이름 </label><br>
  			<input type="text"  name="categoryName"  class="form-control" >
  			<input type="hidden" name="categoryNo" value="<%=categoryNo%>">
		<div class="d-grid gap-2 mt-5">
			<button type="submit" class="btn btn-outline-primary">수정 </button>
		</div>
		</div>
	</form>
	
	<%
		if(request.getParameter("msg")!=null){
	%>
		<br><div class="alert alert-primary" role="alert"><%=request.getParameter("msg")%></div>
	<% 			
		}
	%>
</body>
</html>