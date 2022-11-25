 23	%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>
<%@page import="dao.*" %>



<%
	
	 request.setCharacterEncoding("utf-8"); //인코딩
	 int cashNo= Integer.parseInt(request.getParameter("cashNo"));
	 String cashMemo= request.getParameter("cashMemo");
	 String cashPrice= request.getParameter("cashPrice");
	 int year = Integer.parseInt(request.getParameter("year"));
	 int month = Integer.parseInt(request.getParameter("month"));
	 System.out.println(year+""+month);
	 Member loginMember = (Member)session.getAttribute("resultMember"); 	
	 int categoryNo= Integer.parseInt(request.getParameter("categoryNo"));
	 
	 CashDao cashdao= new CashDao();
	 cashdao.updateCash(cashNo, cashMemo, cashPrice, categoryNo);
	 
	 //2016-04-05
	 
	 
	 
	 response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp?year="+year+"&month="+(month-1));
	 
%>