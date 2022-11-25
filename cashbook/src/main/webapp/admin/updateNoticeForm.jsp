<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %><%@page import="java.net.URLEncoder" %>  
<%@page import="dao.*" %>
<%
	Member loginMember = (Member)session.getAttribute("resultMember");
	if(loginMember==null|| loginMember.getMemberLevel() < 1 ){
	String msg = URLEncoder.encode("권한이 없습니다 ","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg"+msg);
	return;
	}
 	String currentPage= request.getParameter("currentPage");
 	String noticeNo= request.getParameter("noticeNo");
 	
 	NoticeDao noticeDao= new NoticeDao();
 	Notice notice =noticeDao.noticeOneList(noticeNo);
 	System.out.println(currentPage);
 	
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	
<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<title>noticeUpdateForm</title>
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
	<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">공지사항 수정 </h1>
	<br>
	<div>&nbsp;&nbsp;&nbsp;<%=notice.getNoticeNo()%>번 공지수정 </div><br>
	<label for="exampleFormControlInput1" class="form-label">&nbsp;&nbsp;&nbsp;내용 </label>
	<br>
	<form action="<%=request.getContextPath()%>/admin/updateNoticeAction.jsp" method="post">
		<textarea name="noticeMemo" placeholder="<%=notice.getNoticeMemo() %>" ></textarea>
		<br>
		<input type="hidden" name="currentPage" value="<%=currentPage%>">
		<input type="hidden" name="noticeNo" value="<%=notice.getNoticeNo()%>">
		&nbsp;&nbsp;&nbsp;<button type="submit" class="btn btn-outline-primary">확인</button>
	</form>
</body>
</html>