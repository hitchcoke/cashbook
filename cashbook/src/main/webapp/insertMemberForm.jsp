<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("resultMember")!=null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertMemberForm</title>
<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	
<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="sourse/fonts/icomoon/style.css">

    <link rel="stylesheet" href="sourse/css/owl.carousel.min.css">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="sourse/css/bootstrap.min.css">
    
    <!-- Style -->
    <link rel="stylesheet" href="sourse/css/style.css">
</head>
<body>
	<div class="content">
    <div class="container">
      <div class="row">
        <div class="col-md-6">
          <img src="images/undraw_remotely_2j6y.svg" alt="Image" class="img-fluid">
        </div>
        <div class="col-md-6 contents">
          <div class="row justify-content-center">
            <div class="col-md-8">
              <div class="mb-4">
              <h3>회원가입</h3>
 
            </div>
            <form action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
              <div class="form-group first">
                <label for="username">아이디 </label>
                <input type="text" class="form-control" name="memberId">
              </div>
               <div class="form-group first">
                <label for="username">이름 </label>
                <input type="text" class="form-control" name="memberName">
              </div>
              <div class="form-group last mb-4">
                <label for="password">비밀번호 </label>
                <input type="password" class="form-control" name="memberPw">
                
              </div>
              <input type="submit" value="회원가입" class="btn btn-block btn-primary">
            </form>
            </div>
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
		}
	
	%>
	
	<script src="sourse/js/jquery-3.3.1.min.js"></script>
    <script src="sourse/js/popper.min.js"></script>
    <script src="sourse/js/bootstrap.min.js"></script>
    <script src="sourse/js/main.js"></script>
	
	
</body>
</html>


  
   