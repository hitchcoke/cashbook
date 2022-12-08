<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>  
<%@ page import="java.text.*"%>

<%
   DecimalFormat money = new DecimalFormat("###,###");
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

  int monthExpend = cashDao.selectExpendByMonth(loginMember.getMemberId(), year, month+1);
  int monthIncome= cashDao.selectIncomeByMonth(loginMember.getMemberId(), year, month+1);

	
	int budget = loginMember.getHope() - monthExpend;
  

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashList</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
     <link rel="shortcut icon" href="http://placehold.it/64.png/000/fff">
    <!-- Retina iPad Touch Icon-->
    <link rel="apple-touch-icon" sizes="144x144" href="http://placehold.it/144.png/000/fff">
    <!-- Retina iPhone Touch Icon-->
    <link rel="apple-touch-icon" sizes="114x114" href="http://placehold.it/114.png/000/fff">
    <!-- Standard iPad Touch Icon-->
    <link rel="apple-touch-icon" sizes="72x72" href="http://placehold.it/72.png/000/fff">
    <!-- Standard iPhone Touch Icon-->
    <link rel="apple-touch-icon" sizes="57x57" href="http://placehold.it/57.png/000/fff">
    <!-- Styles -->
    <link href="../admin/css/lib/calendar2/pignose.calendar.min.css" rel="stylesheet">
    <link href="../admin/css/lib/chartist/chartist.min.css" rel="stylesheet">
    <link href="../admin/css/lib/font-awesome.min.css" rel="stylesheet">
    <link href="../admin/css/lib/themify-icons.css" rel="stylesheet">
    <link href="../admin/css/lib/owl.carousel.min.css" rel="stylesheet" />
    <link href="../admin/css/lib/owl.theme.default.min.css" rel="stylesheet" />
    <link href="../admin/css/lib/weather-icons.css" rel="stylesheet" />
    <link href="../admin/css/lib/menubar/sidebar.css" rel="stylesheet">
    <link href="../admin/css/lib/bootstrap.min.css" rel="stylesheet">
    <link href="../admin/css/lib/helper.css" rel="stylesheet">
    <link href="../admin/css/style.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">

	<link rel="stylesheet" href="../table/css/style.css">
	
</head>
<body>
	<div>	
		<jsp:include page="/nav.jsp"></jsp:include> 
		<!-- include의 주소에는 context를 사용하지 않는다 편한 액션 중하나 -->
	</div><br>
	
   <div class="col-md-11" style="margin: auto;">
	   <h5 style="text-align:center">
	   <span style="float: left;">
	   		<button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>'">저번 달</button>    
	   </span>
	   <span><%=year%>년 <%=month+1%> 월 가계부 </span>
	    <span style="float: right;">
	    	<button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>'">다음 달</button>
	    </span>
	   </h5>
	   <br>
	   <div class="row">
                        <div class="col-lg-3">
                            <div class="card">
                                <div class="stat-widget-one">
                                    <div class="stat-icon dib"><i class="ti-money color-primary border-primary"></i>
                                    </div>
                                    <div class="stat-content dib">
                                        <div class="stat-text">이번 달 수입</div>
                                        <div class="stat-digit"><%=money.format(monthIncome) %>원</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="card">
                                <div class="stat-widget-one">
                                    <div class="stat-icon dib"><i class="ti-money color-success border-success"></i>
                                    </div>
                                    <div class="stat-content dib">
                                        <div class="stat-text">이번 달 지출</div>
                                        <div class="stat-digit">-<%=money.format(monthExpend)%>원</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="card">
                                <div class="stat-widget-one">
                                    <div class="stat-icon dib"><i class="ti-money color-primary border-primary"></i>
                                    </div>
                                    <div class="stat-content dib">
                                        <div class="stat-text">이번 달 예산</div>
                                        <a href="#" data-toggle="modal" data-target="#add-category" class="stat-digit"><%=money.format(loginMember.getHope()) %>원</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="card">
                                <div class="stat-widget-one">
                                    <div class="stat-icon dib"><i class="ti-money color-success border-success"></i>
                                    </div>
                                    <div class="stat-content dib">
                                        <div class="stat-text">이번달 남은 예산 </div>
                                        <div class="stat-digit"><%=money.format(budget)%></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                    </div>
         
	
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
						            <% long totalExpend=0;
									   long totalIncome=0; 
	            %>				<%for(HashMap<String, Object> m : list){ %>
	                       		
	            <%  				String cdate= (String)m.get("cashdate");
	            					  
	            					
	                       			 if(Integer.parseInt(cdate.substring(8))==date){%>
	                       			 		
									   	 <%if(m.get("categoryKind").equals("지출")){
									   		totalExpend += (long)m.get("cashPrice");
									   	 %>
											💸
											
										<%}else if(m.get("categoryKind").equals("수입")){
											totalIncome += (long)m.get("cashPrice");	%>
											💰
										<%}
									   	 	
									   	 %> 
	                      				 
	            <%           				 
	                       			 }        
	                     }
	            %>		<div class="fw-bold">
	            		<%if(totalExpend>0){ %>-<%=money.format(totalExpend)%>원 <br>
	            		<%} if(totalIncome>0){ %> <%=money.format(totalIncome)%>원<%} %>
	            		</div>
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
	<div class="modal fade none-border" id="add-category">
                      <div class="modal-dialog">
                        <div class="modal-content">
                          <div class="modal-header">
          
                            <h4 class="modal-title">
                              <strong>예산 수정 </strong>
                            </h4>
                          </div>
                          <div class="modal-body">
                            <form method="post" action="<%=request.getContextPath()%>/updateHopeAction.jsp">
                             
                                <div class="col-md-11">
                                  <label class="control-label">이번 달 예산</label>
                                  <input class="form-control form-white" placeholder="<%=loginMember.getHope() %>" type="number" name="hope">
                                  <input type="hidden" name="page" value="list">
                                </div>
                             
		                           <div>&nbsp;&nbsp; <button type="submit" class="btn btn-danger waves-effect waves-light save-category">제출</button></div>
		                        
                            </form>
                          </div>  
                         
                        </div>
                      </div>
                    </div>
	
   <%
	if(request.getParameter("msg")!=null){
	%>
	<div class="alert alert-primary" role="alert"><%=request.getParameter("msg")%></div>
	<%
											}%>	
	<!-- jquery vendor -->
    <script src="../admin/js/lib/jquery.min.js"></script>
    <script src="../admin/js/lib/jquery.nanoscroller.min.js"></script>
    <!-- nano scroller -->
    <script src="../admin/js/lib/menubar/sidebar.js"></script>
    <script src="../admin/js/lib/preloader/pace.min.js"></script>
    <!-- sidebar -->

    <script src="../admin/js/lib/bootstrap.min.js"></script>
    <script src="../admin/js/scripts.js"></script>
    <!-- bootstrap -->

    <script src="../admin/js/lib/calendar-2/moment.latest.min.js"></script>
    <script src="../admin/js/lib/calendar-2/pignose.calendar.min.js"></script>
    <script src="../admin/js/lib/calendar-2/pignose.init.js"></script>


    <script src="../admin/js/lib/weather/jquery.simpleWeather.min.js"></script>
    <script src="../admin/js/lib/weather/weather-init.js"></script>

</body>
</html>