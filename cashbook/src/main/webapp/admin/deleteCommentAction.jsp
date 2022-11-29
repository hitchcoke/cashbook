<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %><%@ page import="dao.*" %>
<% 

 	int commentNo= Integer.parseInt(request.getParameter("commentNo")); 

	CommentDao comment = new CommentDao();
	comment.deleteComment(commentNo);
 	
 	response.sendRedirect(request.getContextPath()+"/admin/adminHelpList.jsp");
%>
