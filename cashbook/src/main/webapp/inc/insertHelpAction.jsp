<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>  
<%
	request.setCharacterEncoding("utf-8");
 	
 	String helpMemo= request.getParameter("helpMemo");
 	
	if(session.getAttribute("resultMember")==null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
   
    Member loginMember = (Member)session.getAttribute("resultMember"); 	

 	if(helpMemo.equals("")||helpMemo==null) {
 	    String msg = URLEncoder.encode("내용을 채워주세요  ","utf-8"); // get방식 주소창에 문자열 인코딩
 	    response.sendRedirect(request.getContextPath()+"/inc/insertHelpForm.jsp?msg="+msg);
 	    return;	
 		}
 	
 	HelpDao helpdao= new HelpDao();
 	helpdao.insertHelp(loginMember.getMemberId(), helpMemo);
 	
	response.sendRedirect(request.getContextPath()+"/member/memberOne.jsp");
%>