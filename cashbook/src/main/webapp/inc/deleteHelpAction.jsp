<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %><%@ page import="dao.*" %>
<% 

 	int helpNo= Integer.parseInt(request.getParameter("helpNo")); 

	HelpDao helpdao =new HelpDao();
	helpdao.deleteHelp(helpNo);
 	
 	response.sendRedirect(request.getContextPath()+"/inc/helpList.jsp");
%>
