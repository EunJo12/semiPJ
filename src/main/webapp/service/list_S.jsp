<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("idKey");
%>
<jsp:include page="../header2.jsp" >
	<jsp:param value="서비스 목록" name="title"/>
</jsp:include>
<%@ page import="java.util.*, service.*" %>
<jsp:useBean id="sMgr" class="service.ServiceMgr" />
<%
	int totalRecord = 0; 			//전체레코드수(행수)
	int numPerPage = 8;			//한페이지당 레코드수
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
 	
 	/*카테고리로 리로드된 경우*/
	String cateKey="";
 	if(request.getParameter("cateKey") != null) {		//카테고리 검색 했을 때
 		cateKey = request.getParameter("cateKey");
 		totalRecord = sMgr.getTotalCountCate(cateKey);
 	}else{
 		totalRecord = sMgr.getTotalCount(keyField, keyWord);
 	}
 	
 	
 	/* [처음으로]를 누를 때 */
 	if(request.getParameter("reload") != null) {
 		if(request.getParameter("reload").equals("ture")){
 			keyWord = "";
 			keyField = "";
 		}
 	}
 	if(request.getParameter("nowPage") != null) {						//nowPage가 들어와 사용하기 위해선 int형 변환이 필요
 		nowPage = Integer.parseInt(request.getParameter("nowPage"));
 	}
 		
 	start = ((nowPage*numPerPage)-numPerPage) + 1;			//현재글의 nowPage를 넣으면 글이 들어가는 페이지의 첫시작 글번호를 내놓는 수식
 	end = nowPage*numPerPage;
 	
 	
 	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);		//전체페이수	: 더블로 해야 소수인 결과도 나옴 안그러면 0으로 처리됨
 	nowBlock = (int)Math.ceil((double)nowPage / pagePerBlock);			//현재블럭 계산
 	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);			//전체블럭 계산
%>
<script>
	function read_S(serv_num) {
		readFrm.serv_num.value = serv_num;
		readFrm.action = "read_S.jsp";
		readFrm.submit();
	}
	function list_S() {
		listFrm.action = "list_S.jsp";
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
	function cateSelect() {
		let cateKey = $("select[name=cate]").val();
		cateFrm.action = "list_S.jsp?cateKey="+cateKey;
		cateFrm.cateKey.value = cateKey;
		cateFrm.submit();
	}
	
	function loginNull() {
		alert("로그인해주세요");
	} 
</script>

	<div id="servicePage">
		<div>
			<%if(totalPage==0) {%>
			<div id="total">Total :<%=totalRecord %> Articles(0/<%=totalPage %>)Page</div>
			<%}else { %>
			<div id="total">Total :<%=totalRecord %> Articles(<%=nowPage %>/<%=totalPage %>)Page</div>
			<%} %>
				<!-- 카테고리 검색 -->
			<div id="cate">
				<form>
					카테고리 : 
					<select name="cate" onchange="javascript:cateSelect();">
						<option value="" selected>선택</option>
						<option value="소동물">소동물</option>
						<option value="강아지">강아지</option>
						<option value="고양이">고양이</option>
					</select>
				</form>
			</div>
		</div>
			
		<div id="listA"> <!-- 전체틀 -->
			<ul>  <!-- 상품리스트 -->
			
		<% 
			ArrayList<ServiceBean> alist;
			if(cateKey ==null){
				alist = sMgr.getServiceList(keyField, keyWord, start, end);
			}else{
				alist = sMgr.getServiceListCate(keyField, keyWord, cateKey, start, end);
			}
			
			listSize = alist.size();
			
			for(int i=0; i<end; i++) {
				if(i == listSize)
					break;
				ServiceBean bean = alist.get(i);
				
				int serv_num = bean.getServ_num();
				String subject = bean.getServ_name();
				String corp = bean.getServ_corp();
				String filename = bean.getFilename();
			
		%>
			<a href="javascript:read_S('<%=serv_num%>')">
				<li class="li1">
					<div class="div1">
						<img src="../serFicUpload/<%=filename%>">
					</div>
					<div class="div2">
						<%=subject %>
					</div>
					<div class="div3">
						><%=corp %>
					</div>
				</li>
			</a>
		<%
			}
		%>
			
			</ul>
		</div>
		<br>
		<table>
			<tr>
				<!-- 페이징처리 시작 -->
				<td>
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
			</tr>
		</table>
		<br>
		<hr width="950">
		<br>
		<form name="searchFrm" method="get" action="list_S.jsp">
			<table>
				<tr>
					<td>	
						<select name="keyField">
							<option value="serv_corp">업체명</option>
							<option value="serv_name">서비스명</option>
							<option value="region">지역별</option>
						</select>
						<input name="keyWord" required>				<!-- 찾기 버튼을 누를 때 반드시 입력해야할 값 -->
						<input class="searchBtn" type="submit" value="찾기">
						<input type="hidden" name="nowPage" value="1">
					</td>
					<td>  
						<a href="javascript:list_S();">&emsp;[처음으로]</a>
					</td>
				</tr>
			</table>
		</form>
	
		<!-- [처음으로] 누르면 화면이 reload -->
		<form name="listFrm" method="post">
			<input type="hidden" name="reload" value="true">
			<input type="hidden" name="nowPage" value="1">
		</form>
		
		<!-- 제목을 누르면 상세보기 페이지로 갈때 파라미터 값 -->
		<form name="readFrm" method="get">
			<input type="hidden" name="serv_num">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<%if(keyWord != ""){ %>
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<%} %>
		</form>
		
		<form name="pageFrm" method="get">
			<% if(keyField != ""){ %>
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<%}else if(cateKey !="") { %>
			<input type="hidden" name="cateKey" value="<%=cateKey%>">
			<%} %>
			<input type="hidden" name="nowPage">
		</form>
		
		<form name="cateFrm" method="get" action="list_S.jsp">
			<input type="hidden" name="cateKey">
			<input type="hidden" name="nowPage" value="1">
		</form>
	
	</div>

<jsp:include page="../footer.jsp" ></jsp:include>