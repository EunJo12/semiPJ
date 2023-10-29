<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="uMgr" class="user.UserMgr" />
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	boolean result = uMgr.checkId(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	if(result) {
		out.print(id + "는 이미 존재하는 ID입니다<p/>");
	}else {
		out.print(id + "는 사용가능합니다<p/>");
	}
%>
<a href="#" onclick="self.close()">닫기</a>		<!-- self.close() : 현재 열린 창 닫기 -->
</body>
</html>