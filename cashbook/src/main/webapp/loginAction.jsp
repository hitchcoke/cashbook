<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>  
<%
	request.setCharacterEncoding("utf-8");
	
	String memberId= request.getParameter("memberId");
	String memberPw= request.getParameter("memberPw");
	
	if(request.getParameter("memberPw")==null||request.getParameter("memberId")==null||memberId.equals("")||memberPw.equals("")){
		String msg= URLEncoder.encode("아이디를 입력해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}
	
	
	
	MemberDao memberdao = new MemberDao();
	Member user= new Member();
	user.setMemberId(memberId);
	user.setMemberPw(memberPw);
	Member resultMember=new Member();
	resultMember = memberdao.login(user);
	
	String msg=URLEncoder.encode("id, pw를 확인해주세요","utf-8");
	String targetUrl="/loginForm.jsp?msg="+msg;
	
	if(resultMember.getMemberName()!=null){
		targetUrl="/cash/cashList.jsp";
		
		session.setAttribute("resultMember", resultMember);
	}
	
	
	response.sendRedirect(request.getContextPath()+targetUrl);


%>