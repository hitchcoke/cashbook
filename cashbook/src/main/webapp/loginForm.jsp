<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">login</h1>
	<form method="post" action="<%=request.getContextPath()%>/loginAction.jsp">
		<label for="login" class="form-label">&nbsp;Id</label>
			<input type="text" class="form-control" name="memberId">
		<label for="login" class="form-label">&nbsp;Pw</label>
			<input type="password" class="form-control" name="memberPw"><br>
		<button type="submit" class="btn btn-outline-primary">login</button>
	</form>
	<br>
	<div> <button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/insertMemberForm.jsp'">회원가입 </button></div>
<%
	if(request.getParameter("msg")!=null){
%>
	<br><div class="alert alert-primary" role="alert"><%=request.getParameter("msg")%></div>
<%
}%>	
</body>
</html>