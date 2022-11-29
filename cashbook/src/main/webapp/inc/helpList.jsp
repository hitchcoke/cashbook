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
						
	HelpDao helpdao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpdao.selectMemberHelpList(loginMember.getMemberId());
%>	
 
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>helpList</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

<body>
<h2 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">고객센터  </h2>
	<br>
	<div>
		<table class="table table-bordered align-middle">
			<tr class="mt-4 p-5 bg-primary text-white rounded">
				<th width="5%">번호</th>
				<th>내용</th>
				<th width="10%">작성일</th>
				<th width="10%">처리상태</th>
				<th width="5%">수정</th>
				<th width="5%">삭제</th>
			</tr>
			<%for(HashMap<String, Object> h : list){ %>
			<tr>
				<td><%=h.get("helpNo")%></td>
				<td>
				<%if(h.get("adminId")!=null){ %>
				<div class="accordion accordion-flush" id="accordionFlushExample">
					<div class="accordion-item">
					    <div class="accordion-header" id="flush-headingOne">
					      	<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#<%=h.get("adminId") %>" aria-expanded="false" aria-controls="<%=h.get("adminId")%>">
					        <%=h.get("helpMemo")%>
					      	</button>
					    </div>
					      <div id="<%=h.get("adminId") %>" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
					      	<div class="accordion-body">
					      		<%=h.get("commentMemo") %><span style="float: right;">담당자 :&nbsp;<%=h.get("adminId")%></span>	
					      	</div>
					    </div>
					</div>
				</div><%}else{ %><%=h.get("helpMemo") %><%} %>
				</td>
				<td><%=h.get("userUpdatedate")%></td>
				<td><%if(h.get("adminId")!=null){ %>
				답변완료<br>(<%=h.get("adminUpdatedate")%>) 
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
	</div>
	<div><button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='<%=request.getContextPath()%>/inc/insertHelpForm.jsp'">글 작성 </button></div>
</body>
</html>