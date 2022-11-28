<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>  
<%
	request.setCharacterEncoding("utf-8");
 	
 	String noticeMemo= request.getParameter("noticeMemo");
 	
 	if(noticeMemo.equals("")||noticeMemo==null) {
 	    String msg = URLEncoder.encode("내용을 채워주세요  ","utf-8"); // get방식 주소창에 문자열 인코딩
 	    response.sendRedirect(request.getContextPath()+"/insertNoticeForm.jsp?msg="+msg);
 	    return;	
 		}
 	
 	NoticeDao noticeDao= new NoticeDao();
 	int insert = noticeDao.insertNotice(noticeMemo);
 	
 	
	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
%>