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
  		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg"+msg);
		return;
	}
	
	int currentPage= 1;
	if(request.getParameter("currentPage")!=null){
		currentPage= Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage= 10;
	int beginRow= rowPerPage*(currentPage-1);
	
	MemberDao memberDao= new MemberDao();
	ArrayList<Member> list= memberDao.selecetMemberList(beginRow, rowPerPage);
	int lastPage= memberDao.selectMemberCount(rowPerPage);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberList</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li>멤버관리 </li>
	</ul>
<h2 style=  "text-align:center">멤버관리 </h2>
	<br>
	<div>
		<table class="table table-bordered align-middle">
			<tr class="mt-4 p-5 bg-primary text-white rounded">
				<th>멤버번호</th>
				<th>아이디</th>
				<th>레벨</th>
				<th>이름</th>
				<th>마지막수정일자</th>
				<th colspan="3">생성일자</th>
			</tr>
			<%for(Member m : list){ %>
			<tr>
			<% if(m.getMemberId().equals(loginMember.getMemberId())!=true){%>
				<td><%= m.getMemberNo() %></td>
				<td><%= m.getMemberId() %></td>
				<td><%= m.getMemberLevel() %></td>
				<td><%= m.getMemberName() %></td>
				<td><%= m.getUpdatedate() %></td>
				<td><%= m.getCreatedate() %></td>			
   				<td><button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/admin/deleteMemberAction.jsp?memberId=<%=m.getMemberId()%>&currentPage=<%=currentPage%>'">계정삭제</button> </td>
   				<td><form method= "post" action="<%=request.getContextPath()%>/admin/updateLevelAction.jsp">
						<input type ="hidden" name= "memberId" value="<%=m.getMemberId()%>">
						<input type= "hidden" name="currentPage" value="<%=currentPage %>">
						<select name= "memberLevel">
							<option value="0">일반 </option>
							<option value="1">관리자 </option>
						</select>
						<button type="submit">권한 수정</button>   					
   				</form></td>   
			</tr>	
			<%}
			}%>	
		</table>
	<div>
		<nav aria-label="Page navigation example">
  			<ul class="pagination justify-content-center pagination-lg">
	    		<%if(currentPage > 1){%>	
	   				<li class="page-item">
	   				<% }else{ %>
	   				<li class="page-item disabled"><%} %>
	      				<a class="page-link" href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>">Previous</a>
	    			</li>
	    		<%if(currentPage > 1){%>	
	    			<li class="page-item">
	    				<a class="page-link" href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>"><%=currentPage-1%></a></li>
	    		<%} %>
	    			<li class="page-item active" aria-current="page">
	    				<span class="page-link"><%=currentPage%></span></li>
	    		<%if(currentPage < lastPage){%>		
	    			<li class="page-item">
	    				<a class="page-link" href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>"><%=currentPage+1%></a></li>
	    		<%}
	    		  if(currentPage < lastPage){%>	
	    			<li class="page-item">
	    		<%}else{ %>
	    			<li class="page-item disabled"><%} %>
	      		   		<a class="page-link" href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>">Next</a>
	    			</li>				
 	   		</ul>
	   </nav></div>
	</div>
</body>
</html>