<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*" %>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>  
<%

if(session.getAttribute("resultMember")==null){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}

Member loginMember = (Member)session.getAttribute("resultMember"); 	

CategoryDao categoryDao = new CategoryDao();
ArrayList<Category> ct= categoryDao.selectCategory();

request.setCharacterEncoding("utf-8");
int cashNo= Integer.parseInt(request.getParameter("cashNo"));
int year = Integer.parseInt(request.getParameter("year"));
int month = Integer.parseInt(request.getParameter("month"));
System.out.println(year+""+month);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCashForm</title>
<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	
<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<style>
		textarea {
			width: 100%;
			height: 200px;
			padding: 10px;
			box-sizing: border-box;
			border: solid 2px gray;
			border-radius: 5px;
			font-size: 16px;
			resize: both;
		}
	</style>
</head>
<body>
	
<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">내용 수정</h1>
	<br>
	<br>
	<form action="<%=request.getContextPath()%>/cash/cashUpdateAction.jsp" method="post">
		<div class="container">
		<select name= "categoryNo">
						<%for(Category c : ct){ %>	
							<option value="<%=c.getCategoryNo()%>"><%=c.getCategoryKind()%>&nbsp;
							<%if(c.getCategoryKind().equals("지출")){%>
							💸
							<%}else{ %>
							💰
							<%} %> 
							<%=c.getCategoryName()%></option>
							
						<%} %>
					<!-- 카테고리 목록출 -->
					</select><br>
		<label for="exampleFormControlInput1" class="form-label">&nbsp;내용 </label>
  			<input type="text" class="form-control" name="cashMemo"><!-- plaecholder로 들어갈 부서넘버의 예시를 알려준다 -->
  		<label for="exampleFormControlInput1" class="form-label">&nbsp;비용 </label>
  			<input type="text" class="form-control" name="cashPrice">
		<div class="d-grid gap-2 mt-5">
		<input type="hidden" name="cashNo" value="<%=cashNo%>">
		<input type="hidden" name="month" value="<%=month%>">
		<input type="hidden" name="year" value="<%=year%>">
			<button type="submit" class="btn btn-outline-primary">수정</button>
		</div>
		</div>
	</form>
	<%
		if(request.getParameter("msg")!=null){
	%>
		<div class="alert alert-primary" role="alert"><%=request.getParameter("msg")%></div>
	<% 			
		}
	%>
	
</body>
</html>