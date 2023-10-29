<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서비스 등록</title>
<style>
	body {background-color : #B2CCFF; width:700px; margin:0 auto 0 auto; padding-top:50px;}
	a {color : black;}
	th {background-color : white; text-align:center;}
</style>
<script src="../resource/js/region.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
	<form method="post" name="postFrm" action="servBoardPost" enctype="multipart/form-data">
		<table>
			<tr>
				<th colspan="2">서비스 등록</th>
			</tr>
			<tr>
				<td width="20%">서비스업체 </td>
				<td width="80%"><input name="serv_corp" size="30"></td>
			</tr>
			<tr>
				<td>서비스명 </td>
				<td><input name="subject" size="30"></td>
			</tr>
			<tr>
				<td>카테고리 </td>
				<td> 
					<select name="category">
						<option value="강아지">강아지</option>
						<option value="고양이">고양이</option>
						<option value="소동물">소동물</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>가격 </td>
				<td> <input name="price"></td>
			</tr>
			<tr>
				<td>제공지역 </td>
				<td> 
					<select name="region1" onChange="region1_change(this.value, region2)">
						<option>-선택-</option>
						<option value='1'>서울</option>
						<option value='2'>부산</option>
						<option value='3'>대구</option>
						<option value='4'>인천</option>
						<option value='5'>광주</option>
						<option value='6'>대전</option>
						<option value='7'>울산</option>
						<option value='8'>강원</option>
						<option value='9'>경기</option>
						<option value='10'>경남</option>
						<option value='11'>경북</option>
						<option value='12' >전남</option>
						<option value='13'>전북</option>
						<option value='14'>제주</option>
						<option value='15'>충남</option>
						<option value='16'>충북</option>
					</select>
					<select name="region2" onChange="region2_change(region1.value, this.value)">
					  <option>-선택-</option>
					</select>
					<input type="hidden" name="re1">
					<input type="hidden" name="re2">
				</td>
			</tr>
			
			<tr>
				<td>내용 </td>
				<td><textarea name="content" cols="40" rows="10"></textarea></td>
			</tr>
			<tr>
				<td>파일찾기 </td>
				<td><input type="file" name="filename"></td>
			</tr>
			<tr>
				<td colspan="2"><hr/></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="등록">
					<input type="reset" value="다시쓰기">
					<input type="button" value="리스트" onclick="location.href='list_M.jsp'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>