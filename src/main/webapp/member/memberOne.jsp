<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %><%@page import="java.net.URLEncoder" %>
<%@ page import="dao.*" %>

<%
	if(session.getAttribute("resultMember")==null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	Member loginMember = (Member)session.getAttribute("resultMember"); 	
	MemberDao memberdao = new MemberDao();
	Member member= memberdao.memberOneList(loginMember.getMemberId());
	
	
	
	
 	
 	
 	
 	%>			
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	
<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

<title>memberOne</title>
</head>
<body>
	<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">내정보</h1>
	
	<div class="card" style="width: 18rem; margin:0 auto; ;">
  		<img src="<%=request.getContextPath()%>/image/face.png" class="card-img-top">
		<div class="card-body">
		    <h5 class="card-title">이름:&nbsp;<%=member.getMemberName()%></h5>
		    <p class="card-text">아이디:&nbsp;<%=loginMember.getMemberId()%></p>
		    <p class="card-text">회원가입일 :&nbsp;<%=member.getCreatedate()%></p>
		   <div class="btn-group">
			  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
			    정보수정
			  </button>
			  <ul class="dropdown-menu">
			    <li><a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">개인정보 수정</a></li>
			    <li><a href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp">회원탈퇴</a></li>
			  </ul>
			</div>
	    </div>
	 </div>
</body>
</html>	   
	  