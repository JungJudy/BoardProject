<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %> 

<html>
<head>

	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
	<link rel="stylesheet" href="./css/gongji_write.css">
</head>
<body>

<%
	Class.forName("com.mysql.cj.jdbc.Driver"); 
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.76:3306/kopo37", "root" , "kopoctc");
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("utf-8");
	String title = request.getParameter("title");
	String date = request.getParameter("date");
	String content = request.getParameter("content");
	String id = request.getParameter("id");

	String query = "";
	%>
	<div id="container">
		<div id="successImg">
			<i class="far fa-check-circle"></i>
		</div>
		<div id="successMsg">
	<%
	if (id.equals("INSERT") == true) {
		query = "insert into gongji(title,date,content) values('" + title + "','" + date + "','" + content + "');";
		out.println("<p>게시글 작성이 완료되었습니다.</p>");
	} else {
		Integer i_id = Integer.parseInt(id);
		query = "update gongji set title ='" + title + "', date = '" + date + "', content = '" + content + "' where id = " + i_id + ";";
		out.println("<p>게시글 수정이 완료되었습니다.</p>");
	}

	stmt.execute(query);
	
	stmt.close();
	conn.close();
%>


	</div>
	<div id="btnArea">
		<button id="goToListBtn" onclick="location.href='gongji_list.jsp?current_page=1'">리스트보기</button>
	</div>
</div>

</body>
</html>