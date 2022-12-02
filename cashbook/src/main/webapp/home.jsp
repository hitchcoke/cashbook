<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> <%@page import="vo.*" %><%@page import="java.util.*" %>
    <%@page import= "dao.*" %>
<%
	if(session.getAttribute("resultMember")==null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("resultMember"); 	
	HelpDao helpdao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpdao.selectMemberHelpList(loginMember.getMemberId());
		
		
 	
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
    <link href="admin/css/lib/calendar2/pignose.calendar.min.css" rel="stylesheet">
    <link href="admin/css/lib/chartist/chartist.min.css" rel="stylesheet">
    <link href="admin/css/lib/font-awesome.min.css" rel="stylesheet">
    <link href="admin/css/lib/themify-icons.css" rel="stylesheet">
    <link href="admin/css/lib/owl.carousel.min.css" rel="stylesheet" />
    <link href="admin/css/lib/owl.theme.default.min.css" rel="stylesheet" />
    <link href="admin/css/lib/weather-icons.css" rel="stylesheet" />
    <link href="admin/css/lib/menubar/sidebar.css" rel="stylesheet">
    <link href="admin/css/lib/bootstrap.min.css" rel="stylesheet">
    <link href="admin/css/lib/helper.css" rel="stylesheet">
    <link href="admin/css/style.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
	<div>	
		<jsp:include page="/nav.jsp"></jsp:include> 
		<!-- include의 주소에는 context를 사용하지 않는다 편한 액션 중하나 -->
	</div><br>
   	
    
	<div class="container px-11">
    <div class="content-wrap">
        <div class="main">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-8 p-r-0 title-margin-right">
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
	                        <div class="col-lg-4">
	                            <div class="card">
	                           
	                                <div class="card-body">
	                                    <div class="year-calendar"></div>
	                                </div>
	                                <span style="float: right;"><a href="<%=request.getContextPath()%>/cash/cashList.jsp">more</a></span>
	                            </div>
	                            <!-- /# card -->
	                        </div>     
	                        <!-- /# column -->
	                        <div class="col-lg-8">
	                            <div class="card">
	                                <div class="card-body">
	                                    <div class="table-responsive">
	                                        <table class="table student-data-table m-t-20">
	                                            <thead>
	                                                <tr>
	                                                   <th>문의 내용</th>
														<th width="10%">작성일</th>
														<th width="12%">처리상태</th>
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
                        <!-- /# column -->
                    
                    
                        
                        <!-- /# column -->
						</div>
					</div>
				</div>
			</div>
       
    <!-- jquery vendor -->
    <script src="admin/js/lib/jquery.min.js"></script>
    <script src="admin/js/lib/jquery.nanoscroller.min.js"></script>
    <!-- nano scroller -->
    <script src="admin/js/lib/menubar/sidebar.js"></script>
    <script src="admin/js/lib/preloader/pace.min.js"></script>
    <!-- sidebar -->

    <script src="admin/js/lib/bootstrap.min.js"></script>
    <script src="admin/js/scripts.js"></script>
    <!-- bootstrap -->

    <script src="admin/js/lib/calendar-2/moment.latest.min.js"></script>
    <script src="admin/js/lib/calendar-2/pignose.calendar.min.js"></script>
    <script src="admin/js/lib/calendar-2/pignose.init.js"></script>


    <script src="admin/js/lib/weather/jquery.simpleWeather.min.js"></script>
    <script src="admin/js/lib/weather/weather-init.js"></script>
    
</body>

</html>
