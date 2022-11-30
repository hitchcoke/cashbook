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
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> list= categoryDao.selectCategory();
	


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>categoryList</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div>
		<jsp:include page="./adminMenu.jsp"></jsp:include> 
		<!-- include의 주소에는 context를 사용하지 않는다 편한 액션 중하나 -->
</div>
	<br>
	 <div class="col-md-11" style="margin: auto;">
		<h2 style=  "text-align:center">카테고리관리 </h2><br>
		<table class="table table-bordered align-middle">
				<tr class="mt-4 p-5 bg-primary text-white rounded">
					<th width=10%>번호</th>
					<th width=25%>종류</th>
					<th width=25%>내용</th>
					<th width=20%>수정일자</th>
					<th width=10%>수정</th>
					<th width=10%>삭제</th>
				</tr>
		<%for(Category c : list){ %>		
			<tr>
				<td><%=c.getCategoryNo() %></td>
				<td><%=c.getCategoryKind() %></td>
				<td><%=c.getCategoryName() %></td>
				<td><%=c.getUpdatedate() %></td>
				<td><button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/admin/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>'">수정</button> </td>     
	   			<td><button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/admin/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>'">삭제 </button> </td>        
			</tr>
		<%}%>
		</table>
		<button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='<%=request.getContextPath()%>/admin/insertCategoryForm.jsp'">카테고리 추가 </button>
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