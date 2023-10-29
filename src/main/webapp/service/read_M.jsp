<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="service.ServiceBean, service.ServiceMgr" %>
<jsp:useBean id="sMgr" class="service.ServiceMgr" />
<%
	request.setCharacterEncoding("utf-8");
	int serv_num = Integer.parseInt(request.getParameter("serv_num"));
	String nowPage = request.getParameter("nowPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	
	ServiceBean bean = sMgr.getService(serv_num);
	session.setAttribute("bean", bean);
	
	String id = (String)session.getAttribute("idKey");
	if(!id.equals("admin") || id == null) {
		out.print("<script>");
		out.print("alert('권한이 없습니다.');");
		out.print("location.href='../index.jsp'");
		out.print("</script>");
	}
	String url = "list.jsp?nowPage=" + nowPage;
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서비스 상세-관리자</title>
<style>
 	th {background-color:white;}
 	.tt {background-color:#D5D5D5; width:15%; text-align:center;}
 	.tc {background-color:#ECEBFF;}
 	table {width:700; margin: 50px auto 10px;}
 	a {text-decoration:none;}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	function list() {
		listFrm.submit();
	}
	function del() {
		let yn = confirm("삭제하겠습니까?");
		if(yn){
			$.ajax({
				url:"../listDel.bo",
				data:{
					serv_num:<%=serv_num %>
				},
				type:"post",
				success:function(result) {
					if(result == "true"){
						location.href="list_M.jsp";
					}else{
						alert("예약건이 있는 서비스입니다");
					}
				},
				error:function() {
					console.log("삭제 ajax 통신 실패");
				}
			});
		}else {
			alert("삭제취소");
		} 
	}
</script>
</head>
<body bgcolor="#B2CCFF">
	<table width="700" margin="0 auto">
		<tr>
			<th colspan="4">서비스상세-관리자용</th>
		</tr>
		<tr>
			<td class="tt">업체명</td>
			<td class="tc" width="30%"><%=bean.getServ_corp() %></td>
			<td class="tt">서비스명</td>
			<td class="tc"><%=bean.getServ_name() %></td>
		</tr>
		<tr>
			<td class="tt">카테고리</td>
			<td class="tc"><%=bean.getServ_category() %></td>
			<td class="tt">제공지역</td>
			<td class="tc"><%=bean.getRegion() %></td>
		</tr>
		<tr>
			<td class="tt">서비스가격</th>
			<td colspan="3" class="tc"><%=bean.getPrice() %></td>
		</tr>
		<tr>
			<td class="tt">첨부파일</td>
			<td colspan="3" class="tc">
			<%
				if(bean.getFilename() != null && !bean.getFilename().equals("")) {
			%>
				<%=bean.getFilename() %>&emsp;
				(<%=bean.getFilesize() %> KByte)
			<%
				}else {
					out.print("등록된 파일이 없습니다");
				}
			%>
			</td>
		</tr>
		<tr>
			<td colspan="4" height="100px"><img src="../serFicUpload/<%=bean.getFilename() %>"></td>
		</tr>
		<tr>
			<td colspan="4" height="100px"><%=bean.getServ_detail() %></td>
		</tr>
		<tr>
			<td colspan="4"><hr/></td>
		</tr>
		<tr align="center">
			<td colspan="4">
				[<a href="javascript:list()"> 리스트</a> |
				<a href="update.jsp?nowPage=<%=nowPage%>&serv_num=<%=serv_num %>">수 정</a> |
				<%-- <a href="delete.jsp?nowPage=<%=nowPage%>&serv_num=<%=serv_num %>">삭 제</a> ] --%>
				<a href="javascript:del();">삭 제</a> ]
			</td>
		</tr>
	</table>
	<form name="listFrm" method="post" action="list_M.jsp">
		<input type="hidden" name="nowPage" value="<%=nowPage %>">
		<%
		if(!(keyWord==null || keyWord.equals(""))){
		%>
		<input type="hidden" name="keyField" value="<%=keyField %>">
		<input type="hidden" name="keyWord" value="<%=keyWord %>">
		<%	
		}
		%>
	</form>
</body>
</html>