<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="uMgr" class="user.UserMgr" />
<%
    request.setCharacterEncoding("utf-8");
    String id = request.getParameter("id");
    String pwd = request.getParameter("pwd");
    
    boolean result = uMgr.loginMember(id, pwd);
    
    String msg = "로그인에 실패했습니다";
    if(result) {
    	session.setAttribute("idKey", id);
    	msg = "로그인이 되었습니다";
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	alert("<%=msg%>");
	location.href = "../index.jsp";
</script>
</head>
<body>

</body>
</html>