<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="service.ServiceBean" %>
<%

	int serv_num = Integer.parseInt(request.getParameter("serv_num")); //read.jsp에서 수정을 눌렀을 때 href로 넘겨오는 num값을 받아쓰기
	String nowPage = request.getParameter("nowPage");
	
	ServiceBean bean = (ServiceBean)session.getAttribute("bean");
	String corp = bean.getServ_corp();
	String subject = bean.getServ_name();
	String content = bean.getServ_detail();
	String category = bean.getServ_category();
	String region = bean.getRegion();
	int price = bean.getPrice();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body {background-color : #B2CCFF; width:700px; margin:0 auto 0 auto; padding-top:50px;}
	a {color : black;}
	th {background-color : white; text-align:center;}
</style>
</head>
<body>
	<form method="post" name="updateFrm" action="servBoardUpdate">		<!-- 파일수정은 뺄거라 -->
		<table>
			<tr>
				<th colspan="2">수정하기</th>
			</tr>
			<tr>
				<td width="20%">업체명 </td>
				<td width="80%"><input name="corp" size="5" value="<%=corp %>"></td>
			</tr>
			<tr>
				<td>서비스명 </td>
				<td><input name="subject" size="30" value="<%=subject %>"></td>
			</tr>
			<tr>
				<td>카테고리 </td>
				<td><input name="category" size="30" value="<%=category %>"></td>
			</tr>
			<tr>
				<td>제공지역 </td>
				<td><input name="region" size="30" value="<%=region %>"></td>
			</tr>
			<tr>
				<td>가격 </td>
				<td><input name="price" size="30" value="<%=price %>"></td>
			</tr>
			<tr>
				<td>상세설명 </td>
				<td><textarea name="content" cols="40" rows="10"><%=content %></textarea></td>
			</tr>

			<tr>
				<td colspan="2"><hr/></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정완료">
					<input type="reset" value="다시수정">
					<input type="button" value="뒤로" onclick="history.back();">
				</td>
			</tr>
		</table>
		<input type="hidden" name="serv_num" value="<%=serv_num %>">
		<input type="hidden" name="nowPage" value="<%=nowPage %>">
	</form>

</body>
</html>