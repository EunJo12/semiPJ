<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/header.jsp" >
	<jsp:param value="펫홀릭스" name="title"/>
</jsp:include>
<script>
	function listCategory(category) {
		categoryFrm.cateKey.value = category;
		categoryFrm.action = "service/list_S.jsp";
		categoryFrm.submit();
	}

</script>
    <div id="mainPage">
		<section class="icon">
	      <div class="imgbtn" onclick="javascript:listCategory('강아지');">
	        <img src="resource/img/강아지.png"><br>
	        <button>강아지 호텔링</button>
	      </div>
	      <div class="imgbtn" onclick="javascript:listCategory('고양이');">
	        <img src="resource/img/고양이.png"><br>
	        <button>고양이 호텔링</button>
	      </div>
	      <div class="imgbtn" onclick="javascript:listCategory('소동물');">
	        <img src="resource/img/소동물.png"><br>
	        <button>소동물 호텔링</button>
	      </div>
	    </section>

		<br><br><br><br><br><br><br><br><br><hr>


		<form name="categoryFrm" method="get">
			<input type="hidden" name="cateKey">
			<input type="hidden" name="nowpage" value=1>
		</form>
    </div>
    
<jsp:include page="/footer.jsp" ></jsp:include>