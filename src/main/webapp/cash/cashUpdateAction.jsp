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
	 
	 if(request.getParameter("cashMemo")==null||request.getParameter("cashMemo").equals("")||
		request.getParameter("cashPrice")==null||request.getParameter("cashPrice").equals("")){
		String msg = URLEncoder.encode("내용을 채워주세요  ","utf-8"); // get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/updateNoticeForm.jsp?msg="+msg+"&year="+year+"&month="+month+"&cashNo="+cashNo);
		return;	
		}
	 
	 
	 CashDao cashdao= new CashDao();
	 cashdao.updateCash(cashNo, cashMemo, cashPrice, categoryNo);
	 
	 //2016-04-05
	 
	 
	 
	 response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp?year="+year+"&month="+(month-1));
	 
%>