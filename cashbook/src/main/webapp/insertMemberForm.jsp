<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("resultMember")!=null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertMemberForm</title>
<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	
<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	
</head>
<body>

<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">SIGN IN </h1>
	<br>
	<br>
	<form action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
		<div class="container">
		<label for="exampleFormControlInput1" class="form-label">&nbsp;id</label>
  			<input type="text" class="form-control" name="memberId"><!-- plaecholder로 들어갈 부서넘버의 예시를 알려준다 -->
  		<label for="exampleFormControlInput1" class="form-label">&nbsp;password</label>
  			<input type="password" class="form-control" name="memberPw">
  		<label for="exampleFormControlInput1" class="form-label">&nbsp;name</label>
  			<input type="text" class="form-control" name="memberName"><!-- plaecholder로 들어갈 부서넘버의 예시를 알려준다 -->
  		
		<div class="d-grid gap-2 mt-5">
			<button type="submit" class="btn btn-outline-primary">추가</button>
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