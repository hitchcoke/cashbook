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
	int currentPage= 1;
	if(request.getParameter("currentPage")!=null){
		currentPage= Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage= 10;
	int beginRow= rowPerPage*(currentPage-1);
	
	HelpDao helpdao= new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpdao.selectHelpList(beginRow, rowPerPage);
	
	int lastPage = helpdao.helpCount(beginRow, rowPerPage);
	
			
	
%>	
 
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminhelpList</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<link rel="stylesheet" href="../bootstrap/table/css/style.css">

<body>
	<div>
		<jsp:include page="./adminMenu.jsp"></jsp:include> 
				<!-- include의 주소에는 context를 사용하지 않는다 편한 액션 중하나 -->
	</div>
	<br>
	<h5 style="text-align:center">문의사항 관리 </h5>
	<br>
	<div class="col-md-11" style="margin: auto;">
		<table class="table table-bordered align-middle">
			<tr class="mt-4 p-5 bg-primary text-white rounded">
				<th width="10%">번호</th>
				<th>내용</th>
				<th width="10%">작성일</th>
				<th width="5%">작성자 </th>
				<th width="10%">처리상태</th>
				<th width="15%">처리 </th>
			</tr>
			<%for(HashMap<String, Object> h : list){ %>
			<tr>
				<td><%=h.get("helpNo") %></td>
				<td><%if(h.get("adminId")!=null){ %>
						<div class="accordion accordion-flush" id="accordionFlushExample">
							<div class="accordion-item">
							    <div class="accordion-header" id="flush-headingOne">
							      	<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#target<%=h.get("helpNo") %>" aria-expanded="false" aria-controls="target<%=h.get("helpNo")%>">
							        <%=h.get("helpMemo")%>
							      	</button>
							    </div>
							      <div id="target<%=h.get("helpNo") %>" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
							      	<div class="accordion-body">
							      		<%=h.get("commentMemo") %><span style="float: right;">담당자 :&nbsp;<%=h.get("adminId")%></span>	
							      	</div>
							    </div>
							</div>
						</div><%}else{ %><%=h.get("helpMemo") %><%} %>
				</td>
				<td><%=h.get("userUpdatedate") %></td>
				<td><%=h.get("userId")%></td>
				<%if(h.get("adminId")==null){ %>
					<td>답변대기 </td>
					<td><button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/admin/insertCommentForm.jsp?helpNo=<%=h.get("helpNo")%>&helpMemo=<%=h.get("helpMemo")%>'">처리</button> </td>
				<%}else{ %>
					<td>답변완료 </td>
					<td><button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/admin/updateCommentForm.jsp?commentNo=<%=h.get("commentNo")%>&commentMemo=<%=h.get("commentMemo")%>'">수정</button>    
   						<button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/admin/deleteCommentAction.jsp?commentNo=<%=h.get("commentNo")%>'">삭제 </button> 
   					</td>	     
				<%} %>
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
		      				<a class="page-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>">Previous</a>
		    			</li>
		    		<%if(currentPage > 1){%>	
		    			<li class="page-item">
		    				<a class="page-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>"><%=currentPage-1%></a></li>
		    		<%} %>
		    			<li class="page-item active" aria-current="page">
		    				<span class="page-link"><%=currentPage%></span></li>
		    		<%if(currentPage < lastPage){%>		
		    			<li class="page-item">
		    				<a class="page-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>"><%=currentPage+1%></a></li>
		    		<%}
		    		  if(currentPage < lastPage){%>	
		    			<li class="page-item">
		    		<%}else{ %>
		    			<li class="page-item disabled"><%} %>
		      		   		<a class="page-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>">Next</a>
		    			</li>				
	 	   		</ul>
		   </nav>
		</div>
	</div> 
	</body>
</html>