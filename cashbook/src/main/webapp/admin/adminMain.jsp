<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
	<%@ page import="java.util.*" %><%@page import="java.net.URLEncoder" %>
	<%@ page import="dao.*" %>
 <% 
	 
 	Member loginMember = (Member)session.getAttribute("resultMember");
  	if(loginMember==null|| loginMember.getMemberLevel() < 1 ){
  		String msg = URLEncoder.encode("권한이 없습니다 ","utf-8");
  		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg"+msg);
		return;
  	}
 	
  	//recent 공지 5개, 멤버 5명
  	
 %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminMain</title>
</head>
<body>
	<ul>
		<li><a href="">공지관리</a></li>
		<li><a href="">카테고리관리</a></li>
		<li><a href="">멤버관리</a></li>
	</ul>
</body>
</html>