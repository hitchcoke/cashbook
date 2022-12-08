
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import = "vo.*" %>
 <%
 if(session.getAttribute("resultMember")==null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

Member loginMember = (Member)session.getAttribute("resultMember"); 	
 
 %>   
<nav class="navbar navbar-dark bg-primary">
  <div class="container-fluid">
    <a class="navbar-brand" href="<%=request.getContextPath()%>/admin/adminMain.jsp"><span>&nbsp;&nbsp;&nbsp;</span>홈</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
      	<li class="nav-item">
          <a class="nav-link" href="<%=request.getContextPath()%>/member/memberOne.jsp"><span>&nbsp;&nbsp;&nbsp;</span><%=loginMember.getMemberId()%>님  </a>
        </li>   
        <li class="nav-item">
          <a class="nav-link" href="<%=request.getContextPath()%>/admin/categoryList.jsp"><span>&nbsp;&nbsp;&nbsp;</span>카테고리관리</a>
        </li>
	    <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath()%>/admin/memberList.jsp"><span>&nbsp;&nbsp;&nbsp;</span>사용자관리</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp"><span>&nbsp;&nbsp;&nbsp;</span>공지관리</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath()%>/admin/adminHelpList.jsp"><span>&nbsp;&nbsp;&nbsp;</span>문의사항관리</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath()%>/home.jsp"><span>&nbsp;&nbsp;&nbsp;</span>일반모드</a>
	    </li>
        <li class="nav-item">
          <a class="nav-link" href="<%=request.getContextPath()%>/logout.jsp"><span>&nbsp;&nbsp;&nbsp;</span>로그아웃 </a>
        </li>  
      </ul>
    </div>
  </div>
</nav>

    