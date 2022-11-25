<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %><%@ page import="dao.*" %>

<%
	if(session.getAttribute("resultMember")==null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	Member loginMember = (Member)session.getAttribute("resultMember"); 	

	
 	String memberPw= request.getParameter("memberPw");
 	MemberDao memberdao = new MemberDao();
 	String targetpage= memberdao.deleteMember(loginMember.getMemberId(), memberPw);
 	
 	session.invalidate();
 	
 	response.sendRedirect(request.getContextPath()+targetpage);
	
%>
