<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %> 

<%
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));

	Member loginMember = (Member)session.getAttribute("resultMember");


	int cashNo= Integer.parseInt(request.getParameter("cashNo"));
	CashDao cashdao= new CashDao();
	int c = cashdao.deleteCash(cashNo, loginMember.getMemberId());
	response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp?year="+year+"&month="+(month-1));
	

%>   