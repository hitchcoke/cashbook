<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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


   // Controller : seesion, request
   // request 년 + 월
   int year = 0;
   int month = 0;
   
   if((request.getParameter("year") == null) || request.getParameter("month") == null) {
      Calendar today = Calendar.getInstance(); // 오늘날짜
      year = today.get(Calendar.YEAR);
      month = today.get(Calendar.MONTH);
   } else {
      year = Integer.parseInt(request.getParameter("year"));
      month = Integer.parseInt(request.getParameter("month"));
      // month -> -1, month -> 12 일경우
      if(month == -1) {
         month = 11;
         year -= 1;
      }
      if(month == 12) {
         month = 0;
         year += 1;
      }
   }
   
   // 출력하고자 하는 년,월과 월의 1일의 요일(일 1, 월 2, 화 3, ... 토 7)
   Calendar targetDate = Calendar.getInstance();
   targetDate.set(Calendar.YEAR, year);
   targetDate.set(Calendar.MONTH, month);
   targetDate.set(Calendar.DATE, 1);
   // firstDay는 1일의 요일
   int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); // 요일(일 1, 월 2, 화 3, ... 토 7)
   // begin blank개수는 firstDay - 1
   
   // 마지막날짜
   int lastDate = targetDate.getActualMaximum(Calendar.DATE); // 
   
   // 달력 출력테이블의 시작 공백셀(td)과 마지막 공백셀(td)의 개수
   int beginBlank = firstDay - 1;
   int endBlank = 0; // beginBlank + lastDate + endBlank --> 7로 나누어 떨어진다 --> totalTd
   if((beginBlank + lastDate) % 7 != 0) {
      endBlank = 7 - ((beginBlank + lastDate) % 7);
   }
   
   // 전체 td의 개수 : 7로 나누어 떨어져야 한다
   int totalTd = beginBlank + lastDate + endBlank;
   
      
   // Model 호출 : 일별 cash 목록
    CashDao cashDao = new CashDao();
   ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(year, month+1, loginMember.getMemberId());
   // View : 달력출력 + 일별 cash 목록 출력
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashList</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div>	
		<jsp:include page="/nav.jsp"></jsp:include> 
		<!-- include의 주소에는 context를 사용하지 않는다 편한 액션 중하나 -->
	</div><br>
   <div class="col-md-11" style="margin: auto;">
	   <h2 style="text-align:center">
	   <span style="float: left;">
	   		<button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>'">저번 달</button>    
	   </span>
	   <span><%=year%>년 <%=month+1%> 월 가계부 </span>
	    <span style="float: right;">
	    	<button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>'">다음 달</button>
	    </span>
	   </h2>
	   <br>
	   
	  	<div>
	      <!-- 달력 -->
	      <table class="table table-bordered align-middle">
	         <tr class="mt-4 p-5 bg-primary text-white rounded">
	            <th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>
	         </tr>
	         <tr>
	            <%
	               for(int i=1; i<=totalTd; i++) {
	            %>
	                  <td width=300 height=100 style='table-layout:fixed' >
	            <%
	                     int date = i-beginBlank;
	                     if(date > 0 && date <= lastDate) {
	                    	 %> 
	            	        	<a class="page-link" href="<%=request.getContextPath()%>/cash/cashOne.jsp?date=<%=date%>&year=<%=year%>&month=<%=month+1%>"><%=date%><br></a>
	            <% 
	            %>				<%for(HashMap<String, Object> m : list){ %>
	                       		
	            <%  				String cdate= (String)m.get("cashdate");
	            					
	            					
	                       			 if(Integer.parseInt(cdate.substring(8))==date){%>

									   	 <%if(m.get("categoryKind").equals("지출")){%>
											💸
										<%}else{ %>
											💰
										<%} %> 
	                      				 
	            <%           				 
	                       			 }        
	                     }
	            %>
	                  </td>
	            <%
	                  
	                  if(i%7 == 0 && i != totalTd) {
	            %>
	                     </tr><tr> <!-- td7개 만들고 테이블 줄바꿈 -->
	            <%         
	                  }
	               }
	               }
	            %>
	         </tr>
	      </table>
	   </div>
	</div>   
   <%
	if(request.getParameter("msg")!=null){
	%>
	<div class="alert alert-primary" role="alert"><%=request.getParameter("msg")%></div>
	<%
											}%>	

</body>
</html>