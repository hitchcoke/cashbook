<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>  
<%
	request.setCharacterEncoding("utf-8");
 	String currentPage= request.getParameter("currentPage");
 	int noticeNo= Integer.parseInt(request.getParameter("noticeNo"));
 	String noticeMemo = request.getParameter("noticeMemo");
 	
 	System.out.println(currentPage);
 	
 	NoticeDao noticeDao= new NoticeDao();
 	int update= noticeDao.updatNotice(noticeMemo, noticeNo);
 	
 	
	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp?currentPage="+currentPage);
%>