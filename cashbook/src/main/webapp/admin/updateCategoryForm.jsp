<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %><%@page import="java.net.URLEncoder" %>  
<%@page import="dao.*" %>
<%
	Member loginMember = (Member)session.getAttribute("resultMember");
	if(loginMember==null|| loginMember.getMemberLevel() < 1 ){
	String msg = URLEncoder.encode("권한이 없습니다 ","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
	return;
	}
 	String categoryNo= request.getParameter("categoryNo");
 	String categoryName= request.getParameter("categoryName");
 	
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<title>categoryUpdateForm</title>
</head>
<body>
	

	<div class="content">
    
    <div class="container">
      <div class="row align-items-stretch justify-content-center no-gutters">
        <div class="col-md-7">
          <div class="form h-100 contact-wrap p-5">
            <h3 class="text-center">카테고리 수정 </h3><br>
           
            <form class="mb-5" method="post" action="<%=request.getContextPath()%>/admin/updateCategoryAction.jsp">
			<div class="row mb-5">
				<div class="row">
				<label for="exampleFormControlInput1" class="form-label">&nbsp;카테고리종류</label><br>
					<select name="categoryKind" class="form-select" aria-label="Default select example">
						<option value="지출">💸 지출
						<option value="수입">💰 수입
					</select>

				</div> 
                 <div class="row">
	                <div class="col-md-12 form-group mb-3">
	                  <label for="budget" class="col-form-label">카테고리 이름 </label>
	                  <input type="text" class="form-control" name="categoryName" id="subject" placeholder="<%=categoryName%> ">
	                </div>
              	</div>
             </div>
   			 <br>
				<input type="hidden" name="categoryNo" value="<%=categoryNo%>">
              <div class="row justify-content-center">
                <div class="col-md-5 form-group text-center">
                  <button type="submit" class="btn btn-block btn-primary rounded-0 py-2 px-4">확인 </button>
                  
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
	  
    <!-- 
    <div class="row mb-5">
                <div class="col-md-12 form-group mb-3">
                  <label for="message" class="col-form-label">Message *</label>
                  <textarea class="form-control" name="message" id="message" cols="30" rows="4"  placeholder="Write your message"></textarea>
                </div>
              </div> -->
    

    <script src="../bootstrap/insert/js/jquery-3.3.1.min.js"></script>
    <script src="../bootstrap/insert/js/popper.min.js"></script>
    <script src="../bootstrap/insert/js/bootstrap.min.js"></script>
    <script src="../bootstrap/insert/js/jquery.validate.min.js"></script>
    <script src="../bootstrap/insert/js/main.js"></script>
</body>
</html>