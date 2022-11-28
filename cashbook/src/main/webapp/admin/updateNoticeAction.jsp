<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>  
<%
	

	request.setCharacterEncoding("utf-8");
 	String currentPage= request.getParameter("currentPage");
 	int noticeNo= Integer.parseInt(request.getParameter("noticeNo"));
 	String noticeMemo = request.getParameter("noticeMemo");
 	
 	
 	
 	if(noticeMemo==null||noticeMemo.equals("")){
 	    String msg = URLEncoder.encode("내용을 채워주세요  ","utf-8"); // get방식 주소창에 문자열 인코딩
 	    response.sendRedirect(request.getContextPath()+"/updateNoticeForm.jsp?msg="+msg+"&noticeNo="+noticeNo+"&currentPage="+currentPage);
 	    return;	
 		}
 	
 	System.out.println(currentPage);
 	
 	NoticeDao noticeDao= new NoticeDao();
 	int update= noticeDao.updatNotice(noticeMemo, noticeNo);
 	
 	
	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp?currentPage="+currentPage);
%>