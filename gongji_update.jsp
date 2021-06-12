<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %>
<%@ page import="java.text.SimpleDateFormat,java.util.Date" %>

<html>
<head>

	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="./css/gongji_update.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>

		function submitForm(mode) {
			if (mode == 'write') {
				if ($("#title").val().replace(/\s/g,"").length == 0) {
					alert("제목을 입력해주세요");
					return false;
				} else if ($("#content").val().replace(/\s/g,"").length == 0) {
					alert("내용을 입력해주세요");
					return false;
				} else {
					fm.action = "gongji_write.jsp";
				}
			} else if (mode == 'delete') {
				fm.action = "gongji_delete.jsp";
			}
			fm.submit();
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
		
		$("#td_date").append("<input type='text' name='date' id='date' size=70 maxlength=70 value='" + today + "' readonly>");
		

	});
	</script>
</head>
<body>

<%
	Integer id = Integer.parseInt(request.getParameter("id"));
	Class.forName("com.mysql.cj.jdbc.Driver"); 
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.76:3306/kopo37", "root" , "kopoctc");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select * from gongji where id=" + id + ";");

	String title = "";
	String content = "";

	while (rset.next()) {
		title = rset.getString(2);
		content = rset.getString(4);
	}


	stmt.close();
	conn.close();


%>
<form method="post" name="fm">
	<table width="650" border="1" cellspacing="0" cellpadding="5">
		<tr>
			<td><b>번호</b></td>
			<td><input type="text" name="id" id="id" size="70" maxlength="70" value=<%=id%> readonly></td>
		</tr>
		<tr>
			<td><b>제목</b></td>
			<td><input type="text" name="title" id="title" size=70 maxlength=20 minlength="3" value="<%=title%>"></td>
		</tr>
		<tr>
			<td><b>일자</b></td>
			<td id="td_date">수정날짜 : </td>
		</tr>
		<tr>
			<td><b>내용</b></td>
			<td><textarea style='width:500px; height:250px;' name="content" id="content" cols=70 rows=600 minlength="1" maxlength="1000" ><%=content%></textarea></td>
		</tr>
	</table>
	<table>
	<tr>
		<td width=600></td>
		<td><input type="button" value="취소" OnClick="location.href='gongji_list.jsp?current_page=1'"></td>
		<td><input type="button" value="수정" OnClick="submitForm('write')"></td>
		<td><input type="button" value="삭제" OnClick="submitForm('delete')"></td>
	</tr>
	</table>
</form>
</body>
</html>