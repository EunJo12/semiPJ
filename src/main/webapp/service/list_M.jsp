<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, service.*" %>
<jsp:useBean id="sMgr" class="service.ServiceMgr" />
<%
/* 	String id = (String)session.getAttribute("idKey");
 	if(!id.equals("admin")) {
		out.print("<script>");
		out.print("alert('권한이 없습니다.');");
		out.print("location.href='../index.jsp'");
		out.print("</script>");
	} */

	request.setCharacterEncoding("utf-8");
	int totalRecord = 0; 			//전체레코드수(행수)
	int numPerPage = 10;			//한페이지당 레코드수
	int pagePerBlock = 5;			//블록당 보여줄 페이지 수 
	
	int totalPage = 0;				//전체페이지수 ex) 레코드수55개 페이지: [1][2][3][4][5][6]
	int totalBlock = 0;				//전체블록수   ex) 2

	int nowPage = 1; 				//현재 해당하는 페이지
	int nowBlock = 1; 				//현재 해당되는 블록

	int start =0;					//DB테이블이 select시작번호 //페이지 안의 시작하는 글 번호
	int end = 0;					//가져온 레코드중에서 10개씩만 가져오기
	int listSize = 0;				//현재 읽어온 게시물의 수
	
	String keyWord="", keyField="";
 	if(request.getParameter("keyWord") != null) {		//검색을 했을 때
 		keyWord = request.getParameter("keyWord");
 		keyField = request.getParameter("keyField");
 	}
 	
 	/* [처음으로]를 누를 때 */
 	if(request.getParameter("reload") != null) {
 		if(request.getParameter("reload").equals("true")){
 			keyWord = "";
 			keyField = "";
 		}
 	}
 	if(request.getParameter("nowPage") != null) {						//nowPage가 들어와 사용하기 위해선 int형 변환이 필요
 		nowPage = Integer.parseInt(request.getParameter("nowPage"));
 	}
 		
 	start = ((nowPage*numPerPage)-numPerPage) + 1;			//현재글의 nowPage를 넣으면 글이 들어가는 페이지의 첫시작 글번호를 내놓는 수식
 	end = nowPage*numPerPage;
 	totalRecord = sMgr.getTotalCount(keyField, keyWord);
 	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);		//전체페이수	: 더블로 해야 소수인 결과도 나옴 안그러면 0으로 처리됨
 	nowBlock = (int)Math.ceil((double)nowPage / pagePerBlock);			//현재블럭 계산
 	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);			//전체블럭 계산
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 서비스 관리</title>
<style>
	body {background-color : #B2CCFF; width:700px; margin:0 auto 0 auto; padding-top:50px; text-decoration:none;}
	table { border-style:none;}
	th {text-align:center; background-color:gray; color:white;}
	a:link{text-decoration:none; color:black;}
	a:hover{text-decoration:yes; color:purple;}
</style>
<script>
	function read_M(serv_num) {
		readFrm.serv_num.value = serv_num;
		readFrm.action = "read_M.jsp";
		readFrm.submit();
	}
	function list_M() {
		listFrm.action = "list_M.jsp";
		listFrm.submit();
	}
	function block(value) {
		readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1;
		readFrm.submit();
	}
	function pageing(page) {
		pageFrm.nowPage.value = page;
		pageFrm.submit();
	}
</script>
</head>
<body>
	<h2 align="center">관리자 서비스 관리</h2>
	<table width="700px">
		<tr>
			<%if(totalPage==0) {%>
			<td colspan="4">Total :<%=totalRecord %> Articles(0/<%=totalPage %>)Page</td>
			<%}else { %>
			<td colspan="4">Total :<%=totalRecord %> Articles(<%=nowPage %>/<%=totalPage %>)Page</td>
			<%} %>
		</tr>
		<tr>
			<th width="5%">번호</th>
			<th width="15%">서비스 등록번호</th>
			<th width="40%">서비스명</th>
			<th width="15%">업체명</th>
		</tr>
		<% 
			ArrayList<ServiceBean> alist = sMgr.getServiceList(keyField, keyWord, start, end);
			listSize = alist.size();
			
			for(int i=0; i<end; i++) {
				if(i == listSize)
					break;
				ServiceBean bean = alist.get(i);
				
				int serv_num = bean.getServ_num();
				String subject = bean.getServ_name();
				String corp = bean.getServ_corp();
		%>
		
		<tr>
			<td align="center"><%=totalRecord - (nowPage-1)*numPerPage-i %></td>
			<td>&nbsp;<%=serv_num %></td>
			<td>
				<a href="javascript:read_M('<%=serv_num%>')"><%=subject %></a>
			</td>
			<td><%=corp %></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="4"><br></td>
		</tr>
		<tr>
			<!-- 페이징처리 시작 -->
			<td colspan="3">
			<%
				int pageStart = (nowBlock-1) * pagePerBlock +1;	
				int pageEnd = pageStart + pagePerBlock <= totalPage ? pageStart + pagePerBlock : totalPage+1;
				if(totalPage != 0) {
					if(nowBlock > 1) {
			%>
						<a href="javascript:block('<%=nowBlock-1 %>')">prev...</a>&nbsp;
			<%
					}
					for(; pageStart<pageEnd; pageStart++) {
			%>
						<a href="javascript:pageing('<%=pageStart%>')">[<%=pageStart%>]</a>
			<%
					}
					if(totalBlock > nowBlock) {
			%>
						<a href="javascript:block('<%=nowBlock+1 %>')">...next</a>
			<%						
					}
				}
			%>
			</td>
			<td colspan="2" align="right">
				<a href="post.jsp">[서비스 업데이트]</a>
				<a href="javascript:list_M()">[처음으로]</a>
			</td>
		</tr>
	</table>
	<hr width="700"/>
	<form name="searchFrm" method="get" action="list_M.jsp">
		<table align="center" width="800">
			<tr>
				<td align="center">	
					<select name="keyField">
						<option value="serv_corp">업체명</option>
						<option value="serv_name">서비스명</option>
							<option value="region">지역별</option>
					</select>
					<input name="keyWord" required>				<!-- 찾기 버튼을 누를 때 반드시 입력해야할 값 -->
					<input type="submit" value="찾기">
					<input type="hidden" name="nowPage" value="1">
				</td>
			</tr>
		</table>
	</form>

	<!-- [처음으로] 누르면 화면이 reload -->
	<form name="listFrm" method="post">	
		<input type="hidden" name="reload" value="true">
		<input type="hidden" name="nowPage" value="1">
	</form>
	
	<form name="pageFrm" method="get">
		<% if(keyField != ""){ %>
		<input type="hidden" name="keyField" value="<%=keyField%>">
		<input type="hidden" name="keyWord" value="<%=keyWord%>">
		<%} %>
		<input type="hidden" name="nowPage">
	</form>
	
	<!-- 제목을 누르면 상세보기 페이지로 갈때 파라미터 값 -->
	<form name="readFrm" method="get">
		<input type="hidden" name="serv_num">
		<input type="hidden" name="nowPage" value="<%=nowPage%>">
		<% if(keyField != ""){ %>
		<input type="hidden" name="keyField" value="<%=keyField%>">
		<input type="hidden" name="keyWord" value="<%=keyWord%>">
		<%} %>
	</form>
	<input type="button" value="홈으로" onclick="location.href='../index.jsp'">
</body>
</html>