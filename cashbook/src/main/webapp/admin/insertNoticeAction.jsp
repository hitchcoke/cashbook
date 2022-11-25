<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>  
<%
	request.setCharacterEncoding("utf-8");
 	
 	String noticeMemo= request.getParameter("noticeMemo");
 	
 	NoticeDao noticeDao= new NoticeDao();
 	int insert = noticeDao.insertNotice(noticeMemo);
 	
 	
	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
%>