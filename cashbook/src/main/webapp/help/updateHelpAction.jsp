<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>  
<%
	

	request.setCharacterEncoding("utf-8");
 	
 	int helpNo= Integer.parseInt(request.getParameter("helpNo"));
 	String helpMemo = request.getParameter("helpMemo");
 	
 	
 	
 	if(helpMemo==null||helpMemo.equals("")){
 	    String msg = URLEncoder.encode("내용을 채워주세요  ","utf-8"); // get방식 주소창에 문자열 인코딩
 	    response.sendRedirect(request.getContextPath()+"/help/updateHelpForm.jsp?msg="+msg);
 	    return;	
 		}
 	
	HelpDao helpDao = new HelpDao();
	helpDao.updateHelp(helpNo, helpMemo);
 	
 	
	response.sendRedirect(request.getContextPath()+"/member/memberOne.jsp");
%>