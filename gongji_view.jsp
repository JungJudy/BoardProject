<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %>

<html>
<head>

	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=ZCOOL+KuaiLe&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="./css/gongji_view.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
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
		
		$("#comments_date").val(today);

	});
	</script>
</head>
<body>
	<section id="s1">
		<div>
			<form method=post name='fm'>
				<table width=650 border=1 cellspacing=0 cellpadding=5>
		
<%
	Integer id = Integer.parseInt(request.getParameter("id"));
	
	Class.forName("com.mysql.cj.jdbc.Driver"); 
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.76:3306/kopo37",                  
					"root" , "kopoctc");
	Statement stmt = conn.createStatement();
	stmt.execute("update gongji set viewCnt = viewCnt+1 where id=" + id + ";");
	ResultSet rset = stmt.executeQuery("select * from gongji where id=" + id + ";");
	
	while(rset.next()) {
		

		out.println("<tr>");
		out.println("<td><b>번호</b></td>");
		out.println("<td>" + id + "</td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td><b>제목</b></td>");
		out.println("<td>" + rset.getString(2) + "</td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td><b>일자</b></td>");
		out.println("<td>" + rset.getString(3) + "</td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td><b>조회수</b></td>");
		out.println("<td>" + rset.getString(5) + "</td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td><b>내용</b></td>");
		out.println("<td>" + rset.getString(4).replace("\r\n","<br>") + "</td>");
		out.println("</tr>");
	}
	rset.close();
	
%>
				</table>
				<table id="button">
					<tr>
						<td width=550></td>
						<td><input type=button value="목록" OnClick="location.href='gongji_list.jsp?current_page=1'"></td>
						<td><input type=button value="수정" OnClick="location.href='gongji_update.jsp?id=<%=id%>'"></td>
					</tr>
				</table>
			</form>
		</div>
		<div>
	
<%	
	Integer comments_is = 0;
	ResultSet rset2 = stmt.executeQuery("select count(*) from comments where postid=" + id + ";");
	
	while (rset2.next()) {
		comments_is = rset2.getInt(1);
	}
	rset2.close();

	if (comments_is == 0) {
		out.println("<p>댓글이 없습니다.</p><hr>");
	} else {
		ResultSet rset3 = stmt.executeQuery("select * from comments where postid=" + id + ";");
%>
		<hr>
		<table width="600">
<%		
		while (rset3.next()) {
			out.println("<tr id='tr_comments'>");
			out.println("<td id='co_user'>" + rset3.getString(3) + "<br><sapn id='co_date'>" + rset3.getString(5) + "</sapn></td>");
			out.println("<td id='co_content'>" + rset3.getString(4) + "</td>");
			out.println("</tr>");
		}
		rset3.close();
		out.println("</table>");
		out.println("<hr>");
	}

	stmt.close();
	conn.close();
%>			

			<table id="comments">
				<tr>
					<td><input type="text" id="comments_user" placeholder="작성자를 입력해주세요">
						<br><input type="text" id="comments_date"></td>
					<td><textarea name="comments_content" id="comments_content" cols="50" rows="5" placeholder="욕설,비방X."></textarea></td>
					<td id="td_comment_button"><span id="comment_button">입력</span></td>
				</tr>
			</table>
		</div>
	</section>
</body>
</html>