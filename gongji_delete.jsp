<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %>

<html>
<head>
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
	<link rel="stylesheet" href="./css/gongji_delete.css">
</head>
<body>

<%
	Class.forName("com.mysql.cj.jdbc.Driver"); 
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.76:3306/kopo37", "root" , "kopoctc");
	Statement stmt = conn.createStatement();

	Integer id = Integer.parseInt(request.getParameter("id"));
%>
	<div id="container">
	<div id="successImg">
		<i class="far fa-check-circle"></i>
	</div>
	<div id="successMsg">
<%
	stmt.execute("delete from gongji where id = " + id + ";");
	
	stmt.close();
	conn.close();
%>
	<p>게시글 삭제가 완료되었습니다.</p>
</div>
<div id="btnArea">
	<button id="goToListBtn" onclick="location.href='gongji_list.jsp'">리스트보기</button>
</div>
</div>

</body>
</html>