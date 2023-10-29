<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("idKey");
%>
<%@ page import="java.util.*, service.*" %>
<jsp:useBean id="sMgr" class="service.ServiceMgr" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫홀릭스</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script src="resource/js/script.js" type="text/javascript" charset="utf-8"></script>
<link href="resource/css/Semistyle.css" rel="stylesheet">
<script>
	function loginNull() {
		alert("로그인해주세요");
	} 

</script>
</head>
<body>
    <header>
       	<a href="index.jsp"><img src="resource/img/logo1.png" width="150px" id="logo"></a>
       	<% if(id == null) { %>
        <div class="login">
            <form method="post" action="user/loginProc.jsp">
                <table id="loginTable">
                    <tr class="loginT">
                        <td class="loginT">
                            <input id="id" name="id" type="text" placeholder="아이디 입력">
                        </td>
                        <td rowspan="2" class="loginT">
                            <button type="submit" id="login">로그인</button>
                        </td>
                    </tr>
                    <tr class="loginT">
                        <td class="loginT">
                            <input id="pwd" name="pwd" type="password" placeholder="비밀번호 입력">
                        </td>
                    </tr>
                    <tr class="loginT">
                        <td colspan="2" class="loginT" align="center">
                            <a href="user/join.jsp">회원가입</a>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <%}else if(id.equals("admin")) {%>
        	<div class="login">
		        <h4><img src="resource/img/user1.png" width="20px"><%=id %>님 환영합니다</h4>
				<a href="user/logout.jsp">로그아웃</a>&emsp;<a href="service/list_M.jsp">서비스 관리</a>
			</div>
        <%}else {%>
        <div class="login">
	        <h4><img src="resource/img/user1.png" width="20px"><%=id %>님 환영합니다</h4>
			<a href="reservation/reservList.jsp">예약리스트</a>&emsp;<a href="user/logout.jsp">로그아웃</a>
		</div>
        <% } %>

        <nav class="nav1">
        	<a href="about.jsp">펫홀릭스</a>
        	<a href="service/list_S.jsp">서비스</a>
        	<% if(id != null) { %>
        	<a href="reservation/reservList.jsp">예약현황</a>
        	<%}else {
        		%>
            	<a href="#" onclick="javascript:loginNull();">예약현황</a>
        	<%}%>
        </nav>
        
    </header>
