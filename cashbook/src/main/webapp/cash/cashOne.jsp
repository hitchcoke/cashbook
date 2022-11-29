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
	String mon= ""+month;
if(month<10){
	mon="0"+month;
}
    
	   // Model 호출 : 일별 cash 목록
    CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selecetCashListByDate(loginMember.getMemberId(), year, month, date);
	    // View : 달력출력 + 일별 cash 목록 출력
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> ct= categoryDao.selectCategory();
	    
	
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
      <%=year%>년 <%=month%> 월 <%=date %>일  
   </h2>
   <div>
   	<br>
   	<table class="table table-bordered align-middle">
   		<tr class="mt-4 p-5 bg-primary text-white rounded">
   			<th>카테고리 종류 </th>
   			<th>카테고리 이름 </th>
   			<th>액수 </th>
   			<th>메모 </th>
   			<th>수정</th>
   			<th>삭제 </th>
   		</tr>
   		<%for(HashMap<String, Object> m : list){ %>  
         <tr>  		
         		<td><%=m.get("categoryName")%><br></td>
				<td>
				<%if(m.get("categoryKind").equals("지출")){%>
							💸
							<%}else{ %>
							💰
							<%} %> 
				<%=m.get("categoryKind")%>
				<br></td>
				<td><%=m.get("cashPrice")+"원"%><br></td>
				<td><%=m.get("cashMemo")%><br></td>
				<td><button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/cash/cashUpdateForm.jsp?cashNo=<%=m.get("cashNo")%>&year=<%=year%>&month=<%=month%>'">수정</button> </td>     
   				<td><button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/cash/deleteCashAction.jsp?cashNo=<%=m.get("cashNo")%>&year=<%=year%>&month=<%=month%>'">삭제 </button> </td>        
         </tr>
        <%}%>
    </table>    
   </div><br>
   	<div class="container">
		<div class="col-6 mx-auto">
		<h1>가계부 추가 </h1>
		   <form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
		   		<table>
		   			<tr>
						<td>카테고리 </td>
						<td>
							<select name= "categoryNo">
								<%for(Category c : ct){ %>	
									<option value="<%=c.getCategoryNo()%>"><%=c.getCategoryKind()%>&nbsp;
									<%if(c.getCategoryKind().equals("지출")){%>
									💸
									<%}else{ %>
									💰
									<%} %> 
									<%=c.getCategoryName()%></option>
									
								<%} %>
							<!-- 카테고리 목록출 -->
							</select>
						</td>   			
		   			</tr>
		   			<tr>
		   				<td>날짜 </td>
		   				<td><input type="text" name= "cashdate" class="form-control" value="<%=year%>-<%=mon%>-<%=date%>" readonly="readonly"></td>
		   			</tr>
		   			<tr>
		   				<td>액수 </td>
		   				<td><input type="text" name= "cashPrice" class="form-control"></td>
		   			</tr>
		   			<tr>
		   				<td>메모 </td>
		   				<td>
		   					<textarea rows="3" cols="50" name="cashMemo" class="form-control"></textarea>
		   				</td>
		   			</tr>
		   		</table>
		   			<button type="submit" class="btn btn-outline-primary btn-lg">추가</button>      
		   </form>
		</div>
	</div>
</body>
</html>