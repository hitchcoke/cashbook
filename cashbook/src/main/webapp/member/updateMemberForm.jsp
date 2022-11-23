<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %>

<%
	if(session.getAttribute("resultMember")==null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	Member loginMember = (Member)session.getAttribute("resultMember"); 	

	
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	
<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<title>memberupdate</title>
</head>
<body>
	<br>
	
	<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded"> 회원정보 수정 </h1>
	<div><%=loginMember.getMemberId() %> 님의 정보수정 </div>
	<br>
	<label for="exampleFormControlInput1" class="form-label">&nbsp;&nbsp;&nbsp;이름</label>
	<br>
	<form action="<%=request.getContextPath()%>/member/updateMemberAction.jsp" method="post">
		<input type="text" name="memberName" class="form-control">
		<br>
		&nbsp;&nbsp;&nbsp;<button type="submit" class="btn btn-outline-primary">확인</button>
	</form>
</body>
</html>