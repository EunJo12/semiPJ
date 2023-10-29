<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="service.ServiceBean" %>
<jsp:useBean id="sMgr" class="service.ServiceMgr" />
<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("idKey");

	int serv_num = Integer.parseInt(request.getParameter("serv_num"));
	String serv_dateS = request.getParameter("serv_dateS");
	String serv_dateE = request.getParameter("serv_dateE");
	String reserv_price = request.getParameter("sum1");
	
	ServiceBean bean = sMgr.getService(serv_num);
	session.setAttribute("bean", bean);
	
%>
<style>
	#reservPage{
		margin-left:30%;
		border:1px solid black;
		width:600px;
	}
	table{width:500px; padding-left:80px;}
</style>
<!DOCTYPE html>	
<html>
<head>
<meta charset="UTF-8">
<title>예약하기</title>
</head>
<body>
	<div id="reservPage">
	<form name="revEndFrm" method="post" action="reservUpdateList">
		<table>
			<tr>
				<th colspan="2"><h3>서비스 결제창</h3></th>
			</tr>
			<tr>
				<td width="25%">서비스업체&emsp;</td>
				<td width="75%"><%=bean.getServ_corp() %></td>
			</tr>
			<tr>
				<td>서비스명 </td>
				<td><%=bean.getServ_name() %></td>
			</tr>
			<tr>
				<td>예약날짜</td>
				<td><%=serv_dateS %> ~ <%=serv_dateE %></td>
			</tr>
			<tr>
				<td>가격 </td>
				<td><%=reserv_price %> 원</td>
			</tr>
			
			<tr>
				<td colspan="2"><hr/></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="예약진행">
					<input type="button" value="취소" onclick="location.href='../service/list_S.jsp'">
				</td>
			</tr>
		</table>
		<input type="hidden" name="serv_date" value="<%=serv_dateS %> ~ <%=serv_dateE %>">
		<input type="hidden" name="id" value="<%=id %>">
		<input type="hidden" name="reserv_price" value="<%=reserv_price %>">
		<input type="hidden" name="serv_num" value="<%=serv_num %>">

	</form> 
	</div>
</body>
</html>