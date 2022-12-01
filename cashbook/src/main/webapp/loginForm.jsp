<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import= "dao.*" %><%@page import= "vo.*" %><%@page import="java.util.*" %>
    
<%
	if(session.getAttribute("resultMember")!=null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	int currentPage= 1;
	if(request.getParameter("currentPage")!=null){
		currentPage= Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage= 5;
	int beginRow= rowPerPage*(currentPage-1);
	
	NoticeDao noticeDao= new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	int lastPage= noticeDao.selectNoticeCount(rowPerPage);
	
	

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" />

       <meta charset="utf-8">
   		
	<link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="sourse/fonts/icomoon/style.css">

    <link rel="stylesheet" href="sourse/css/owl.carousel.min.css">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="sourse/css/bootstrap.min.css">
    
    <!-- Style -->
    <link rel="stylesheet" href="sourse/css/style.css">
</head>
<body>
 <header class="bg-dark py-5">
                <div class="container px-5">
                    <div class="row gx-5 align-items-center justify-content-center">
                        <div class="col-lg-8 col-xl-7 col-xxl-6">
                            <div class="my-5 text-center text-xl-start">
                                <h1 class="display-5 fw-bolder text-white mb-2">이지원의 첫 프로젝트</h1>
                                <p class="lead fw-normal text-white-50 mb-4">효과적인 캘린더 지출 시스템과 관리자모드 적용</p>
                                <div class="d-grid gap-3 d-sm-flex justify-content-sm-center justify-content-xl-start">
                            
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-5 col-xxl-6 d-none d-xl-block text-center"><img class="img-fluid rounded-3 my-5" src="image/back.png"  alt="..." /></div>
                    </div>
                </div>
            </header>
	<div class="content">
    <div class="container">
      <div class="row">
        <div class="col-6">
          <div class="container">		
				<div>
				
					<h1 style=  "text-align:center">공지사항</h1>
					
					<div>
						<table class="table table-bordered align-middle">
							<tr class="mt-4 p-5 bg-primary text-white rounded">
								<th>번호</th>
								<th>내용</th>
								<th>작성일자</th>
							</tr>
							<%for(Notice n : list){ %>
							<tr>
								<td><%= n.getNoticeNo() %></td>
								<td><%= n.getNoticeMemo() %></td>
								<td><%= n.getUpdatedate() %></td>
							</tr>	
							<%} %>	
						</table>
					<div>
						<nav aria-label="Page navigation example">
				  			<ul class="pagination justify-content-center">
					    		<%if(currentPage > 1){%>	
					   				<li class="page-item">
					   				<% }else{ %>
					   				<li class="page-item disabled"><%} %>
					      				<a class="page-link" href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">Previous</a>
					    			</li>
					    		<%if(currentPage > 1){%>	
					    			<li class="page-item">
					    				<a class="page-link" href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>"><%=currentPage-1%></a></li>
					    		<%} %>
					    			<li class="page-item active" aria-current="page">
					    				<span class="page-link"><%=currentPage%></span></li>
					    		<%if(currentPage < lastPage){%>		
					    			<li class="page-item">
					    				<a class="page-link" href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>"><%=currentPage+1%></a></li>
					    		<%}
					    		  if(currentPage < lastPage){%>	
					    			<li class="page-item">
					    		<%}else{ %>
					    			<li class="page-item disabled"><%} %>
					      		   		<a class="page-link" href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">Next</a>
					    			</li>				
				 	   		</ul>
					   </nav></div>
					</div>
				</div>
			</div>
        </div>
        <div class="col-6 contents">
          <div class="row justify-content-center">
            <div class="col-md-8">
              <div class="mb-4">
           
              <h3>로그인 </h3>
            </div>
            <form method="post" action="<%=request.getContextPath()%>/loginAction.jsp">
              <div class="form-group first">
                <label for="username">아이디 </label>
                <input type="text" class="form-control" name="memberId">

              </div>
              <div class="form-group last mb-4">
                <label for="password">비밀번호 </label>
                <input type="password" class="form-control" name="memberPw" >
                
              </div>
              
              <a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입 </a>
              <input type="submit" value="로그인 " class="btn btn-block btn-primary">
              
            </form>
              </div>
          </div>
          
        </div>
        
      </div>
    </div>
     <%
	if(request.getParameter("msg")!=null){
	%>
	<br><div class="alert alert-primary" role="alert"><%=request.getParameter("msg")%></div>
	<%
	}%>
  </div>

    <script src="sourse/js/jquery-3.3.1.min.js"></script>
    <script src="sourse/js/popper.min.js"></script>
    <script src="sourse/js/bootstrap.min.js"></script>
    <script src="sourse/js/main.js"></script>
   <script src="table/js/jquery.min.js"></script>
  <script src="table/js/popper.js"></script>
  <script src="table/js/bootstrap.min.js"></script>
  <script src="table/js/main.js"></script>
    
	
</body>
</html>
