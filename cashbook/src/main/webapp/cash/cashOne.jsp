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

	<link rel="stylesheet" href="../bootstrap/table/css/style.css">

<title>cashOne</title>
</head>
<body>
	<div>	
		<jsp:include page="/nav.jsp"></jsp:include> 
		<!-- include의 주소에는 context를 사용하지 않는다 편한 액션 중하나 -->
	</div>
	<br>
	<h2 style="text-align:center">
      <%=year%>년 <%=month%>월 <%=date %>일  
   </h2>
   <br>
   <br>
   <div class="container px-11">
   <div class="row">
   			 
  		<div class="col-4">	
			<h5>&nbsp;가계부 추가 </h5>
			   <form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post" id="cashinsert">
			   <input type="hidden" value="<%=date%>" name="date">
			   		<table>
			   			<tr>
							<td>
								&nbsp;&nbsp;<select name= "categoryNo">
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
			   				<td><input type="text" name= "cashdate" class="form-control" value="<%=year%>-<%=mon%>-<%=date%>" readonly="readonly">
			   				</td>
			   			</tr>
			   			<tr>
			   				
			   				<td>
			   				<div class="form-floating mb-3">
			   				<input type="text" name= "cashPrice" class="form-control" id="floatingInput" placeholder="액수">
			   				<label for="floatingInput">액수 </label> </div></td>
			   				
			   			</tr>
			   			<tr>
			   				<td>
			   					<textarea rows="3" cols="50" name="cashMemo" class="form-control"placeholder="내용 " id="text"></textarea>
			   				</td>
			   			</tr>
			   		</table>
			   			<button class="btn btn-outline-primary btn-lg" id="Btn">추가</button>      
			   </form>
			</div>
		
		 <div class="col-8">
		 
			<table class="table w-auto pr-4" style="width:100%">
		   		<tr class="mt-3 p-4 bg-primary text-white rounded">
		   			<th width="12%">이름 </th>
		   			<th width="12%">종류 </th>
		   			<th width="18%">액수 </th>
		   			<th>메모 </th>
		   			<th width="17%">수정</th>
		   			<th width="17%">삭제 </th>
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
						<td><button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/cash/cashUpdateForm.jsp?cashNo=<%=m.get("cashNo")%>&year=<%=year%>&month=<%=month%>&date=<%=date%>'">수정</button> </td>     
		   				<td><button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/cash/deleteCashAction.jsp?cashNo=<%=m.get("cashNo")%>&year=<%=year%>&month=<%=month%>&date=<%=date%>'">삭제 </button> </td>        
		         </tr>
		        <%}%>
		    </table>    
	
		</div>	
	</div>
</div>
<br>
			<%
		if(request.getParameter("msg")!=null){
		%>
			<div class="alert alert-primary" role="alert"><%=request.getParameter("msg")%></div>
		<% 			
			}
		%>

</body>
</html>
