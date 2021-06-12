<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %>

<html>
<head>

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=ZCOOL+KuaiLe&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="./css/gongji_list.css">

<script>
	function search() {
		let search_title = $("#search").val();
		if (search_title.replace(/\s/g,"").length == 0) {
			alert("검색 내용을 입력해주세요")
		} else {
			window.location="gongji_search.jsp?search_title=" + search_title + "";
		}
		
	}
</script>
</head>
<body>
<%
	Class.forName("com.mysql.cj.jdbc.Driver"); 
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.76:3306/kopo37", "root" , "kopoctc");
	Statement stmt = conn.createStatement();
	
	ResultSet rset2 = stmt.executeQuery("select count(*) from gongji;");
	Integer gongji_is = 0;
	
	while(rset2.next()) {
		gongji_is = rset2.getInt(1);
	}
	rset2.close();
	
	
	if (gongji_is == 0) {
		
%>
<p class='table-outer'>공지사항이 없습니다.<input type=button value='신규' OnClick='window.location="gongji_insert.jsp"' align="left"></p>
<%
		
	} else {
		
	
%>
<div class="table-outer">
<table cellspacing=1 width=600 border=1>
	<tr id="tr_id">
		<th>번호</th>
		<th>제목</th>
		<th>등록일</th>
		<th>조회수</th>
	</tr>

<%
	Integer totalCnt = gongji_is; //총게시글 수
	Integer CntLIst = 10; //한 페이지에 표시될 게시글 수
	Integer totalPage = totalCnt/CntLIst; //총 페이지 수

	if (totalCnt % CntLIst > 0) {
		totalPage++;
	}

	Integer current_page = 1; //현재페이지
	current_page = Integer.parseInt(request.getParameter("current_page"));
	Integer countPage = 10; //하단에 표시될 페이지 수

	if (totalPage < current_page) {
		current_page = totalPage;
	}

	Integer startPage = ((current_page - 1) / countPage) * countPage + 1; //시작페이지
	Integer endPage = startPage + countPage - 1; //끝 페이지

	if (endPage > totalPage) {
		endPage = totalPage;
	}

	//첫페이지
	out.println("<a href=\"?current_page=1\" id='start'>   <<   </a>");
	
	//이전페이지
	if (current_page == 1) {
		out.println("<a href=\"?current_page=" + (current_page) +  "\" id='pn'>  <  </a>");
	} else {
		out.println("<a href=\"?current_page=" + (current_page - 1) +  "\" id='pn'>  <  </a>");
	}
	
	//페이지들
	for (int iCnt = startPage; iCnt <= endPage; iCnt++) {
		if (iCnt == current_page) {
			out.println("<b id='b'>" + iCnt +"</b>");
		} else {
			out.println("<a href='?current_page=" + iCnt + "'> " + iCnt + " </a>");
		}
		
	} 

	//다음페이지
	if (current_page == totalPage) {
		out.println("<a href=\"?current_page=" + (current_page) + "\" id='pn'>  >  </a>");
	} else {
		out.println("<a href=\"?current_page=" + (current_page + 1) + "\" id='pn'>  >  </a>");
	}

	//끝페이지
	out.println("<a href=\"?current_page=" + totalPage + "\" id='end'>   >>   </a>");
	

	ResultSet rset = stmt.executeQuery("select * from gongji order by id desc limit " + ((current_page - 1) * CntLIst) + "," + CntLIst + ";");

		while(rset.next()) {
			out.println("<tr align=center>");
			out.println("<td width=300>" + rset.getInt(1) + "</td>");
			out.println("<td width=500><a href='gongji_view.jsp?id="+rset.getInt(1)+"'>" + rset.getString(2) + "</td>");
			out.println("<td width=500>" + rset.getString(3) + "</td>");
			out.println("<td width=100>" + rset.getString(5) + "</td>");
			out.println("<tr>");
		}
	
		rset.close();
		stmt.close();
		conn.close();
		
		
	
%>
</table>

<table cellspacing=1 width=600 border=0>
	<tr>
		<td width=600><input type="text" id="search" name="search" placeholder="제목 검색"><button onclick="search()">검색</button></td>
		<td><input type=button value="신규" id="new" OnClick="window.location='gongji_insert.jsp'"></td>
	</tr>
</table>
</div>
<%
	}
%>
</body>
</html>