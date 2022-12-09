<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@page import="java.sql.*" %>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>  
<%	
	String p= request.getParameter("page");
	if(request.getParameter("hope")==null||request.getParameter("hope").equals("")){
		 String msg = URLEncoder.encode("내용을 채워주세요  ","utf-8"); // get방식 주소창에 문자열 인코딩
		 if(p.equals("list")){
				response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp?msg="+msg);
			}else{
				response.sendRedirect(request.getContextPath()+"/home.jsp?msg="+msg);
			}
	 	    return;	
	}

	Member loginMember = (Member)session.getAttribute("resultMember"); 
	int hope= Integer.parseInt(request.getParameter("hope"));
	
	
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

