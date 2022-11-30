<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %><%@page import="java.net.URLEncoder" %>
<%@ page import="dao.*" %>

<%
	if(session.getAttribute("resultMember")==null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	Member loginMember = (Member)session.getAttribute("resultMember"); 	
	MemberDao memberdao = new MemberDao();
	Member member= memberdao.memberOneList(loginMember.getMemberId());
	
	
	HelpDao helpdao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpdao.selectMemberHelpList(loginMember.getMemberId());
		
		
 	
 	
 	
 	%>			
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	
<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

<title>memberOne</title>
</head>
<body>
	<div>	
		<jsp:include page="/nav.jsp"></jsp:include> 
		<!-- include의 주소에는 context를 사용하지 않는다 편한 액션 중하나 -->
	</div>
	<br>
	<br>
	<div class="row">
		 <div class="col-md-3">
			<div class="card" style="width: 18rem; margin:0 auto; ;">
		  		<img src="<%=request.getContextPath()%>/image/face.png" class="card-img-top">
				<div class="card-body">
				    <h5 class="card-title">이름:&nbsp;<%=member.getMemberName()%></h5>
				    <p class="card-text">아이디:&nbsp;<%=loginMember.getMemberId()%></p>
				    <p class="card-text">회원가입일 :&nbsp;<%=member.getCreatedate()%></p>
				   <div class="btn-group">
					  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
					    정보수정
					  </button>
					  <ul class="dropdown-menu">
					    <li><a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">개인정보 수정</a></li>
					    <li><a href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp">회원탈퇴</a></li>
					  </ul>
					</div>
			    </div>
	 		</div>
	 	</div>
	 <div class="col-md-9 contents">		
	 <table class="table table-bordered align-middle">
			<tr class="mt-4 p-5 bg-primary text-white rounded">
				<th>문의 내용</th>
				<th width="10%">작성일</th>
				<th width="10%">처리상태</th>
				<th width="8%">수정</th>
				<th width="8%">삭제</th>
			</tr>
			<%for(HashMap<String, Object> h : list){ %>
			<tr>

				<td>
				<%if(h.get("adminId")!=null){ %>
				<div class="accordion accordion-flush" id="accordionFlushExample">
					<div class="accordion-item">
					    <div class="accordion-header" id="flush-headingOne">
					      	<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#target<%=h.get("helpNo")%>" aria-expanded="false" aria-controls="target<%=h.get("helpNo")%>">
					        <%=h.get("helpMemo")%>
					      	</button>
					    </div>
					      <div id="target<%=h.get("helpNo")%>" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
					      	<div class="accordion-body">
					      		<%=h.get("commentMemo") %><span style="float: right;">담당자 :&nbsp;<%=h.get("adminId")%></span>	
					      	</div>
					    </div>
					</div>
				</div><%}else{ %>&nbsp;&nbsp;&nbsp;&nbsp;<%=h.get("helpMemo") %><%} %>
				</td>
				<td><%=h.get("userUpdatedate")%></td>
				<td><%if(h.get("adminId")!=null){ %>
				답변완료
				<%}else{%>답변대기<%} %></td>
				<%if(h.get("adminId")==null){ %>
					<td><button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/inc/updateHelpForm.jsp?helpNo=<%=h.get("helpNo")%>'">수정</button> </td>     
	   				<td><button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/inc/deleteHelpAction.jsp?helpNo=<%=h.get("helpNo")%>'">삭제 </button> </td>       			
				<%}else{ %>
					<td></td>
					<td></td>
				<%} %>
			</tr>	
			<%} %>
		</table>
		<div><button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='<%=request.getContextPath()%>/inc/insertHelpForm.jsp'">문의하기  </button></div>
		</div>
	</div>	
</body>
</html>	   
	  