 23	%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>
<%@page import="dao.*" %>



<%
	
	
	 request.setCharacterEncoding("utf-8"); 
	 int date = Integer.parseInt(request.getParameter("date"));
	 int cashNo= Integer.parseInt(request.getParameter("cashNo"));
	 String cashMemo= request.getParameter("cashMemo");
	 String cashPrice= request.getParameter("cashPrice");
	 int year = Integer.parseInt(request.getParameter("year"));
	 int month = Integer.parseInt(request.getParameter("month"));
	 System.out.println(year+""+month);
	 Member loginMember = (Member)session.getAttribute("resultMember"); 	
	 int categoryNo= Integer.parseInt(request.getParameter("categoryNo"));
	 
	 if(request.getParameter("cashMemo")==null||request.getParameter("cashMemo").equals("")||
		request.getParameter("cashPrice")==null||request.getParameter("cashPrice").equals("")){
		 String msg = URLEncoder.encode("내용을 채워주세요  ","utf-8");  //
		response.sendRedirect(request.getContextPath()+"/cash/cashUpdateForm.jsp?msg="+msg+"&year="+year+"&month="+month+"&cashNo="+cashNo+"&date="+date);
		return;	
		}
	 
	 
	 CashDao cashdao= new CashDao();
	 int row=cashdao.updateCash(cashNo, cashMemo, cashPrice, categoryNo);
	 System.out.println(row);
	 //2016-04-05
	 
	 
	 
	 response.sendRedirect(request.getContextPath()+"/cash/cashOne.jsp?year="+year+"&month="+month+"&date="+date);
	 
%>