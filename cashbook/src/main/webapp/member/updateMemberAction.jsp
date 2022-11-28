<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %><%@ page import="dao.*" %>
<%@page import="java.net.URLEncoder" %> 
<%
	if(session.getAttribute("resultMember")==null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	Member loginMember = (Member)session.getAttribute("resultMember"); 	

 	String memberName= request.getParameter("memberName");
 	
 	if(memberName==null||memberName.equals("")){
 		 String msg = URLEncoder.encode("내용을 채워주세요  ","utf-8"); // get방식 주소창에 문자열 인코딩
  	    response.sendRedirect(request.getContextPath()+"/member/updateNoticeForm.jsp?msg="+msg);
  	    return;	
  		
 	}
 	
 	MemberDao memberdao = new MemberDao();
 	String targetpage= memberdao.memberUpdate(loginMember.getMemberId(), memberName);
 	
 	
 	
 	response.sendRedirect(request.getContextPath()+targetpage);
	
%>
