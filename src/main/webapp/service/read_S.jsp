<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="service.ServiceBean" %>
<jsp:useBean id="sMgr" class="service.ServiceMgr" />
<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("idKey");
	
	int serv_num = Integer.parseInt(request.getParameter("serv_num"));
	String nowPage = request.getParameter("nowPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	
	ServiceBean bean = sMgr.getService(serv_num);
	session.setAttribute("bean", bean);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	
	function inputD() {
			 var sDate = new Date(document.revFrm.serv_dateS.value);
			 var eDate = new Date(document.revFrm.serv_dateE.value);
			 var today = new Date();
			 
			 console.log(revFrm.serv_dateS.value);
			 
			 if(eDate-sDate<0 || revFrm.serv_dateS.value==""){
				 alert("체크인과 체크아웃 날짜를 확인해주세요");
			 }else if(today > sDate){
				 alert("당일이나 지난 날짜는 불가합니다");
			 }else {			 
				 let day = (eDate-sDate)/86400000;
				 let sumP = <%=bean.getPrice() %>*day;
				 $("#sum").html("총 예약금 : "+sumP+"원");
				 revFrm.sum1.value = sumP;
				 $("#revBt").removeAttr('disabled');
			}
			 
		 }
		 

</script>


</head>
<body bgcolor="#DAD9FF">
	<form name="revFrm" method="post" action="../reservation/reservation.jsp">
		<table width="700" margin="0 auto">
			<tr>
				<th colspan="4">서비스상세</th>
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
				<td colspan="4" height="100px"><img src="../serFicUpload/<%=bean.getFilename() %>"></td>
			</tr>
			<tr>
				<td colspan="4" height="100px"><%=bean.getServ_detail() %></td>
			</tr>
			<!-- 예약폼 -->
			
			<tr>
				<td colspan="4">
					체크인<input type="date" name="serv_dateS" required>
					체크아웃<input type="date" name="serv_dateE" required>
				</td>		
			</tr>
			<tr>
				<td colspan="4" height="100px">
					가격(<%=bean.getPrice() %>/하루) - 체크인 당일에서 다음날까지를 1일로 계산합니다<br>
					<div id="sum" style="height:40px;">여기에 예약금이 표시됩니다</div>
					<input type="button" value="계산하기" onclick="inputD();">
				</td>
			</tr>
			<tr>
				<%if(id==null){ %>
				<td colspan="4">
					<input type="submit" value="예약하기" disabled>로그인하셔야 사용가능합니다
				</td>
				<%}else{ %>			
				<td colspan="4">
					<input type="submit" value="예약하기" id="revBt" disabled>계산하기를 눌러주세요
				</td>
				<% } %>
			</tr>
			<tr>
				<td colspan="4"><hr/></td>
			</tr>
	
			<tr align="center">
				<td colspan="4">
					[<a href="javascript:list()">리스트</a>]
				</td>
			</tr>
		</table>
		
		<input type="hidden" name ="sum1">
		<input type="hidden" name ="serv_num" value="<%=serv_num %>">
	
	</form>
	<form name="listFrm" method="post" action="list_S.jsp">
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