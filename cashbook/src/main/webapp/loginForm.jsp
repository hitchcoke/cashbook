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
	<button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/insertMemberForm.jsp'">sign in </button>
<%
	if(request.getParameter("msg")!=null){
%>
	<br><div class="alert alert-primary" role="alert"><%=request.getParameter("msg")%></div>
<%
}%>	<br>
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
  			<ul class="pagination justify-content-center pagination-lg">
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
</body>
</html>