<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>
<%@page import="dao.*" %>



<%
	
	 request.setCharacterEncoding("utf-8"); //인코딩
	 String cashdate= request.getParameter("cashdate");
	 String cashMemo= request.getParameter("cashMemo");
	 String cashPrice= request.getParameter("cashPrice");
	 System.out.println(cashdate);
	 Member loginMember = (Member)session.getAttribute("resultMember"); 	
	 int categoryNo= Integer.parseInt(request.getParameter("categoryNo"));
	 
	 String year= cashdate.substring(0, 4);
	 int month= Integer.parseInt(cashdate.substring(5, 7));
	 
	 if(request.getParameter("cashMemo")==null||request.getParameter("cashMemo").equals("")||
				request.getParameter("cashPrice")==null||request.getParameter("cashPrice").equals("")){
				String msg = URLEncoder.encode("내용을 채워주세요  ","utf-8"); // get방식 주소창에 문자열 인코딩
				response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp?msg="+msg+"&year="+year+"&month="+(month-1));
				return;	
				}
	 
	 CashDao cashdao= new CashDao();
	 cashdao.insertCash(cashdate, cashMemo, cashPrice, categoryNo, loginMember.getMemberId());
	
	 //2016-04-05

	 
	 
	 response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp?year="+year+"&month="+(month-1));
	 
%>