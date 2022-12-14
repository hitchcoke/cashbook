<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> <%@page import="vo.*" %><%@page import="java.util.*" %><%@ page import="java.text.*"%>
    <%@page import= "dao.*" %>
<%
	if(session.getAttribute("resultMember")==null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	DecimalFormat money = new DecimalFormat("###,###");
	Member loginMember = (Member)session.getAttribute("resultMember"); 	
	HelpDao helpdao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpdao.selectMemberHelpList(loginMember.getMemberId());
	
	Calendar today = Calendar.getInstance(); // 오늘 날짜
	int year = today.get(Calendar.YEAR);
	int month = today.get(Calendar.MONTH);
	
	CashDao cashdao = new CashDao();
	int monthExpend = cashdao.selectExpendByMonth(loginMember.getMemberId(), year, month+1);
	int monthIncome = cashdao.selectIncomeByMonth(loginMember.getMemberId(), year, month+1);
	
	int budget = loginMember.getHope() - monthExpend;
	
	ArrayList<HashMap<String,Object>> cash = cashdao.selectYearOfCashDate(loginMember.getMemberId(), year);
 	HashMap<String, Object> rank = cashdao.rankCashCategoryByMonth(year, month+1, loginMember.getMemberId());
 	System.out.print((int)rank.get("categoryNo"));
 	
 	ArrayList<Cash> cashList= cashdao.cashCategoryByMonth(month+1, loginMember.getMemberId(), (int)rank.get("categoryNo"), year);
 	
 	
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- theme meta -->
    <meta name="theme-name" content="focus" />
    <title>home sweet home</title>
    <!-- ================= Favicon ================== -->
    <!-- Standard -->
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
    <link href="bootstrap/homePageCss/css/lib/calendar2/pignose.calendar.min.css" rel="stylesheet">
    <link href="bootstrap/homePageCss/css/lib/chartist/chartist.min.css" rel="stylesheet">
    <link href="bootstrap/homePageCss/css/lib/font-awesome.min.css" rel="stylesheet">
    <link href="bootstrap/homePageCss/css/lib/themify-icons.css" rel="stylesheet">
    <link href="bootstrap/homePageCss/css/lib/owl.carousel.min.css" rel="stylesheet" />
    <link href="bootstrap/homePageCss/css/lib/owl.theme.default.min.css" rel="stylesheet" />
    <link href="bootstrap/homePageCss/css/lib/weather-icons.css" rel="stylesheet" />
    <link href="bootstrap/homePageCss/css/lib/menubar/sidebar.css" rel="stylesheet">
    <link href="bootstrap/homePageCss/css/lib/bootstrap.min.css" rel="stylesheet">
    <link href="bootstrap/homePageCss/css/lib/helper.css" rel="stylesheet">
    <link href="bootstrap/homePageCss/css/style.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
	<div>	
		<jsp:include page="/nav.jsp"></jsp:include> 
		<!-- include의 주소에는 context를 사용하지 않는다 편한 액션 중하나 -->
	</div><br>
   	
    
	<div class="col-md-11" style="margin: auto;">
    <div class="content-wrap">
        <div class="main">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-6 p-r-0 title-margin-right">
                        <div class="page-header">
                            <div class="page-title">
                                <h1>반갑습니다 <%=loginMember.getMemberId()%>님</h1>
                            </div>
                        </div>
                    </div>
                  
                    <!-- /# column -->
                    
                    <!-- /# column -->
                </div>
                <!-- /# row -->
             </div>	
            
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
                
                        <div class="row">
                        	
                        	 <div class="col-lg-4">
					              <div class="card">
					                <div class="stat-widget-two">
					                  <div class="stat-content">
					                  	
					                    <div class="stat-text"><a href="#" data-bs-toggle="modal" data-bs-target="#exampleModal">이번 달 가장 지출이 많은 곳은 <%=rank.get("categoryName") %></a></div>
					                    <div class="stat-digit">
					                    	<%=rank.get("count") %>건<br>
					                      <%=money.format((long)rank.get("sum"))%>원
					                      </div>
					                  </div>
					                  
					                </div>
					              </div>                    
		                         <div class="card">
		                                <div class="card-body">
		                                    <div class="year-calendar"></div>
		                                </div>
		                                <span style="float: right;"><a href="<%=request.getContextPath()%>/cash/cashList.jsp">more</a></span>
		                            </div>
	                         </div>
	                       
	                            <!-- /# card -->
	                            <div class="col-lg-8">
	                            <div class="card">
	                                <div class="card-body">
	                                    <div class="table-responsive">
	                                        <table class="table student-data-table m-t-20">
	                                            <thead>
	                                                <tr>
	                                                	<th>월</th>
	                                            
	                                                	<th>수입합계</th>
	                                                	<th>수입평균</th>
	                                             
	                                                	<th>지출합계</th>
	                                                	<th>지출평균</th>
	                                                	<th>총합</th>
	                                             
	                                                </tr>
	                                            </thead>
	                                            <tbody>
	                                               <%for(HashMap<String, Object> c : cash){ %>
		                                               <tr>
		                                               		<td><%=c.get("mon") %></td>
		                                               		
		                                               		<td><%=money.format((long)c.get("sumImport")) %>원</td>
		                                               		<td><%=money.format((long)c.get("avgImport")) %>원</td>
		                                               		
		                                               		<td>-<%=money.format((long)c.get("sumExport")) %>원</td>
		                                               		<td>-<%=money.format((long)c.get("avgExport")) %>원</td>
		                                               		
		                                               		<td><%=money.format((long)c.get("sumImport")-(long)c.get("sumExport")) %>원</td>
		                                               </tr>
	                                               <%} %>		
	                                            </tbody>
	                                        </table>
	                                    </div>
	                                
                          		 </div>
                        	</div>
	                        </div>
	                         
	                        <!-- /# column -->
	                       
                        <!-- /# column -->
                   		 </div>
                   <div class="row">
                        	 
                        	  <div class="col-lg-12">
	                            <div class="card">
	                                <div class="card-body">
	                                    <div class="table-responsive">
	                                        <table class="table student-data-table m-t-20">
	                                            <thead>
	                                                <tr>
	                                                   <th>문의 내용</th>
														<th width="10%">작성일</th>
														
	                                                </tr>
	                                            </thead>
	                                            <tbody>
	                                               <%for(HashMap<String, Object> h : list){ %>
	                                               <tr>
	                                               		<td><%=h.get("helpMemo")%></td>
	                                               		<td><%=h.get("userUpdatedate")%></td>
	                                               		<td><%if(h.get("adminId")!=null){ %>
															답변완료
															<%}else{%>답변대기<%} %></td>
													<tr>		
															<%} %>
	                                            </tbody>
	                                        </table>
	                                        <span style="float: right;"><a href="<%=request.getContextPath()%>/member/memberOne.jsp">more</a></span>
	                                    </div>
	                                </div>
                          		 </div>
                        	</div>
                        	</div>
                        
                        <!-- /# column -->
						</div>
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
                            <form method="post" action="<%=request.getContextPath()%>/member/updateHopeAction.jsp">
                             
                                <div class="col-md-11">
                                  <label class="control-label">이번 달 예산</label>
                                  <input class="form-control form-white" placeholder="<%=loginMember.getHope() %>" type="number" name="hope">
                                  <input type="hidden" name="page" value="home">
                                </div>
                             
		                           <div>&nbsp;&nbsp; <button type="submit" class="btn btn-danger waves-effect waves-light save-category">제출</button></div>
		                        
                            </form>
                          </div>  
                         
                        </div>
                      </div>
                    </div>
                    
                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h1 class="modal-title fs-5" id="exampleModalLabel">이번 달 <%=rank.get("categoryName") %> 지출 내역 </h1>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
						      <div class="col-md-12">
						      	<table style="margin: auto;">
						      		<tr>
						      			<th width=20%>이름</th>
						      			<th width=20%>금액</th>
						      			<th width=30%>날짜</th>
						      			
						      		</tr>
						      		<%for(Cash c : cashList){ %>
						      			<% int date= Integer.parseInt(c.getCreatedate().substring(8)); %>
							      		<tr>
							      			<td><%=rank.get("categoryName") %></td>
							      			<td><%=c.getCashPrice() %></td>
							      			<td><%=c.getCreatedate() %></td>
							      			<td><button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/cash/cashOne.jsp?date=<%=date%>&year=<%=year%>&month=<%=month+1%>'">이동</button></td>
							      		</tr>
							      	<%} %>	
						      	</table>
						      </div>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
					       
					      </div>
					    </div>
					  </div>
					</div>
			
       
    <!-- jquery vendor -->
    <script src="bootstrap/homePageCss/js/lib/jquery.min.js"></script>
    <script src="bootstrap/homePageCss/js/lib/jquery.nanoscroller.min.js"></script>
    <!-- nano scroller -->
    <script src="bootstrap/homePageCss/js/lib/menubar/sidebar.js"></script>
    <script src="bootstrap/homePageCss/js/lib/preloader/pace.min.js"></script>
    <!-- sidebar -->

    <script src="bootstrap/homePageCss/js/lib/bootstrap.min.js"></script>
    <script src="bootstrap/homePageCss/js/scripts.js"></script>
    <!-- bootstrap -->

    <script src="bootstrap/homePageCss/js/lib/calendar-2/moment.latest.min.js"></script>
    <script src="bootstrap/homePageCss/js/lib/calendar-2/pignose.calendar.min.js"></script>
    <script src="bootstrap/homePageCss/js/lib/calendar-2/pignose.init.js"></script>

	<script src="bootstrap/homePageCss/js/lib/chart-js/Chart.bundle.js"></script>
    <script src="bootstrap/homePageCss/js/lib/chart-js/chartjs-init.js"></script>
	
    <script src="bootstrap/homePageCss/js/lib/weather/jquery.simpleWeather.min.js"></script>
    <script src="bootstrap/homePageCss/js/lib/weather/weather-init.js"></script>
    
</body>

</html>
