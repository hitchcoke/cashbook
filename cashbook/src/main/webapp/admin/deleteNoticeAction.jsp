<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %><%@ page import="dao.*" %>
    
<%
	
 	int noticeNo= Integer.parseInt(request.getParameter("noticeNo")); 
	String currentPage= request.getParameter("currentPage");

 	NoticeDao noticeDao = new NoticeDao();
 	int delete =noticeDao.deleteNotice(noticeNo);
 	
 	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp?currentPage="+currentPage);
%>
