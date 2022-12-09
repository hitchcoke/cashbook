<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*" %>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>  
<%
request.setCharacterEncoding("utf-8");
if(session.getAttribute("resultMember")==null){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}

Member loginMember = (Member)session.getAttribute("resultMember"); 	

CategoryDao categoryDao = new CategoryDao();
ArrayList<Category> ct= categoryDao.selectCategory();

request.setCharacterEncoding("utf-8");
int cashNo= Integer.parseInt(request.getParameter("cashNo"));
int year = Integer.parseInt(request.getParameter("year"));
int month = Integer.parseInt(request.getParameter("month"));
int date = Integer.parseInt(request.getParameter("date"));

CashDao cash = new CashDao();
Cash cs = cash.cashOne(cashNo);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCashForm</title>
<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	
<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,700,900&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="../bootstrap/insert/fonts/icomoon/style.css">


    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../bootstrap/insert/css/bootstrap.min.css">
    
    <!-- Style -->
    <link rel="stylesheet" href="../bootstrap/insert/css/style.css">
</head>
<body>
	

	<div class="content">
    
    <div class="container">
      <div class="row align-items-stretch justify-content-center no-gutters">
        <div class="col-md-7">
          <div class="form h-100 contact-wrap p-5">
            <h3 class="text-center">캐쉬 수정</h3><br>
            <div><%=loginMember.getMemberId() %> 님의 정보수정 </div><br>
            <form class="mb-5" method="post" action="<%=request.getContextPath()%>/cash/cashUpdateAction.jsp">
            <div class="row">
				<label for="exampleFormControlInput1" class="form-label">&nbsp;카테고리종류</label><br>
					<select name="categoryNo" class="form-select" aria-label="Default select example">
						<%for(Category c : ct){ %>	
							<option value="<%=c.getCategoryNo()%>"><%=c.getCategoryKind()%>&nbsp;
							<%if(c.getCategoryKind().equals("지출")){%>
							💸
							<%}else{ %>
							💰
							<%} %> 
							<%=c.getCategoryName()%></option>
							
						<%} %>
					</select>

				</div> 
                <div class="row">
	                <div class="col-md-12 form-group mb-3">
	                  <label for="budget" class="col-form-label">내용 </label>
	                  <input type="text" class="form-control" name="cashMemo" id="subject" placeholder="<%=cs.getCashMemo()%>">
	                </div>
	            </div>
	            <div class="row">    
	                <div class="col-md-12 form-group mb-3">
	                  <label for="budget" class="col-form-label">비용 </label>
	                  <input type="number" class="form-control" name="cashPrice" id="subject" placeholder="<%=cs.getCashPrice()%>">
	                </div>
              	</div>
				<input type="hidden" name="cashNo" value="<%=cashNo%>">
				<input type="hidden" name="date" value="<%=date%>">
				<input type="hidden" name="month" value="<%=month%>">
				<input type="hidden" name="year" value="<%=year%>">
   			 <br>
              <div class="row justify-content-center">
                <div class="col-md-5 form-group text-center">
                  <button type="submit" class="btn btn-block btn-primary rounded-0 py-2 px-4">수정 </button>
                
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

  </div>
  	<%
		if(request.getParameter("msg")!=null){
	%>
		<div class="alert alert-primary" role="alert"><%=request.getParameter("msg")%></div>
	<% 			
		}
	%>
	  
    

    <script src="../bootstrap/insert/js/jquery-3.3.1.min.js"></script>
    <script src="../bootstrap/insert/js/popper.min.js"></script>
    <script src="../bootstrap/insert/js/bootstrap.min.js"></script>
    <script src="../bootstrap/insert/js/jquery.validate.min.js"></script>
    <script src="../bootstrap/insert/js/main.js"></script>
</body>
</html>