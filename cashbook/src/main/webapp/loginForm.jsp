<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import= "dao.*" %><%@page import= "vo.*" %><%@page import="java.util.*" %>
    
<%
	if(session.getAttribute("resultMember")!=null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	int currentPage= 1;
	if(request.getParameter("currentPage")!=null){
		currentPage= Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage= 5;
	int beginRow= rowPerPage*(currentPage-1);
	
	NoticeDao noticeDao= new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	int lastPage= noticeDao.selectNoticeCount(rowPerPage);
	
	

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container">		
		<div class="col-9 mx-auto">
			<br>
			<h2 style=  "text-align:center">공지사항</h2>
			<br>
			<div>
				<table class="table table-bordered align-middle">
					<tr class="mt-4 p-5 bg-primary text-white rounded">
						<th>번호</th>
						<th>내용</th>
						<th>작성일자</th>
					</tr>
					<%for(Notice n : list){ %>
					<tr>
						<td><%= n.getNoticeNo() %></td>
						<td><%= n.getNoticeMemo() %></td>
						<td><%= n.getUpdatedate() %></td>
					</tr>	
					<%} %>	
				</table>
			<div>
				<nav aria-label="Page navigation example">
		  			<ul class="pagination justify-content-center">
			    		<%if(currentPage > 1){%>	
			   				<li class="page-item">
			   				<% }else{ %>
			   				<li class="page-item disabled"><%} %>
			      				<a class="page-link" href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">Previous</a>
			    			</li>
			    		<%if(currentPage > 1){%>	
			    			<li class="page-item">
			    				<a class="page-link" href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>"><%=currentPage-1%></a></li>
			    		<%} %>
			    			<li class="page-item active" aria-current="page">
			    				<span class="page-link"><%=currentPage%></span></li>
			    		<%if(currentPage < lastPage){%>		
			    			<li class="page-item">
			    				<a class="page-link" href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>"><%=currentPage+1%></a></li>
			    		<%}
			    		  if(currentPage < lastPage){%>	
			    			<li class="page-item">
			    		<%}else{ %>
			    			<li class="page-item disabled"><%} %>
			      		   		<a class="page-link" href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">Next</a>
			    			</li>				
		 	   		</ul>
			   </nav></div>
			</div>
		</div>
	</div>
	<br>
	<div style="text-align:center">
	<img src="<%=request.getContextPath()%>/image/profile.png" style="width:100px; height:100px; border-radius: 70%;"></div>
	<br>
	<div class="container">
		<div class="col-3 mx-auto">
			<h1 style="text-align:center">로그인 </h1>
			<form method="post" action="<%=request.getContextPath()%>/loginAction.jsp">
					<input type="text" class="form-control" name="memberId" placeholder="아이디 "><br>
					<input type="password" class="form-control" name="memberPw" placeholder="비밀번호 "><br>
				<button type="submit" class="btn btn-outline-primary">로그인 </button>
			</form><br>
			<button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/insertMemberForm.jsp'">회원가입</button>
		</div>
	</div>
	<br>
<%
	if(request.getParameter("msg")!=null){
%>
	<br><div class="alert alert-primary" role="alert"><%=request.getParameter("msg")%></div>
<%
}%>	<br>
	
</body>
</html>