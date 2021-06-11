<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %>
<%@ page import="java.text.SimpleDateFormat,java.util.Date" %>

<html>
<head>

	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<link rel="stylesheet" href="./css/gongji_insert.css">

<script>
	function submitForm(mode) {
		if (document.getElementById("title").value == "") {
			alert("제목을 입력해주세요");
			console.log(document.getElementById("content").value);
			return false;
		}  else {
				fm.action = "gongji_write.jsp?key=INSERT";
				fm.submit();
			}
		}
	
	$(function() {
		var now = new Date();
		var year = now.getFullYear();
		
		var month = now.getMonth() + 1;
		if (month < 10) {
			month = "0" + month;
		}
		
		var date = now.getDate();
		if (date < 10) {
			date = "0" + date;
		}

		var hours = now.getHours();
		if (hours < 10) {
			hours = "0" + hours;
		}

		var minutes = now.getMinutes();
		if (minutes < 10) {
			minutes = "0" + minutes;
		}

		var seconds = now.getSeconds();
		if (seconds < 10) {
			seconds = "0" + seconds;
		}
		var today = year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds;
		
		$("#td_date").prepend(today + "<input type=hidden name='date' value='" + today + "'>");
		

	});

		
	
</script>

<style>
	#title, textarea:nth-child(1) {
 font-family: Jua, sans-serif;
}
</style>

</head>
<body>
	<form method=post name='fm'>
		<table width=650 border=1 cellspacing=0 cellpadding=5>
			<tr>
				<td><b>번호</b></td>
				<td>신규(insert)<input type=hidden name=id value='INSERT'></td>
			</tr>
			<tr>
				<td><b>제목</b></td>
				<td><input type=text name=title id=title size=70 maxlength=20 placeholder="제목을 입력해주세요"></td>
			</tr>
			<tr>
				<td>일자</td>
				<td id="td_date"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea style='width:500px; height:250px;' name=content cols=70 rows=600 minlength="1" maxlength="1000" placeholder="내용을 입력해주세요"></textarea></td>
			</tr>
		</table>
		<table>
			<tr>
				<td width=600></td>
				<td><input type=button value="취소" OnClick="location.href='gongji_list.jsp?current_page=1'"></td>
				<td><input type=button value="쓰기" OnClick="submitForm('write')"></td>
			</tr>
		</table>
	</form>
</body>
</html>                                                                                                              