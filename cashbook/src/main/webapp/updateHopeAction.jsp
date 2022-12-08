<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@page import="java.sql.*" %>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>  
<%	
	Member loginMember = (Member)session.getAttribute("resultMember"); 
	int hope= Integer.parseInt(request.getParameter("hope"));
	String p= request.getParameter("page");
	
	MemberDao member = new MemberDao();
	member.updateHope(hope, loginMember.getMemberId());
	
	Member resultMember= new Member();
	resultMember=member.memberOneList(loginMember.getMemberId());
	
	
	session.setAttribute("resultMember", resultMember);
	
	if(p.equals("list")){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
	}else{
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	}
%>

