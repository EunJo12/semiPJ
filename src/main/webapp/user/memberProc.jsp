<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mgr" class="user.UserMgr" />
<jsp:useBean id="bean" class="user.UserBean" />
<jsp:setProperty property="*" name="bean" />			<!-- bean파일에 set한 값들을 가져올 수 있게 안그러면 일일이 키값들을 써야함 -->
<%
	boolean result = mgr.insertMember(bean);
	String msg = "회원가입에 실패하였습니다";
	String location = "member.jsp";
	if(result) {
		msg = "회원가입이 되었습니다";
		location = "login.jsp";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	alert("<%=msg%>");
	location.href = "<%=location%>";
</script>
</head>
<body>
	입력처리
</body>
</html>