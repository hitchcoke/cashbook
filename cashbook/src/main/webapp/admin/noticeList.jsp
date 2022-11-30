<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*" %>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>  
<%
	Member loginMember = (Member)session.getAttribute("resultMember");
	if(loginMember==null|| loginMember.getMemberLevel() < 1 ){
		String msg = URLEncoder.encode("권한이 없습니다 ","utf-8");
  		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}
	
	int currentPage= 1;
	if(request.getParameter("currentPage")!=null){
		currentPage= Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage= 10;
	int beginRow= rowPerPage*(currentPage-1);
	
	NoticeDao noticeDao= new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	int lastPage= noticeDao.selectNoticeCount(rowPerPage);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeList</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div>
		<jsp:include page="./adminMenu.jsp"></jsp:include> 
		<!-- include의 주소에는 context를 사용하지 않는다 편한 액션 중하나 -->
</div>
<br>

<h2 style=  "text-align:center">공지사항 관리 </h2>
	<br>
	<div class="col-md-11" style="margin: auto;">
		<table class="table table-bordered align-middle">
			<tr class="mt-4 p-5 bg-primary text-white rounded">
				<th width=5%>번호</th>
				<th>내용</th>
				<th width=15%>작성일자</th>
				<th width=10%>수정</th>
				<th width=10%>삭제</th>
			</tr>
		<%for(Notice n : list){ %>
			<tr>
				<td><%= n.getNoticeNo() %></td>
				<td><%= n.getNoticeMemo() %></td>
				<td><%= n.getUpdatedate() %></td>
				<td><button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>&currentPage=<%=currentPage%>'">수정</button> </td>     
   				<td><button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/admin/deleteNoticeAction.jsp?noticeNo=<%=n.getNoticeNo()%>&currentPage=<%=currentPage%>'">삭제 </button> </td>        
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
	      				<a class="page-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>">Previous</a>
	    			</li>
	    		<%if(currentPage > 1){%>	
	    			<li class="page-item">
	    				<a class="page-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>"><%=currentPage-1%></a></li>
	    		<%} %>
	    			<li class="page-item active" aria-current="page">
	    				<span class="page-link"><%=currentPage%></span></li>
	    		<%if(currentPage < lastPage){%>		
	    			<li class="page-item">
	    				<a class="page-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>"><%=currentPage+1%></a></li>
	    		<%}
	    		  if(currentPage < lastPage){%>	
	    			<li class="page-item">
	    		<%}else{ %>
	    			<li class="page-item disabled"><%} %>
	      		   		<a class="page-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>">Next</a>
	    			</li>				
 	   		</ul>
	   </nav></div>
	   <button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='<%=request.getContextPath()%>/admin/insertNoticeForm.jsp?currentPage=<%=currentPage%>'">공지 작성 </button>
	   
	</div>
	
	
	<%
		if(request.getParameter("msg")!=null){
	%>
		<div class="alert alert-primary" role="alert"><%=request.getParameter("msg")%></div>
	<% 			
		}
	%>
	
</body>
</html>