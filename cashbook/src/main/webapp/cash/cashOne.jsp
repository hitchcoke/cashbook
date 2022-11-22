<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %> 
<%
	if(session.getAttribute("resultMember")==null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	Member loginMember = (Member)session.getAttribute("resultMember"); 	


	int year= Integer.parseInt(request.getParameter("year"));
	int month= Integer.parseInt(request.getParameter("month"));
	int date= Integer.parseInt(request.getParameter("date"));
	

    
	   // Model 호출 : 일별 cash 목록
    CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(year, month, loginMember.getMemberId());
	    // View : 달력출력 + 일별 cash 목록 출력
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<title>cashOne</title>
</head>
<body>
	<h2 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">
      <%=year%>년 <%=month%> 월
   </h2>
   <div>
   	<br>
   	<br>
   	<table class="table table-bordered align-middle">
   		<%for(HashMap<String, Object> m : list){ %>  
         <tr>  		
            <% String cdate= (String)m.get("cashdate");
         		if(Integer.parseInt(cdate.substring(8))==date){%>
         			<td><%=m.get("categoryName")%><br></td>
					<td><%=m.get("categoryKind")%><br></td>
					<td><%=m.get("cashMemo")%><br></td>
					<td><%=m.get("cashPrice")+"원"%></td>
					<td><button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/cash/cashUpdateForm.jsp?cashNo=<%=m.get("cashNo")%>&year=<%=year%>&month=<%=month%>'">수정</button>      
   					<button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/cash/deleteCashAction.jsp?cashNo=<%=m.get("cashNo")%>&year=<%=year%>&month=<%=month%>'">삭제 </button> </td>        
	
         	<%} %>
         	
         </tr>
        <%}%>
    </table>    
   </div>
</body>
</html>