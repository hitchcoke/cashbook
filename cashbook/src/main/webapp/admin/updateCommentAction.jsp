<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>  
<%
	request.setCharacterEncoding("utf-8");
 	
 	String commentMemo= request.getParameter("commentMemo");
 	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
 	
	if(session.getAttribute("resultMember")==null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
   
    Member loginMember = (Member)session.getAttribute("resultMember"); 	

 	if(commentMemo.equals("")||commentMemo==null) {
 	    String msg = URLEncoder.encode("내용을 채워주세요  ","utf-8"); // get방식 주소창에 문자열 인코딩
 	    response.sendRedirect(request.getContextPath()+"/admin/updateCommentForm.jsp?msg="+msg+"&commentNo="+commentNo);
 	    return;	
 		}
 	
 	CommentDao comment = new CommentDao();
 	comment.updateComment(commentNo, commentMemo, loginMember.getMemberId());
 	
	response.sendRedirect(request.getContextPath()+"/admin/adminHelpList.jsp");
%>