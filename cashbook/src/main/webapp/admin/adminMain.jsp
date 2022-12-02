<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
	<%@ page import="java.util.*" %><%@page import="java.net.URLEncoder" %>
	<%@ page import="dao.*" %>
 <% 
	 
 	Member loginMember = (Member)session.getAttribute("resultMember");
  	if(loginMember==null|| loginMember.getMemberLevel() < 1 ){
  		String msg = URLEncoder.encode("권한이 없습니다 ","utf-8");
  		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
  	}
  	int beginRow=1;
  	int rowPerPage=5;
  	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> category= categoryDao.selectCategory();
	
	MemberDao memberDao= new MemberDao();
	ArrayList<Member> member= memberDao.selecetMemberList(beginRow, rowPerPage);
	
	NoticeDao noticeDao= new NoticeDao();
	ArrayList<Notice> notice = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	HelpDao helpdao= new HelpDao();
	ArrayList<HashMap<String, Object>> help = helpdao.selectHelpList(beginRow, rowPerPage);
	
 	
  	//recent 공지 5개, 멤버 5명
  	
 %> 
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- theme meta -->
    <meta name="theme-name" content="focus" />
    <title>admin main</title>
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
    <link href="css/lib/calendar2/pignose.calendar.min.css" rel="stylesheet">
    <link href="css/lib/chartist/chartist.min.css" rel="stylesheet">
    <link href="css/lib/font-awesome.min.css" rel="stylesheet">
    <link href="css/lib/themify-icons.css" rel="stylesheet">
    <link href="css/lib/owl.carousel.min.css" rel="stylesheet" />
    <link href="css/lib/owl.theme.default.min.css" rel="stylesheet" />
    <link href="css/lib/weather-icons.css" rel="stylesheet" />
    <link href="css/lib/menubar/sidebar.css" rel="stylesheet">
    <link href="css/lib/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
    <link href="css/lib/helper.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
	<div>
		<jsp:include page="./adminMenu.jsp"></jsp:include> 
				<!-- include의 주소에는 context를 사용하지 않는다 편한 액션 중하나 -->
	</div>


    <div class="content-wrap">
        <div class="main">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-8 p-r-0 title-margin-right">
                        <div class="page-header">
                            <div class="page-title">
                                <h1> 관리자님(<%=loginMember.getMemberId() %>)&nbsp; <span>관리자 메인페이지입니다</span> </h1>
                            </div>
                        </div>
                    </div>
                    <!-- /# column -->
                
                        <!-- /# column -->
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-title pr">
                                    <h4>멤버관리 </h4>
									<span style="float: right;"><a href="<%=request.getContextPath()%>/admin/memberList.jsp">more</a></span>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table student-data-table m-t-20">
                                            <thead>
                                                <tr>
                                                    <th width=10%>멤버번호</th>
													<th>아이디</th>
													<th width=10%>레벨</th>
													<th width=10%>이름</th>
													<th width=15%>마지막수정일자</th>
													<th width=15%>생성일자</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            	<%for(Member m : member){ %>
                                             	<tr>
                                             		<td><%= m.getMemberNo() %></td>
													<td><%= m.getMemberId() %></td>
													<td><%= m.getMemberLevel() %></td>
													<td><%= m.getMemberName() %></td>
													<td><%= m.getUpdatedate() %></td>
													<td><%= m.getCreatedate() %></td>
                                                </tr>
                                                <%} %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                          <div class="col-lg-12">
                            <div class="card">
                                <div class="card-title pr">
                                    <h4>공지관리 </h4>
									<span style="float: right;"><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">more</a></span>
                             </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table student-data-table m-t-20">
                                            <thead>
                                                <tr>
                                                    <th width=10%>번호</th>
													<th>내용</th>
													<th width=15%>작성일자</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            		<%for(Notice n : notice){ %>
													<tr>
														<td><%= n.getNoticeNo() %></td>
														<td><%= n.getNoticeMemo() %></td>
														<td><%= n.getUpdatedate() %></td>
													</tr>	
													<%} %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                          <div class="col-lg-12">
                            <div class="card">
                                <div class="card-title pr">
                                     <h4>문의사항관리 </h4>
									<span style="float: right;"><a href="<%=request.getContextPath()%>/admin/adminHelpList.jsp">more</a></span>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table student-data-table m-t-20">
                                            <thead>
                                                <tr>
                                                    <th width="10%">번호</th>
													<th>내용</th>
													<th width="10%">작성일</th>
													<th width="5%">작성자 </th>
													<th width="10%">처리상태</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                	<%for(HashMap<String, Object> h : help){ %>
													<tr>
														<td><%=h.get("helpNo") %></td>
														<td><%=h.get("userUpdatedate") %></td>
														<td><%=h.get("userId")%></td>
														<td> <%=h.get("helpMemo")%></td>
														<%if(h.get("adminId")==null){ %>
															<td>답변대기 </td>
														<%}else{ %>
															<td>답변완료 </td><%} %>
													<tr>
													<%} %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                         <div class="col-lg-12">
                            <div class="card">
                                <div class="card-title pr">
                                   <h4>카테고리관리 </h4>
									<span style="float: right;"><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">more</a></span>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table student-data-table m-t-20">
                                            <thead>
                                                <tr>
                                                    <th width=10%>번호</th>
													<th width=25%>종류</th>
													<th width=25%>내용</th>
													<th width=20%>수정일자</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <%for(Category c : category){ %>
                                               	<tr>
                                               		<td><%=c.getCategoryNo() %></td>
													<td><%=c.getCategoryKind() %></td>
													<td><%=c.getCategoryName() %></td>
													<td><%=c.getUpdatedate() %></td>
                                                </tr>
                                                <%} %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /# column -->
                    </div>
                    <!-- /# row -->
                  </div>
                </div>
            </div>
                   

    <!-- jquery vendor -->
    <script src="js/lib/jquery.min.js"></script>
    <script src="js/lib/jquery.nanoscroller.min.js"></script>
    <!-- nano scroller -->
    <script src="js/lib/menubar/sidebar.js"></script>
    <script src="js/lib/preloader/pace.min.js"></script>
    <!-- sidebar -->

    <script src="js/lib/bootstrap.min.js"></script>
    <script src="js/scripts.js"></script>
    <!-- bootstrap -->

    <script src="js/lib/calendar-2/moment.latest.min.js"></script>
    <script src="js/lib/calendar-2/pignose.calendar.min.js"></script>
    <script src="js/lib/calendar-2/pignose.init.js"></script>


    <script src="js/lib/weather/jquery.simpleWeather.min.js"></script>
    <script src="js/lib/weather/weather-init.js"></script>
    <script src="js/lib/circle-progress/circle-progress.min.js"></script>
    <script src="js/lib/circle-progress/circle-progress-init.js"></script>
    <script src="js/lib/chartist/chartist.min.js"></script>
    <script src="js/lib/sparklinechart/jquery.sparkline.min.js"></script>
    <script src="js/lib/sparklinechart/sparkline.init.js"></script>
    <script src="js/lib/owl-carousel/owl.carousel.min.js"></script>
    <script src="js/lib/owl-carousel/owl.carousel-init.js"></script>
    <!-- scripit init-->
    <script src="js/dashboard2.js"></script>
</body>

</html>