<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %><%@ page import="dao.*" %>
<%@page import="java.net.URLEncoder" %>  

<%
	Member loginMember = (Member)session.getAttribute("resultMember");
	if(loginMember==null|| loginMember.getMemberLevel() < 1 ){
		String msg = URLEncoder.encode("권한이 없습니다 ","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg"+msg);
		return;
	}
	int memberLevel = Integer.parseInt(request.getParameter("memberLevel"));
	String currentPage= request.getParameter("currentPage");
 	String memberId=request.getParameter("memberId");
 	MemberDao memberdao = new MemberDao();
	
 	String update = memberdao.updateLevelAction(memberId, loginMember.getMemberId(), memberLevel);
 	System.out.println(update);
	
 	
 	
 	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp?currentPage"+currentPage);
	
%>
