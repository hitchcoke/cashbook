<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*" %>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>  

<%
	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");

	  if(memberId == null || memberPw == null || memberId.equals("") || memberPw.equals("")) {
	      String msg = URLEncoder.encode("내용을 채워주세오  ","utf-8"); // get방식 주소창에 문자열 인코딩
	      response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
	      return;
	   }
	 MemberDao memberDao = new MemberDao(); 
	  
	 String targetPage = memberDao.insertMember(memberId, memberPw, memberName);
	 
	 response.sendRedirect(request.getContextPath()+targetPage);
%>