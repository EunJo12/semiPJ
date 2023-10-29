<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="service.ServiceBean" %>
<jsp:useBean id="sMgr" class="service.ServiceMgr"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body {margin:0 auto 0 auto; padding-top:50px;}
	th {padding: 5px; background-color : white; text-align:center; align:center;}
</style>
</head>
<body bgcolor="#B2CCFF">
<%
	int serv_num= Integer.parseInt(request.getParameter("serv_num"));
	String nowPage = request.getParameter("nowPage");
		

	boolean result = sMgr.deleteServiceBoard(serv_num);  //삭제 확인메시지
	if(result){
		String url = "list.jsp?nowPage=" + nowPage;
		out.print("<script>");
		out.print("alert('삭제되었습니다');");
		//out.print("history.go(-2);");
		out.print("</script>");
		response.sendRedirect(url);
	}
%>

	<form method="post" name="delFrm" action="delete.jsp">
		<table align="center" width="600px">
			<tr>
				<th>사용자의 비밀번호를 입력해주세요</th>
			</tr>
			<tr>
				<td align="center"><input type="password" name="pass" required></td>
			</tr>
			<tr>
				<td height="20px"></td>
			</tr>
			<tr>
				<td align="center">
					<input type="submit" value="삭제완료">
					<input type="reset" value="다시쓰기">
					<input type="button" value="뒤로" onclick="history.go(-1);">
				</td>
			</tr>
		</table>
		<input type="hidden" name="serv_num" value="<%=serv_num %>">
		<input type="hidden" name="nowPage" value="<%=nowPage %>">
	</form>
</body>
</html>