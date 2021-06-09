<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %>

<html>
<head>

	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=ZCOOL+KuaiLe&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="./css/gongji_view.css">
</head>
<body>
	<form method=post name='fm'>
		<table width=650 border=1 cellspacing=0 cellpadding=5>
		
<%
	Integer id = Integer.parseInt(request.getParameter("id"));
	
	Class.forName("com.mysql.cj.jdbc.Driver"); 
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.76:3306/kopo37",                  
					"root" , "kopoctc");
	Statement stmt = conn.createStatement();
	
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
		out.println("<td><b>내용</b></td>");
		out.println("<td>" + rset.getString(4).replace("\r\n","<br>") + "</td>");
		out.println("</tr>");
	}
	rset.close();
	stmt.close();
	conn.close();
%>
	</table>
	<table>
		<tr>
			<td width=550></td>
			<td><input type=button value="목록" OnClick="location.href='gongji_list.jsp'"></td>
			<td><input type=button value="수정" OnClick="location.href='gongji_update.jsp?id=<%=id%>'"></td>
		</tr>
	</table>
	</form>
</body>
</html>