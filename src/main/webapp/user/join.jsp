<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<style>
	body{}
	#joinPage{width:1000px;}
</style>
<script src="../resource/js/script.js" type="text/javascript" charset="utf-8"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function findAddr(){
	    new daum.Postcode({
	        oncomplete: function(data) {
				let roadAddr = data.roadAddress;
				let jibunAddr = data.jibunAddress;
				let extraAddr = '';
				
				document.getElementById("postcode").value = data.zonecode;	
				if(data.userSelectedType == 'R'){
					if(roadAddr != '') {
						if(data.bname != '') {	
							extraAddr += data.bname;
						} 
						if(data.buildingName !='') {
							extraAddr += extraAddr != '' ? ', ' + data.buildingName : data.buildingName;
						}
						roadAddr += extraAddr != '' ? '(' + extraAddr + ')' : '';
						document.getElementById("addr").value = roadAddr;
					}
				} else if(data.userSelectedType== 'J'){
					document.getElementById("addr").value = jibunAddr;
				}
								
				document.getElementById("detailAddr").focus();
	        }
	    }).open();
	}
</script>
</head>
<body>
	<div id="joinPage">
		<form name="regFrm" method="post" action="userProc.jsp">
			<table border="1" style="border-collapse: collapse;">
				<thead>
				<tr>
				    <th colspan="3" align="center" style="height: 30px;">회원가입</th>
				</tr>
				</thead>
				<tr>
				    <td width="13%">아이디</td>
				    <td>
				    	<input name="id" onkeydown="inputIdChk();">	
				    	<input type="button" value="ID중복확인" onclick="idCheck(this.form.id.value)">
				    	<input type="hidden" name="idbtncheck" value="idUncheck">
				    </td>
				    <td>영문과 숫자로만 입력</td>
				</tr>
				<tr>
				    <td>패스워드</td>
				    <td><input type="password" name="pwd"></td>
				    <td>특수기호, 영문, 숫자가 각 1개 이상씩 들어가야 되고 8글자 이상</td>
				</tr>
				<tr>
				    <td>패스워드 확인</td>
				    <td><input type="password" name="repwd"></td>
				    <td>위의 비밀번호를 한번 더 넣으세요</td>
				</tr>
				<tr>
				    <td>이름</td>
				    <td><input name="name"></td>
				    <td>한글로 입력</td>
				</tr>
				<tr>
				    <td>성별</td>
				    <td>
				        <input type="radio" name="gender" value="m" id="m" checked>남 &emsp;
				        <input type="radio" name="gender" value="f" id="f">여
				    </td>
				    <td>성별을 선택해주세요</td>
				</tr>
				<tr>
				    <td>생년월일</td>
				    <td><input name="birthday"></td>
				    <td>6글자로 입력. ex) 190315</td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><input name="phone"></td>
					<td>하이폰(-)을 넣어주세요 ex) 010-1234-5678</td>
				</tr>
				
				<tr>
				    <td>E-mail</td>
				    <td><input type="email" name="email" size="30"></td>
				    <td>ex) email@naver.com</td>
				</tr>
				<tr>
				    <td>우편번호</td>
				    <td><input name="zipcode" id="postcode" readonly><input type="button" value="우편번호 찾기" onclick="findAddr();"></td>
				    <td>우편번호를 검색하세요</td>
				</tr>
				<tr>
				    <td>주소</td>
				    <td><input name="address" id="addr" size="60" readonly>
				        <input name="detailAddr" id="detailAddr">
				    </td>
				    <td>상세주소가 있으면 입력해주세요</td>
				</tr>
				<tr align="center">
				    <td colspan="3">
				        <input type="button" value="회원가입" onclick="inputCheck();">&emsp;
				        <input type="reset" value="다시쓰기">&emsp;
				        <input type="button" value="취소" onclick="history.back();">
				    </td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>