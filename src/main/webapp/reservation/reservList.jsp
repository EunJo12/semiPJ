<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, service.*, reservation.*, java.text.*" %>
<jsp:useBean id="rMgr" class="reservation.ReservMgr" />
<jsp:useBean id="sMgr" class="service.ServiceMgr" />
<%
	String id = (String)session.getAttribute("idKey");
	if(id==null) {
		out.print("<script>");
		out.print("alert('로그인해주세요');");
		out.print("location.href='../index.jsp'");
		out.print("</script>");
	}

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
	
 	if(request.getParameter("nowPage") != null) {						//nowPage가 들어와 사용하기 위해선 int형 변환이 필요
 		nowPage = Integer.parseInt(request.getParameter("nowPage"));
 	}
 		
 	start = ((nowPage*numPerPage)-numPerPage) + 1;			//현재글의 nowPage를 넣으면 글이 들어가는 페이지의 첫시작 글번호를 내놓는 수식
 	end = nowPage*numPerPage;
 	totalRecord = rMgr.getTotalCount(id);
 	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);		//전체페이수	: 더블로 해야 소수인 결과도 나옴 안그러면 0으로 처리됨
 	nowBlock = (int)Math.ceil((double)nowPage / pagePerBlock);			//현재블럭 계산
 	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);			//전체블럭 계산
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<style>
	body {background-color : #B2CCFF; width:800px; margin:0 auto 0 auto; padding-top:50px; text-decoration:none;}
	table { border-style:none;}
	th {text-align:center; background-color:gray; color:white;}
	a:link{text-decoration:none; color:black;}
	a:hover{text-decoration:yes; color:purple;}
</style>
<script>

	function read(serv_num) {
		readFrm.serv_num.value = serv_num;
		readFrm.action = "../service/read_S.jsp";
		readFrm.submit();
	}
	function reList() {
		listFrm.action = "reservList.jsp";
		listFrm.submit();
	}
	function block(value) {
		readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1;
		readFrm.submit();
	}
	function pageing(page) {
		readFrm.nowPage.value = page;
		readFrm.submit();
	}
	function reservDel(reserv_num) {
		let yn = confirm("삭제하겠습니까?");
		if(yn){
			$.ajax({
				url:"delListRerv",
				data:{
					reserv_num:reserv_num
				},
				type:"post",
				success:function(result) {
					if(result){
						location.href="reservList.jsp";
					}else{
						alert("삭제실패");
					}
				},
				error:function() {
					console.log("삭제 ajax 통신 실패");
				}
			});
		}
	}
	
</script>

</head>
<body>
	<%if(id.equals("admin")) {%>
	<h2 align="center">예약현황-관리자</h2>
	<%}else {%>
	<h2 align="center">예약현황</h2>
	<% }%>
	<table width="800px">
		<tr>
			<td colspan="7">Total :<%=totalRecord %> Articles(<%=nowPage %>/<%=totalPage %>)Page</td>

		</tr>
		<tr>
			<th width="5%">번호</th>
			<th width="10%">예약번호</th>
			<th width="35%">서비스명</th>
			<th width="10%">업체명</th>
			<th width="20%">서비스 예정날짜</th>
			<th width="10%">카테고리</th>
			<th width="10%">예약취소</th>
		</tr>
		<% 
			ArrayList<ReservBean> alist = rMgr.getReservationList(start, end, id);
			listSize = alist.size();
			
						
			
			for(int i=0; i<end; i++) {
				if(i == listSize)
					break;
				ReservBean bean = alist.get(i);

				int reserv_num = bean.getReserv_num();
				int serv_num = bean.getServ_num();
				String serv_date = bean.getServ_date();
				String reserv_date = bean.getReserv_date();
				int reserv_price = bean.getReserv_price();
				
				String dd = serv_date.substring(0,10);
				boolean dday = rMgr.calcReservDay(dd);
				
				if(serv_num != 0){
					ServiceBean sBean = sMgr.getService(serv_num);
					String corp = sBean.getServ_corp();
					String category = sBean.getServ_category();
					String subject = sBean.getServ_name();
					
			%>
		<tr>
			<td><%=totalRecord - (nowPage-1)*numPerPage-i %></td>
			<td><%=reserv_num %></td>
			<td>
				<a href="javascript:read('<%=serv_num%>')"><%=subject %></a>
			</td>
			<td><%=corp %></td>
			<td><%=serv_date %></td>
			<td><%=category %></td>
			
			
			<%if(dday){ %>
			
			<td><input type="button" value="예약취소" onclick="javascript:reservDel(<%=reserv_num %>);"></td>
			
			<%}else{ %>
			<td>완료</td>
			<%} %>
			
		</tr>
			<%
				}else {
				 	String corp = "";
					String category = "";
					String subject = "삭제된 서비스입니다";
		%>
		<tr>
			<td><%=totalRecord - (nowPage-1)*numPerPage-i %></td>
			<td><%=reserv_num %></td>
			<td>
				<%=subject %></a>
			</td>
			<td><%=corp %></td>
			<td><%=serv_date %></td>
			<td><%=category %></td>
			<td><input type="button" value="예약취소" disabled></td>
		</tr>
		<%
				}
			}
		%>
		<tr>
			<td colspan="4"><br></td>
		</tr>
		<tr>
			<!-- 페이징처리 시작 -->
			<td colspan="3" align="right">
			<%
			// 블럭 1 [1][2][3][4][5] 	블럭2 [6][7][8][9][10]	블럭2 [11][12][13]...
				int pageStart = (nowBlock-1) * pagePerBlock +1;		//블럭1 = 1, 블럭2 =6, 블럭3=11 시작맞추기		//noBlock이 1일 때 곱하기 0으로 만들어버리고 거기에 첫시작은 1이 되게
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
			<!-- 페이징처리 끝 -->
			<td colspan="4" align="right">
				<a href="javascript:list_M()">[처음으로]</a>
			</td>
		</tr>
	</table>
	<hr width="800"/>

	<!-- [처음으로] 누르면 화면이 reload -->
	<form name="listFrm" method="post">	
		<input type="hidden" name="reload" value="true">
		<input type="hidden" name="nowPage" value="1">
	</form>
	
	<!-- 제목을 누르면 상세보기 페이지로 갈때 파라미터 값 -->
	<form name="readFrm" method="get">
		<input type="hidden" name="serv_num">
		<input type="hidden" name="nowPage" value="<%=nowPage%>">
	</form>
	<input type="button" value="홈으로" onclick="location.href='../index.jsp'">


</body>
</html>